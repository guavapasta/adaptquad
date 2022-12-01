function partitionBounds = equipartitionNewton(x, y, n)
%n is the number of partitions
%saves no time over normal equipartition at n = 200

h = 1/n;
%define our step size

results = 1:n+1;
results(1) = 0;
results(n + 1) = 1;
%set up vector with partition bounds, set first to 0 and last to 1

for i = 2:n
    results(i) = distanceAlongParametricNewton(x, y, (i - 1) * h);
end
%first vector member needs to be 0, so our indices are 1 ahead of our i

hold on
for i=1:n
    t = linspace(results(i), results(i + 1));
    xPoints = x(t);
    yPoints = y(t);
    plot(xPoints, yPoints);
end
hold off

%plot based off our bounds

partitionBounds = results;

end