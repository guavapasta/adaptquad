function tStar = distanceAlongParametric(x, y, a, b, s)
%Find the point t*(s) that is s of the way along a curve
%x and y and the x and y functions that define a parametric curve
%a and b are the start and end points of the range to search. While our
%full path is always from 0 to 1, changing a and b allows us to reduce our
%search time by not always checking the full array. This is used in
%question 3. 
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

while(true)
    m = (a + b)/2;
    %bisection method. get our midpoint
    lengthToM = quadrature(arcLengthPortion, 0, m, 0.5*10^-3);
    currentS = lengthToM/totalArcLength;
    %get length from 0 to the midpoint, and then find the ratio of that to
    %the total length
    if (abs(s - currentS)) < 0.5 * 10^-3
        break
    end
    %if we're within our error, exit the loop
    if(currentS < s)
        a = m;
    else
        b = m;
    end
    %otherwise, readjust our bounds and repeat
end
tStar = m;