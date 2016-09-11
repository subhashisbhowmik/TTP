%Holds City order and picking plan, along with the constant parameters in
%TTPSetObject. Calculates cost whenever created. Thus Immutable.
classdef ChromosomeCheck <handle
    properties (Access = public)
        cityArray = [];
        objectSelector = [];
        TTPSetObject;
        cost=0;
    end
    
    methods
        function obj = ChromosomeCheck(cityArray,objectSelector,TTPSetObject)
            obj.cityArray = cityArray;
            obj.objectSelector = objectSelector;
            obj.TTPSetObject=TTPSetObject;
            obj.cost=-eval2(obj);%TTPCost(obj.TTPSetObject,obj.cityArray,obj.objectSelector);
            %obj.cost=TTPCost(obj.TTPSetObject,obj.cityArray,obj.objectSelector);
            
        end
        
        
    end
    
end