function [] = traverseProgressCurve(Px, Py, C)
%Px and Py are the parametric functions describing the path P
%C is the arbitrary progress curve which defines the speed at which the
%function is traversed

set(gca,'XLim', [floor(min(Px(0:0.01:1))) ceil(max(Px(0:0.01:1)))], 'YLim', [floor(min(Py(0:0.01:1))) ceil(max(Py(0:0.01:1)))], 'Drawmode','fast','Visible','on');
%create the window to draw the animation
%bounds set by the bounds of the function, rounded up
cla
axis equal
pointer = animatedline('color','r','Marker','o','MarkerSize',2,'MarkerFaceColor','r');

for s = 0:0.01:1
    t = distanceAlongParametric(Px, Py, 0, 1, C(s));
    %t is the distance along the parametric proportional to C(s)
    x = Px(t);
    y = Py(t);
    
    clearpoints(pointer); addpoints(pointer,x,y);
    drawnow;pause(0.01)
end
end
