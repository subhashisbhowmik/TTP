%Crossing with 1.Permutaion crossing for Cities, 2.Uniform crossing of
%picking plan.
function ch=perm_Uni_Cross(ch1,ch2)
    pts=[];
    while true
        pts=sort([ceil(rand()*length(ch1.cityArray)-1)+1 1+ceil(rand()*length(ch1.cityArray)-1)]);
        if(pts(1)~=pts(2)) 
            break
        end
    end
    c1=ch1.cityArray;
    c2=ch2.cityArray;
    c2(pts(1)+1:pts(2))=c1(pts(1)+1:pts(2));
    index=pts(2)+1;
    pos2=pts(2)+1;
    pos=pts(2)+1;
    if ~isequal(c1,c2)
        while true
            index=mod((index-1),length(c1))+1;
            pos=mod((pos-1),length(c1))+1;
            if sum((c2((pts(1)+1):pts(2)))==c1(pos))==0
                %c2(pos2)=c1(pos);
                c2(pos)=c1(mod(index-1,length(c2))+1);
                index=index+1;
            end 
            if pos==pts(2)
                break;
            end
            pos=pos+1;
        end
    end
    weight=rand();
    o1=reshape(ch1.objectSelector,1,[]);
    o2=reshape(ch2.objectSelector,1,[]);
    s1=rand(1,length(o1))<weight;
    s2=1-s1;
    objectSelector3=reshape(s1.*o1+s2.*o2,length(ch1.cityArray),[]);
    ch=Chromosome(c2,objectSelector3,ch1.TTPSetObject);
end