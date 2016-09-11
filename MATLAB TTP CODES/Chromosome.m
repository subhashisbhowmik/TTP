%Holds City order and picking plan, along with the constant parameters in
%TTPSetObject. Calculates cost whenever created. Thus Immutable.
classdef Chromosome <handle
    properties (Access = public)
        cityArray = [];
        objectSelector = [];
        TTPSetObject;
        cost=0;
    end
    
    methods
        function obj = Chromosome(cityArray,objectSelector,TTPSetObject)
            obj.cityArray = cityArray;
            obj.objectSelector = objectSelector;
            obj.TTPSetObject=TTPSetObject;
            obj.cost=-eval2(obj);%TTPCost(obj.TTPSetObject,obj.cityArray,obj.objectSelector);
            %obj.cost=TTPCost(obj.TTPSetObject,obj.cityArray,obj.objectSelector);
            %obj.twoOpt();
        end
        
        function twoOpt(obj)
            cities=obj.cityArray;
            cities2=twoOptCity(cities);
            %cities-cities2
            if ChromosomeCheck(cities2,obj.objectSelector,obj.TTPSetObject).cost<obj.cost
               obj.cityArray=cities2; 
            end
        end
        
        function drawPath(obj)
            global cityList;
            cities=obj.cityArray;
%             max(cities)
%             size(cityList(2,:))
            x=cityList(cities,2);
            y=cityList(cities,3);
            hold off;
            %plot(x,y,'-o','MarkerSize',2);
            x=x';
            y=y';
            u=[x(2:end) x(1)]-x;
            v=[y(2:end) y(1)]-y;
            quiver(x,y,u,v,0);
            drawnow;
        end
        
    end
    
end