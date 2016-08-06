function ch=randomChromosome(TTPSetObject,maxObjects)
    noCities=length(TTPSetObject.distanceMatrix);
    cityArray=[1 randperm(noCities-1)+1];
    objectList=reshape(rand(maxObjects*noCities,1)*rand()>0.5,noCities,maxObjects);
    ch=Chromosome(cityArray,objectList,TTPSetObject);
end