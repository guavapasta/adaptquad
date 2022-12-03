%Problem 6
function equipartBezAnimate(C, n)
    %C is arbitrary curve to traverse by taken in as anonymous function
    %will add support to pass in points for px, py and # of partitions
    %Ptsx is matrix of x points for the bezier curve order 2 (3 points)
    %Ptsy is matrix of y points for the bezier curve order 2 (3 points)
    %example points of (1,1), (3,3), (5,1)
    Ptsx = [1 3 5; 5 7 9]
    Ptsy = [1 3 1; 1 -1 1]
    %dynamic as instead of writing the function you can just provide points
    %func form:
    %Px = @(x) (1-x).^2 + 2.*((1-x).*(3.*x)) + 5.*x.^2
    %Py = @(y) (1-y).^2 + 2.*(1-y).*(3.*y) + y.^2
    
    %Px = @(x, t) t.*(1-x).^2 + 2.*((1-x).*(t.*x)) + t.*x.^2
    %Py = @(y, t) t.*(1-y).^2 + 2.*(1-y).*(t.*y) + t.*y.^2
    
    Px = @(x) Ptsx(1).*(1-x).^2 + 2.*((1-x).*(Ptsx(2).*x)) + Ptsx(3).*x.^2
    Py = @(y) Ptsy(1).*(1-y).^2 + 2.*(1-y).*(Ptsy(2).*y) + Ptsy(3).*y.^2
    
    rX = @(t) t.*(1-Ptsx(1));
    
    Px(0.9)
    Py(0.9)
    
    PxList = Px;
    PyList = Py;
    
    
    set(gca,'XLim', [floor(min(Ptsx(:))) ceil(max(Ptsx(:)))], 'YLim', [floor(min(Ptsy(:))) ceil(max(Ptsy(:)))], 'Drawmode','fast','Visible','on');
    %create the window to draw the animation
    %bounds set by the bounds of the function, rounded up
    cla
    pointer = animatedline('color','r','Marker','o','MarkerSize',2,'MarkerFaceColor','r');
    
    
    %need many Pxs and Pys, with ranges for each, best
    
    for i = 1:size(Ptsx, 1)
        Px = @(x) Ptsx(i, 1).*(1-x).^2 + 2.*((1-x).*(Ptsx(i, 2).*x)) + Ptsx(i, 3).*x.^2;
        Py = @(x) Ptsy(i, 1).*(1-x).^2 + 2.*((1-x).*(Ptsy(i, 2).*x)) + Ptsy(i, 3).*x.^2;
        PxList = Px;
        PyList = Py;
        equipartition(PxList, PyList, n);
    end
    
    for i = 1:size(Ptsx, 1)
        Px = @(x) Ptsx(i, 1).*(1-x).^2 + 2.*((1-x).*(Ptsx(i, 2).*x)) + Ptsx(i, 3).*x.^2;
        Py = @(x) Ptsy(i, 1).*(1-x).^2 + 2.*((1-x).*(Ptsy(i, 2).*x)) + Ptsy(i, 3).*x.^2;
        PxList = Px;
        PyList = Py;

        for s = 0:0.01:1
            
            %t = distanceAlongParametric(PyList, PyList, 0, 1, C(s));
            x = PxList(s);
            y = PyList(s);

            clearpoints(pointer); addpoints(pointer,x,y);
            drawnow;pause(0.02)
        end
    end
end