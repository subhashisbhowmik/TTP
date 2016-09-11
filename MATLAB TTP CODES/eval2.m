%Cost evaluation with Function downloaded from the page on TTP Contest 2014
function e=eval2(t)
    %t=topChromo(o.data,1);
    
    dismat=t.TTPSetObject.distanceMatrix;
%     weightlist=[t.TTPSetObject.valuableList(2)];
%     weightlist=[t.TTPSetObject.valuableList.value];
%     vallist=[t.TTPSetObject.valuableList.value];
%     weightlist=[t.TTPSetObject.valuableList.data];
    vallist=[t.TTPSetObject.valuableList.value];
    weightlist=[t.TTPSetObject.valuableList.data];
    tour=t.cityArray;
    woks=25936;
    rent=5.61;
    vmax=1;
    vmin=0.1;
    av=diag(ones(1,279));
    av=[zeros(1,279);av];
    av=av';
    selection=2:280;
    selection=selection.*t.objectSelector(2:end)';
    e=TTP1Objective(dismat,vallist,weightlist,av,[tour tour(1)],selection, woks,vmax,vmin,rent);
end