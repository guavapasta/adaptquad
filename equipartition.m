function partitionBounds = equipartition(x, y, n)
%x and y are the parametric functions
%X AND Y SHOULD BE SYMBOLIC, NOT ANONYMOUS
%n is the target number of partitions to split into

midpoint = floor(n/2);
firstQuartile = floor(n/4);
thirdQuartile = floor(3 * n / 4);

%we get some early points to serve as bounds
%now all bisections will only have to go over one fourth of the graph

h = 1/n;
%define our step size

results = 1:n+1;
results(1) = 0;
results(n + 1) = 1;

%set up vector with partition bounds, set first to 0 and last to 1


results(midpoint + 1) = distanceAlongParametric(x, y, 0, 1, midpoint * h);
results(firstQuartile + 1) = distanceAlongParametric(x, y, 0, results(midpoint + 1), firstQuartile * h);
results(thirdQuartile + 1) = distanceAlongParametric(x, y, results(midpoint + 1), 1, thirdQuartile * h);
%find values for partition bounds
%our first bound is 0, so all caculated bounds are indexed one more than
%their actual "position"

for i = 1:firstQuartile - 1
    results(i + 1) = distanceAlongParametric(x, y, 0, results(firstQuartile + 1), i * h);
end

for i = firstQuartile + 1:midpoint - 1
    results(i + 1) = distanceAlongParametric(x, y, results(firstQuartile + 1), results(midpoint + 1), i * h);
end

for i = midpoint + 1:thirdQuartile - 1
    results(i + 1) = distanceAlongParametric(x, y, results(midpoint + 1), results(thirdQuartile + 1), i * h);
end

for i = thirdQuartile + 1:n - 1
    results(i + 1) = distanceAlongParametric(x, y, results(thirdQuartile + 1), 1, i * h);
end
%finding the rest of the values is done over 4 loops, each account for
%1/4th the total length of the arc. this should speed up calculation, as
%each bound is now already 1/4th the total

%this optimization makes the code much longer and more confusing, but it
%also saves .2 seconds at n = 200 so I can't get rid of it now

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