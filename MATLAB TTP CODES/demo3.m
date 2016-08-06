distanceMat=[0 2 1 3;
2 0 1 3;
1 1 0 4;
3 3 4 0];
cities=[1 3 2 4];
valuableList=[ValuableList([]),ValuableList([20 20 10 15 17]),ValuableList([1 5 10]),ValuableList([5 9 11])];
objectList=[[0 0 0 0 0];[1 0 0 1 0];[1 0 1 0 0];[1 1 1 0 0]];
rent=10;
speed=1;
speedFactor=0.01;
TTPSetObject=TTPSet(distanceMat,valuableList,rent,speed,speedFactor);
COST=TTPCost(TTPSetObject,cities,objectList);
COST