% animates different transversal of curve
% arc length parameter vs time parameter

% taken from book, initializes axes, plot, and ball objects
set(gca,'XLim',[-2 2],'YLim',[-2 2],'Drawmode','fast','Visible','on');
cla
axis square
ball=line('color','r','Marker','o','MarkerSize',10,'LineWidth',2, 'erase','xor','xdata',[],'ydata',[]);
ball2=line('color','b','Marker','o','MarkerSize',10,'LineWidth',2,'erase','xor','xdata',[],'ydata',[]);

% initializes functions
% x and y used to determine arc length parameter
t=0:.05:20;
x=@(t)0.5+0.3*t+3.9*t.^2-4.7*t.^3;
y=@(t)1.5+0.3*t+0.9*t.^2-2.7*t.^3;

% functions f later plotted
f1=0.5+0.3*t+3.9*t.^2-4.7*t.^3;
f2=1.5+0.3*t+0.9*t.^2-2.7*t.^3;

% finding arc length parameter
t2 = zeros(20,1);
for i= 0:20
    t2(i+1) = distanceAlongParametricNewton(x, y, 0.05*i);
end

% sime functions parametrized by arc length
g1=0.5+0.3*t2+3.9*t2.^2-4.7*t2.^3;
g2=1.5+0.3*t2+0.9*t2.^2-2.7*t2.^3;

% plots the curve
s=0:.1:1;
X1=0.5+0.3*s+3.9*s.^2-4.7*s.^3;
Y1=1.5+0.3*s+0.9*s.^2-2.7*s.^3;
plot(X1,Y1)
hold on

%plots the animation
for i = 1:21
    set(ball,'xdata',f1(i),'ydata',f2(i));
    set(ball2,'xdata',g1(i),'ydata',g2(i));
    drawnow;
    pause(.1);
end