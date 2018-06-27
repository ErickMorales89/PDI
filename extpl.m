%  Function linear extrapolation
% 
%            (y2-y1)
%  y = y1 + --------- (xn-x1)
%            (x2-x1)
% 
%  -- Function File: extpl(y2, y1, xn, x2, x1)
%     Return an extrapolation value in xn
function y = extpl(y2, y1, xn, x2, x1)
  y = y1 + ((y2-y1)/(x2-x1))*(xn-x1);
end