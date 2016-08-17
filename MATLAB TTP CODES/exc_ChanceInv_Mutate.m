%Mutation with 1.City exchange, 2.Multiple selection inversion each with
%the same probability.
function ch2=exc_ChanceInv_Mutate(ch,city,object,chance)
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
%         pos=round(rand()*(l-1))+1;
        for pos=1:length(objectSelector2)
            if rand()<chance
                objectSelector2(pos)=~objectSelector2(pos);
            end
        end
    end
    ch2=Chromosome(cityArray2,objectSelector2,ch.TTPSetObject);
end