function partitionBounds = equipartitionNewton(x, y, n)
%X AND Y SHOULD BE SYMBOLIC, NOT ANONYMOUS
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
    x = 0.5 + 0.3*t + 3.9*t.^2 - 4.7*t.^3;
    y = 1.5 + 0.3*t + 0.9*t.^2 - 2.7*t.^3;
    plot(x, y);
end
hold off

%plot based off our bounds

partitionBounds = results;

end