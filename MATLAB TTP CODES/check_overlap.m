function result=check_overlap(x,y)
    
    result=1;
    a1=x(1)-x(2);
    a2=x(3)-x(4);
    b1=y(1)-y(2);
    b2=y(3)-y(4);
    m1=(y(1)-y(2))/(x(1)-x(2));
    m2=(y(3)-y(4))/(x(3)-x(4));
    X=((y(3)-y(1))+(m1*x(1)-m2*x(3)))/(m1-m2);
    Y=y(1)+m1*(X-x(1));
    ratio1=(Y-y(1))/(y(2)-Y);
    ratio2=(Y-y(3))/(y(4)-Y);
    if (a1*b2-a2*b1)==0
        %fprintf('No Overlap :(')
        result=0;  % not overlap
    end
    if ratio1<0 || ratio2 <0    % not overlap
        result=0;
    end
%     if result==1
%         result
%     end
end
