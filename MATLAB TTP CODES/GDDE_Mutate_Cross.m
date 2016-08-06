function a=GDDE_Mutate_Cross(best,u,r1,r2,distMat,alpha,F)
    len=length(best.cityArray);
    city=[1];
    G=gausswin(len,alpha);
    G=G/(sum(G));
    for i=1:len-1
        [A I]=sort(distMat(i,:));
        v0=distMat(best.cityArray(i),best.cityArray(i+1));
%         v1=distMat(r1.cityArray(i),r1.cityArray(i+1));
%         v2=distMat(r2.cityArray(i),r2.cityArray(i+1));
        pos1=find(r1.cityArray==best.cityArray(i));
        pos2=find(r2.cityArray==best.cityArray(i));
        pos1b=mod(pos1,length(r1.cityArray))+1;
        pos2b=mod(pos2,length(r2.cityArray))+1;
        v1=distMat(r1.cityArray(pos1),r1.cityArray(pos1b));
        v2=distMat(r2.cityArray(pos2),r2.cityArray(pos2b));
        val=v0+F*v1-F*v2;
        n=0;
        flag=1;
        for j=1:length(A)
            if A(j)>val
                n=j;
                flag=0;
                break;
            end
        end
        if flag==1
           n=length(A); 
        end
        sft=n-len/2;
        g=circshift(G,sft);
        r=rand();
        tot=0;
        v=0;
        for p=1:length(g)
           tot=tot+g(p);
           if tot>=r
              v=p;
              break;
           end
        end
        
        city=[city I(v)];
        
    end
    s=size(best.objectSelector);
    o=[];
    for i=1:s(1)*s(2)
        if r1.objectSelector(i)==r2.objectSelector(i)
           o=[o best.objectSelector(i)];
        else
           o=[o ~best.objectSelector(i)];
        end
    end
    x=Chromosome(city,o,best.TTPSetObject);
    a=perm_Uni_Cross(u,x);
end