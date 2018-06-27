% # Function linear extrapolation
% #
% #   f(x) = a*x^2 + b*x + c
% #
% #   y0 = a*x0^2 + b*x0 + c
% #   y1 = a*x1^2 + b*x1 + c
% #   y2 = a*x2^2 + b*x2 + c
% #
% # -- Function File: extquad(y0, y1, y2, x0, x1, x2, x)
% #    Return an extrapolation value in f(x)
function fx = extquad(y0, y1, y2, x0, x1, x2, x)
  M = [x0^2 x0 1;x1^2 x1 1;x2^2 x2 1];
  N = [y0;y1;y2];
%   MI = inv(M);
%   f = MI*N;
  f=M\N;
  fx = (f(1)^2)*x + f(2)*x + f(3);
end