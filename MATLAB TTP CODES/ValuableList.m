%Mutable Class for strong object Weight and values
classdef ValuableList <handle
   properties (Access = public)
      data = [];
      value=[];
   end
   methods
      function obj = ValuableList(x,value)
         obj.data = x;
         obj.value=value;
      end
   end
end