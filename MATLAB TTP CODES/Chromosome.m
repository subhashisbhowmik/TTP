classdef Chromosome
    properties (Access = public)
        cityArray = [];
        objectSelector = [];
        TTPSetObject;
        cost=0;
    end
    
    methods
        function obj = Chromosome(cityArray,objectSelector,TTPSetObject)
            obj.cityArray = cityArray;
            obj.objectSelector = objectSelector;
            obj.TTPSetObject=TTPSetObject;
            %obj.cost=eval2(obj);%TTPCost(obj.TTPSetObject,obj.cityArray,obj.objectSelector);
            obj.cost=TTPCost(obj.TTPSetObject,obj.cityArray,obj.objectSelector);
        end
    end
    
end