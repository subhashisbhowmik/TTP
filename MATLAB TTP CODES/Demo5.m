% distanceMat=[0 5 6 6;
%     5 0 5 6;
%     6 5 0 4;
%     6 6 4 0];
cityList=table2array(readtable('1_city.txt'));
objList=table2array(readtable('1_obj.txt'));
x=length(cityList(:,1));
distanceMat=ones(x);
valuableList=[ValuableList([],[])];
for k=1:x
   for j=1:x
      distanceMat(j,k)=sqrt((cityList(k,2)-cityList(j,2))*(cityList(k,2)-cityList(j,2))+(cityList(k,3)-cityList(j,3))*(cityList(k,3)-cityList(j,3)));
   end
   if k>1
      locs=find(objList(:,4)==k)';
      valuableList=[valuableList ValuableList(objList(locs,3),objList(locs,2))];
   end
end
%standardDev=std(distanceMat);

cities=[1 2 3 4];
%valuableList=[ValuableList([],[]),ValuableList([20 20 10 15 17],[20 20 10 15 17]),ValuableList([1 5 10],[1 5 10]),ValuableList([5 9 11],[5 9 11])];
%valuableList=[ValuableList([],[]),ValuableList([2 3],[20 30]),ValuableList([1 1 3],[40 40 100]),ValuableList([2],[20])];
%objectList=[[0 0 0];[1 0 0];[1 0 0];[0 0 0]];
% objectList=[[0 0 0];[1 0 0];[1 0 0];[0 0 0]];
%objectList=[[0 0 0];[0 0 0];[0 0 1];[0 0 0]];
%rent=10;
rent=5.61;
speed=1;
minSpeed=0.1;
maxCap=25936;
TTPSetObject=TTPSet(distanceMat,valuableList,rent,maxCap,speed,minSpeed);
%TTPCost(TTPSetObject,cities,objectList)
number_of_population=10;
size=100;
randomNew=15;
xOverRate=1;
mutationRate=0.1;
mutationChance=0;
elites=10;
parents=15;
DE=0;
gaussian=0;
alpha=5;
minCost=-16099;
populations=[];
for k=1:number_of_population
    
    pop=population(TTPSetObject,size,xOverRate,mutationRate,mutationChance,elites,parents,randomNew,DE,gaussian,alpha);
    
    pop.init();
    topChromo(pop.data,1)
    %a=pop.run(1,minCost);
    populations=[populations pop];
end
while 1
    costs=[];
    for k=1:number_of_population
        populations(k).run(1,minCost);
        costs=[costs populations(k).bestChromo2(1).cost];
    end
    
    costsum=sum(costs);
    costs=costs./costsum;
    
    [costs,I]=sort(costs);
    costs
    populations=populations(I);
    prob=rand();
    total=0;
    selectiontill=1;
    for i=1:number_of_population
        total=total+costs(i);
        if total >= prob
            selectiontill=i;
        end
    end
    
    
end
save pop2791.mat pop
a
a.objectSelector;
%openvar('ans');
%plot(pop.stat);