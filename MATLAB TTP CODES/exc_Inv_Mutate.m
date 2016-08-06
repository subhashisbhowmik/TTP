function ch2=exc_Inv_Mutate(ch,city,object)
    cityArray2=ch.cityArray;
    objectSelector2=ch.objectSelector;
    if city==1
        pts=[];
        while true
            pts=([mod(ceil(rand()*length(ch.cityArray)-1),length(ch.cityArray)-1)+2 2+mod(ceil(rand()*length(ch.cityArray)-1),length(ch.cityArray)-1)]);
            if(pts(1)~=pts(2)) 
                break
            end
        end
        temp=cityArray2(pts(1));
        cityArray2(pts(1))=cityArray2(pts(2));
        cityArray2(pts(2))=temp;
    end
    if object==1
        l=length(reshape(ch.objectSelector,1,[]));
        pos=round(rand()*(l-1))+1;
        objectSelector2(pos)=~objectSelector2(pos);
    end
    ch2=Chromosome(cityArray2,objectSelector2,ch.TTPSetObject);
end