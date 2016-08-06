classdef TTPSet
    properties (Access = public)
      distanceMatrix = [];
      valuableList = [];
      rent = 1;
      maxCap=100;
      speed=1;
      minSpeed=0;
    end
    methods
        function obj=TTPSet(distanceMatrix,valuableList,rent,maxCap,speed,minSpeed)
            obj.distanceMatrix=distanceMatrix;
            obj.valuableList=valuableList;
            obj.rent=rent;
            obj.maxCap=maxCap;
            obj.speed=speed;
            obj.minSpeed=minSpeed;
        end
    end
end