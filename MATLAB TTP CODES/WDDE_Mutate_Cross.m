function a=WDDE_Mutate_Cross(best,u,r1,r2)
    city=[];
    for i=1:length(best.cityArray)
        city=[city best.cityArray(i)+r1.cityArray(i)-r2.cityArray(i)];
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
    city(find(city>length(city)|city<1))=ceil((rand())*length(city)+0.0001);
    n=zeros(1,length(city));
    m=zeros(1,length(city));
    for i=1:length(city)
       if n(city(i))==0
           n(city(i))=1;
       else
           m(i)=1;
       end
    end
    y=find(~n);%the not used values
    z=find(m);%indices of repeated values
    for i=1:length(z)
        b=ceil(rand()*length(y));
        val=y(b);
        y(b)=[];
        city(z(i))=val;
    end
    x=Chromosome(city,o,best.TTPSetObject);
    a=perm_Uni_Cross(u,x);
end