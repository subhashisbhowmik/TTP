function x=selectParentMulti(parentSet,i)
    r=randperm(length(parentSet));
    x=parentSet(r(1:i));
end