function cost=CalculateCost(cities, valuableLists, objectLists, cityDistance, rent, speed, speedFactor)
    citySize= size(cities);
    carry=0;
    cost=0;
    len=citySize(2);
    if len<=1
       return
    end
    city=1;
    for i=2:len
        nextCity=cities(i);
        dist=cityDistance(city,nextCity);
        city=nextCity;
        realSpeed=speed-speedFactor*carry;
        if realSpeed<=0
           sprintf('\nNo more movement possible at %dth city, C%d.\n',i,city)
           return
        end
        time=dist/realSpeed;
        
        cost=cost+time*rent;
        for j=1:length(objectLists(city).data)
            f=find(valuableLists(city).data==objectLists(city).data(j));
            if length(f)>0
               valuableLists(city).data(f)=[];
               carry=carry+objectLists(city).data(j);
            end
            carry
        end
    end
    cost=cost-carry;    
end