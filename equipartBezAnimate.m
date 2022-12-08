%function equipartitions order 2 bezier curve points Px and Py
%It is animated by curve C and equipartitioned n times.
%C is arbitrary curve to traverse by taken in as anonymous function
%Problem 6
function equipartBezAnimate(Ptsx, Ptsy, C, n)
    %will add support to pass in points for px, py and # of partitions
    %Ptsx is matrix of x points for the bezier curve order 2 (3 points)
    %Ptsy is matrix of y points for the bezier curve order 2 (3 points)
    %example points of (1,1), (3,3), (5,1)
    %example on calling this function equipartBezAnimate(0, 0, @(r) r^(2), 10)
    if ((isscalar(Ptsx) || isscalar(Ptsy))) %if 0 passed in, default is this curve
        Ptsx = [-0.3 -0.5 -0.25;   -0.25 0 0.25;     0.25 0.5 0.3;  0.3 0 -0.3]
        Ptsy = [1 1.75 2.5;        2.5 2.4 2.5;    2.5 1.75 1;    1 1.01 1]
    end    %points above draw a simple vase.
    %dynamic as instead of writing the function you can just provide points
    %func form:
    %Px = @(x) (1-x).^2 + 2.*((1-x).*(3.*x)) + 5.*x.^2
    %Py = @(y) (1-y).^2 + 2.*(1-y).*(3.*y) + y.^2
    
    %Px = @(x, t) t.*(1-x).^2 + 2.*((1-x).*(t.*x)) + t.*x.^2
    %Py = @(y, t) t.*(1-y).^2 + 2.*(1-y).*(t.*y) + t.*y.^2
    
    Px = @(x) Ptsx(1).*(1-x).^2 + 2.*((1-x).*(Ptsx(2).*x)) + Ptsx(3).*x.^2
    Py = @(y) Ptsy(1).*(1-y).^2 + 2.*(1-y).*(Ptsy(2).*y) + Ptsy(3).*y.^2
    
    set(gca,'XLim', [floor(min(Ptsx(:)))*2 ceil(max(Ptsx(:)))*2], 'YLim', [floor(min(Ptsy(:)))-1 ceil(max(Ptsy(:)))*1], 'Drawmode','fast','Visible','on');
    %create the window to draw the animation
    %bounds set by the bounds of the function, rounded up
    cla
    pointer = animatedline('color','r','Marker','o','MarkerSize',2,'MarkerFaceColor','r');
    pointer2 = animatedline('color','b','Marker','o','MarkerSize',2,'MarkerFaceColor','r');
    
    for i = 1:size(Ptsx, 1)
        Px = @(x) Ptsx(i, 1).*(1-x).^2 + 2.*((1-x).*(Ptsx(i, 2).*x)) + Ptsx(i, 3).*x.^2;
        Py = @(x) Ptsy(i, 1).*(1-x).^2 + 2.*((1-x).*(Ptsy(i, 2).*x)) + Ptsy(i, 3).*x.^2;
        equipartition(Px, Py, n);
    end
    
    listT1 = [];
    iter = 1;
    for s = 0:0.01:1
        %can use either bisection or newton iteration, preference.
        listT1(iter) = distanceAlongParametric(Px, Py, 0, 1, C(s)); 
        %distanceAlongParametricNewton(Px, Py, s, s);
        iter = iter + 1;
    end
    
    for i = 1:size(Ptsx, 1)
        Px = @(x) Ptsx(i, 1).*(1-x).^2 + 2.*((1-x).*(Ptsx(i, 2).*x)) + Ptsx(i, 3).*x.^2;
        Py = @(x) Ptsy(i, 1).*(1-x).^2 + 2.*((1-x).*(Ptsy(i, 2).*x)) + Ptsy(i, 3).*x.^2;

        for s = 0.01:0.01:1
            %t = distanceAlongParametric(PyList, PyList, 0, 1, C(s));
            x = Px(s);
            y = Py(s);
            
            Li = floor(s*100)+1;
            
            x2 = Px(listT1(Li));
            y2 = Py(listT1(Li));

            clearpoints(pointer); clearpoints(pointer2);
            addpoints(pointer,x,y);   addpoints(pointer2,x2,y2);
            drawnow;pause(0.01)
        end
    end
end