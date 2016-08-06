function cost=TTPCost(TTPSetObject,cityArray,objectList)
    cost=CalculateCost2(cityArray,TTPSetObject.valuableList,objectList,TTPSetObject.distanceMatrix,TTPSetObject.rent,TTPSetObject.maxCap,TTPSetObject.speed,TTPSetObject.minSpeed);
end