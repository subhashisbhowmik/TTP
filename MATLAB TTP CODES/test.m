pts=[3 4];
c1=[1 4 3 2];
c2=[1 3 2 4];
c2(pts(1)+1:pts(2))=c1(pts(1)+1:pts(2));
index=pts(2)+1;
pos=pts(2)+1;
pos2=pts(2);
if ~isequal(c1,c2)
    while true
        index=mod((index-1),length(c1))+1;
        pos=mod((pos-1),length(c1))+1;
        if sum((c2((pts(1)+1):pts(2)))==c1(pos))==0
            c2(mod(index-1,length(c2))+1)=c1(pos);
            index=index+1;
        end
        if index==pts(2)
            break;
        end
        pos=pos+1;
    end
    
end
c2
    