function bests=topChromo(chromoArray,number)
    bests=[];
    while length(bests)<number
        bestIndex=1;
        bestCost=Inf;
       for i=1:length(chromoArray)
           if chromoArray(i).cost<bestCost
               bestCost=chromoArray(i).cost;
               bestIndex=i;
           end
       end
       bests=[bests chromoArray(bestIndex)];
       chromoArray(bestIndex)=[];
    end
end