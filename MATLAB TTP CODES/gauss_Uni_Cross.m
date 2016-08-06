function ch=gauss_Uni_Cross(ch1,ch2,alpha,distMat)
    pts=[];
    len=length(ch1.cityArray);
    city=[1];
    while true
        pts=sort([ceil(rand()*length(ch1.cityArray)-1)+1 1+ceil(rand()*length(ch1.cityArray)-1)]);
        if(pts(1)~=pts(2)) 
            break
        end
    end
    c1=ch1.cityArray;
    c2=ch2.cityArray;
    G=gausswin(len,alpha);
    G=G/(sum(G));
    for i=1:len-1
        [A I]=sort(distMat(i,:));
        v1=distMat(c1(i),c1(i+1));
%         v1=distMat(r1.cityArray(i),r1.cityArray(i+1));
%         v2=distMat(r2.cityArray(i),r2.cityArray(i+1));
        pos2=find(c2==c1(i));
        pos2b=mod(pos2,length(c2))+1;
        v2=distMat(c2(pos2),c2(pos2b));
        val=(v1+v2)/2;
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
    
    
    weight=rand();
    o1=reshape(ch1.objectSelector,1,[]);
    o2=reshape(ch2.objectSelector,1,[]);
    s1=rand(1,length(o1))<weight;
    s2=1-s1;
    objectSelector3=reshape(s1.*o1+s2.*o2,length(ch1.cityArray),[]);
    ch=Chromosome(city,objectSelector3,ch1.TTPSetObject);
end