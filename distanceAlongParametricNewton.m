function tStar = distanceAlongParametricNewton(x, y, s)
%Find the point t*(s) that is s of the way along a curve
%x and y and the x and y functions that define a parametric curve
%s is the distance along the curve we want to find

syms t
xSym = sym(x);
ySym = sym(y);
xPrime = diff(xSym);
yPrime = diff(ySym);
%get the derivatives of x and y, which we need for computing arc length
arcLengthPortion = matlabFunction(sqrt(xPrime^2 + yPrime^2));
%get the function we put in the integral. matlab function allows it to be
%used with numerical integration, as matlab as trouble integrating this
%symbolically
totalArcLength = quadrature(arcLengthPortion, 0, 1, 0.5*10^-3);
%get the arc length from 0 to 1
currentT = s;
%our initial guess is equal to the portion along the graph we want to find
currentS = quadrature(arcLengthPortion, 0, currentT, 0.5*10^-3)/totalArcLength;

%our function for newton's method is arc length up to s / total arc length
%equals s. Convert to Length(s)/Length(1) - s = 0 to work with newton. The
%derivative of this is sqrt(x'(t)^2 + y'(t)^2)/Length(1). The numerator is
%an integral with a lower bound of 0, so to take the derivative just drop
%the integral and plug in the upper bound. The denominator is a constant,
%so leave it and drop the -s since it's a constant as well. 

while(abs(s - currentS) > 0.5 * 10^-3)
    currentT = currentT - (quadrature(arcLengthPortion, 0, currentT, 0.5*10^-3)/totalArcLength - s)/(arcLengthPortion(currentT)/totalArcLength);
    currentS = quadrature(arcLengthPortion, 0, currentT, 0.5*10^-3)/totalArcLength;
end
tStar = currentT;