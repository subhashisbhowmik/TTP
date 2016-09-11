function cities=twoOptCity(cities)
    global cityList;
    length=numel(cities);
    for i=1:length-3
       for j=i+2:length-1
          x1=cityList(cities(i),2);
          y1=cityList(cities(i),3);
          x2=cityList(cities(i+1),2);
          y2=cityList(cities(i+1),3);
          x3=cityList(cities(j),2);
          y3=cityList(cities(j),3);
          x4=cityList(cities(j+1),2);
          y4=cityList(cities(j+1),3);
          
          if check_overlap([x1 x2 x3 x4],[y1 y2 y3 y4])==1
             
              
             temp=cities(i+1);
             cities(i+1)=cities(j);
             cities(j)=temp;
          end
       end
    end
end