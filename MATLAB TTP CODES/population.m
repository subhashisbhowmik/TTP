classdef population <handle
    properties (Access = public)
        data = [];
        stat=[];
        size=100;
        xOverRate=0.9;
        mutationRate=0.1;
        elites=3;
        TTPSetObject=0;
        parentLimit=20;
        randomNew=20;
        mutationChance=0.5;
        DE=0;
        g=0;
        alpha=2;
    end
    methods (Access=public)
        %Constructor function. After assigning properties, initialize with
        %random elements.
        function obj = population(TTPSetObject,size,xOverRate,mutationRate,mutationChance,elites,parentLimit,randomNew,DE,gaussian,alpha)
            obj.size = size;
            obj.randomNew=randomNew;
            obj.TTPSetObject=TTPSetObject;
            obj.xOverRate=xOverRate;
            obj.mutationRate=mutationRate;
            obj.mutationChance=mutationChance;
            obj.elites=elites;
            obj.parentLimit=parentLimit;
            obj.DE=DE;
            obj.g=gaussian;
            obj.alpha=alpha;
            obj.init()
        end
        %Initialize with random chromosomes
        function init(obj)
            maxSize=0;
            obj.data=[];
            obj.stat=[];
            for i=1:length(obj.TTPSetObject.valuableList)
                if maxSize<length(obj.TTPSetObject.valuableList(i).data)
                    maxSize=length(obj.TTPSetObject.valuableList(i).data);
                end
            end
            while length(obj.data)<obj.size
                obj.data=[obj.data randomChromosome(obj.TTPSetObject,maxSize)];
            end
            obj.stat=obj.bestChromo(1).cost;
        end
        %Finds chromosomes with lowest costs. Efficient for small no. of
        %chromosomes.
        function bests=bestChromo2(obj,number)
            chromoArray=obj.data;
            bests=[];
            while length(bests)<number
                bestIndex=1;
                bestCost=Inf;
                for i=1:length(chromoArray)
                    if chromoArray(i).cost<bestCost
                        bestCost=chromoArray(i).cost;
                        bestIndex=i;
                    end
                end
                bests=[bests chromoArray(bestIndex)];
                chromoArray(bestIndex)=[];
            end
        end
        %Sorts and gives chromosomes with the lowest costs. Efficient with
        %high no. of selection.
        function bests=bestChromo(obj,number)
            chromoArray=obj.data;
            bests=[];
            [~,I]=sort([chromoArray.cost]);
            %I=fliplr(I);
            for i=1:number
                %               ind=find(I==i);
                bests=[bests chromoArray(I(i))];
            end
        end
        %Calculates next generation, with elites, and random chromosomes.
        %rest with mutated crossings.
        function c=nextGen(obj)
            possibleParents=obj.bestChromo(obj.size);
            
            newGen=possibleParents(1:obj.elites);
            parentSet=possibleParents(1:obj.parentLimit);
            l=length(newGen);
            
            while length(newGen)<obj.randomNew+l
                maxSize=0;
                for i=1:length(obj.TTPSetObject.valuableList)
                    if maxSize<length(obj.TTPSetObject.valuableList(i).data)
                        maxSize=length(obj.TTPSetObject.valuableList(i).data);
                    end
                end
                newGen=[newGen randomChromosome(obj.TTPSetObject,maxSize)];
            end
            while length(newGen)<obj.size
                newCh=0;
                if obj.DE==0
                    if rand()<obj.xOverRate
                        [p1,i]=obj.selectParent(parentSet);
                        %parentSet(i)=[];
                        if obj.g==0
                            newCh=perm_Uni_Cross(p1,obj.selectParent(parentSet));
                        else 
                            newCh=gauss_Uni_Cross(p1,obj.selectParent(parentSet),obj.alpha,obj.TTPSetObject.distanceMatrix);
                        end
                    else
                        newCh=obj.selectParent(parentSet);
                    end
                    if rand()<obj.mutationRate
                        newCh=exc_Inv_Mutate(newCh,1,0);
                    end
                    if rand()<obj.mutationRate
                        if obj.mutationChance>0
                            newCh=exc_ChanceInv_Mutate(newCh,0,1,obj.mutationChance);
                        else
                            newCh=exc_Inv_Mutate(newCh,0,1);
                        end
                    end
                else
                    pars=selectParentMulti(parentSet(2:end),3);
                    if rand()<obj.xOverRate
                        if obj.g==0
                            newCh=WDDE_Mutate_Cross(parentSet(1),pars(1),pars(2),pars(3));
                        else
                            newCh=GDDE_Mutate_Cross(parentSet(1),pars(1),pars(2),pars(3),obj.TTPSetObject.distanceMatrix,obj.alpha,obj.DE);
                        end
                    else
                        newCh=pars(1);
                    end
                end
                newGen=[newGen newCh];
            end
            obj.data=newGen;
            
            %plot(obj.stat)
            %drawnow
            %hold on
            c=obj.bestChromo2(1);
            c.drawPath();
            c=c(1).cost;
            obj.stat=[obj.stat c];
            %           plot(obj.stat);
        end
        %Selects parents randomly from a given parent set, ie, a number of
        %chromosomes with the lowest costs.
        function [p,i]=selectParent(obj,parentSet)
            
            index=length(parentSet);
            total=index*(index+1)/2;
            val=rand()*total;
            sum=index;
            while sum<val
                index=index-1;
                sum=sum+index;
            end
            i=length(parentSet)-index+1;
            p=parentSet(i);
            
        end
        %Another similar function
        function [p,i]=selectParent2(obj,parentSet,j)
            i=j;
            while i==j
                index=length(parentSet);
                total=index*(index+1)/2;
                val=rand()*total;
                sum=index;
                while sum<val
                    index=index-1;
                    sum=sum+index;
                end
                i=length(parentSet)-index+1;
            end
            p=parentSet(i);
            
        end
        %Runs EA, upto a max. no. of iterations, or till a stopping cost is
        %reached.
        function res=run(obj,maxIterations,stoppingCost)
            
            cost=Inf;
            for i=1:maxIterations
                cost=obj.nextGen();
                if mod(i,100)==1
                   l=numel(obj.data);
                   for k=1:l
                      obj.data(k).twoOpt(); 
                   end
                end
                if mod(i,1)==0
                    fprintf('%d.Generation %d, Lowest Cost %f\n',i,numel(obj.stat),cost) ;
                end
                if cost<stoppingCost
                    break
                end
            end
            
            res=obj.bestChromo2(1);
        end
    end
end
