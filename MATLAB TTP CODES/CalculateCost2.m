function cost=CalculateCost2(cities, valuableLists, objectLists, cityDistance, rent, maxCap, speed, minSpeed)
len=length(cities);
carry=0;
cost=0;
value=0;
if len<=1
    return
end
len=len+1;
cities=[cities cities(1)];
city=cities(1);
for i=2:len
    nextCity=cities(i);
    dist=cityDistance(city,nextCity);
%     try
%     objectLists(city,:);
%     catch
%         dbstop
%     end
    objectLists=reshape(objectLists,length(cities)-1,[]);
    for j=1:length(objectLists(city,:))
        if objectLists(city,j)==1 && length(valuableLists(city).data)>=j
            carry=carry+valuableLists(city).data(j);
            value=value+valuableLists(city).value(j);
        end
    end
    if (carry>maxCap)
        sprintf('\nNo more movement possible at %dth city, C%d.\n',i,city);
        cost=cost-value;
        cost=Inf;
        return
    end
    realSpeed=speed-(speed-minSpeed)*(carry/maxCap);
    city=nextCity;
    time=dist/realSpeed;
    cost=cost+time*rent;
end
cost=cost-value;

%     citySize= size(cities);
%     carry=0;
%     cost=0;
%     value=0;
%     len=citySize(2);
%     if len<=1
%        return
%     end
%     city=1;
%     for i=2:len
%         nextCity=cities(i);
%         dist=cityDistance(city,nextCity);
%         city=nextCity;
% %         realSpeed=speed-(speed-minSpeed)*(carry/maxCap);
% %
%         if (carry>maxCap)
%                sprintf('\nNo more movement possible at %dth city, C%d.\n',i,city);
%                cost=cost-value;
%                cost=Inf;
%                return
%         end
% %         time=dist/realSpeed;
% %         cost=cost+time*rent;
%         for j=1:length(objectLists(city,:))
%             if objectLists(city,j)==1 && length(valuableLists(city).data)>=j
%                 carry=carry+valuableLists(city).data(j);
%                 value=value+valuableLists(city).value(j);
%             end
%         end
%         realSpeed=speed-(speed-minSpeed)*(carry/maxCap);
%
%         time=dist/realSpeed;
%         cost=cost+time*rent;
%     end
%     for j=1:length(objectLists(city,:))
%         if objectLists(city,j)==1 && length(valuableLists(city).data)>=j
%             carry=carry+valuableLists(city).data(j);
%             value=value+valuableLists(city).value(j);
%         end
%     end
%     dist=cityDistance(city,1);
% %     cost=cost-value;
%     realSpeed=speed-(speed-minSpeed)*(carry/maxCap);
%     if (carry>maxCap)
%            sprintf('\nNo more movement possible at %dth city, C%d.\n',i,city);
%            cost=cost-value;
%            cost=Inf;
%            return
%     end
%     time=dist/realSpeed;
%     cost=cost+time*rent;
%     cost=cost-value;
% end