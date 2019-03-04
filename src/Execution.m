% Plot the reference track in the first place
t_r = 0:0.001:30;
x_r = 6 * cos(pi/15 * t_r);
y_r = 10 * sin(pi/15 * t_r);
plot(x_r,y_r,':g','linewidth',2)
hold on

% Basic parameters setup
R = 0.2;
m = 2;
g = 9.8;
J(1) = 0.5 * m * R^2;
J(2) = 0.25 * m * R^2;
c11 = 1;
c12 = 3;
c13 = 2.5;
c21 = 1;
c22 = 3;
c23 = 2.5;
v1 = 1;
v3 = 1;
step_length = 0.01;

% Time period is from 0.00s to 0.01s
a1 = [0 step_length];
b1 = [pi/2 pi/6 0 -0.1 -4 0 0 0 0];
c1 = [v1 v3];
[t1,y1] = odefun(a1,b1,c1); %根据当前状态和输入控制，求出下一时刻的z

plot(y1(:,1),y1(:,4),'k','linewidth',1)
axis([-10, 10, -15, 15])
grid on
hold on
title('Track')
xlabel('x')
ylabel('y')
legend('Reference Track','Real Track')

%v1，v3是控制量，epsilon 无穷小的方程组，包含三阶导数项
v1 = (2 * pi^3 * sin(pi * step_length / 15)) / 1125 - (c11 * (y1(end,1) - 6 * cos(pi/15 * step_length)) + c12 * (y1(end,2) + 6 * pi/15 * sin(pi/15 * step_length)) + c13 * (y1(end,3) + 6 * (pi/15)^2 * cos(pi/15 * step_length)));
v3 = (-2 * pi^3 * cos(pi * step_length / 15) / 675) / 1125 - (c21 * (y1(end,4) - 10 * sin(pi/15 * step_length)) + c22 * (y1(end,5) - 10 * pi/15 * cos(pi/15 * step_length)) + c23 * (y1(end,6) + 10 * (pi/15)^2 * sin(pi/15 * step_length)));
c1 = [v1 v3];

%z的反函数求出状态量
x1 = [asin(-y1(end,5) / (y1(end,2)^2 + y1(end,5)^2)^0.5), ...
y1(end,9), ...
y1(end,7), ...
y1(end,1) + R * y1(end,5) * sin(y1(end,9)) / (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
y1(end,4) - R * y1(end,2) * sin(y1(end,9)) / (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
(y1(end,2) * y1(end,6) - y1(end,3) * y1(end,5)) / (y1(end,2)^2 + y1(end,5)^2), ...
y1(end,8), ...
1/R * (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
(y1(end,2) * y1(end,3) + y1(end,5) * y1(end,6)) / (R * (y1(end,2)^2 + y1(end,5)^2)^0.5)];

% Time period is from 0.01s to 0.02s
a1 = [step_length,2 * step_length];
b1 = x1;
[t1,y1] = odefun(a1,b1,c1); %求出z

plot(y1(:,1),y1(:,4),'k','linewidth',1)
hold on

v1 = (2 * pi^3 * sin(pi * step_length * 2 / 15)) / 1125 - (c11 * (y1(end,1) - 6 * cos(pi/15 * step_length * 2)) + c12 * (y1(end,2) + 6 * pi/15 * sin(pi/15 * step_length * 2)) + c13 * (y1(end,3) + 6 * (pi/15)^2 * cos(pi/15 * step_length * 2)));
v3 = (-2 * pi^3 * cos(pi * step_length * 2 / 15) / 675) / 1125 - (c21 * (y1(end,4) - 10 * sin(pi/15 * step_length * 2)) + c22 * (y1(end,5) - 10 * pi/15 * cos(pi/15 * step_length * 2)) + c23 * (y1(end,6) + 10 * (pi/15)^2 * sin(pi/15 * step_length * 2)));
c1 = [v1 v3];

%z的反函数求出状态量
x1 = [asin(-y1(end,5) / (y1(end,2)^2 + y1(end,5)^2)^0.5), ...
y1(end,9), ...
y1(end,7), ...
y1(end,1) + R * y1(end,5) * sin(y1(end,9)) / (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
y1(end,4) - R * y1(end,2) * sin(y1(end,9)) / (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
(y1(end,2) * y1(end,6) - y1(end,3) * y1(end,5)) / (y1(end,2)^2 + y1(end,5)^2), ...
y1(end,8), ...
1/R * (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
(y1(end,2) * y1(end,3) + y1(end,5) * y1(end,6)) / (R * (y1(end,2)^2 + y1(end,5)^2)^0.5)];

% Time period is from 0.02s to 14.01s
for i = 2:1:1400
    a1 = [step_length * i,step_length * (i+1)];
    b1 = x1;
    [t1,y1] = odefun(a1,b1,c1);

    plot(y1(:,1),y1(:,4),'k','linewidth',1)
    hold on

    v1 = (2 * pi^3 * sin(pi * step_length * (i+1) / 15)) / 1125 - (c11 * (y1(end,1) - 6 * cos(pi/15 * step_length * (i+1))) + c12 * (y1(end,2) + 6 * pi/15 * sin(pi/15 * step_length * (i+1))) + c13 * (y1(end,3) + 6 * (pi/15)^2 * cos(pi/15 * step_length * (i+1))));
    v3 = (-2 * pi^3 * cos(pi * step_length * (i+1) / 15) / 675) / 1125 - (c21 * (y1(end,4) - 10 * sin(pi/15 * step_length * (i+1))) + c22 * (y1(end,5) - 10 * pi/15 * cos(pi/15 * step_length * (i+1))) + c23 * (y1(end,6) + 10 * (pi/15)^2 * sin(pi/15 * step_length * (i+1))));
    c1 = [v1 v3];

    x1 = [asin(- y1(end,5) / (y1(end,2)^2 + y1(end,5)^2)^0.5), ...
    y1(end,9), ...
    y1(end,7), ...
    y1(end,1) + R * y1(end,5) * sin(y1(end,9)) / (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
    y1(end,4) - R * y1(end,2) * sin(y1(end,9)) / (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
    (y1(end,2) * y1(end,6) - y1(end,3) * y1(end,5)) / (y1(end,2)^2 + y1(end,5)^2), ...
    y1(end,8), ...
    1/R * (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
    (y1(end,2) * y1(end,3) + y1(end,5) * y1(end,6)) / (R * (y1(end,2)^2 + y1(end,5)^2)^0.5)];
end

% Time period is from 14.01s to 35.01s
for i = 1401:1:3500
    a1 = [step_length * i,step_length * (i+1)];
    b1 = x1;
    [t1,y1] = odefun(a1,b1,c1);

    plot(y1(:,1),y1(:,4),'k','linewidth',1)
    hold on

    v1 = (2 * pi^3 * sin(pi * step_length * (i+1) / 15)) / 1125 - (c11 * (y1(end,1) - 6 * cos(pi/15 * step_length * (i+1))) + c12 * (y1(end,2) + 6 * pi/15 * sin(pi/15 * step_length * (i+1))) + c13 * (y1(end,3) + 6 * (pi/15)^2 * cos(pi/15 * step_length * (i+1))));
    v3 = (-2 * pi^3 * cos(pi * step_length * (i+1) / 15) / 675) / 1125 - (c21 * (y1(end,4) - 10 * sin(pi/15 * step_length * (i+1))) + c22 * (y1(end,5) - 10 * pi/15 * cos(pi/15 * step_length * (i+1))) + c23 * (y1(end,6) + 10 * (pi/15)^2 * sin(pi/15 * step_length * (i+1))));
    c1 = [v1 v3];

    if y1(end,4) > 0
    x1 = [asin(- y1(end,5) / (y1(end,2)^2 + y1(end,5)^2)^0.5), ...
    y1(end,9), ...
    y1(end,7), ...
    y1(end,1) + R * y1(end,5) * sin(y1(end,9)) / (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
    y1(end,4) - R * y1(end,2) * sin(y1(end,9)) / (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
    (y1(end,2) * y1(end,6) - y1(end,3) * y1(end,5)) / (y1(end,2)^2 + y1(end,5)^2), ...
    y1(end,8), ...
    1/R * (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
    (y1(end,2) * y1(end,3) + y1(end,5) * y1(end,6)) / (R * (y1(end,2)^2 + y1(end,5)^2)^0.5)];
    end
    
    if y1(end,4) < 0
    x1 = [pi - (asin(- y1(end,5) / (y1(end,2)^2 + y1(end,5)^2)^0.5)), ...
    y1(end,9), ...
    y1(end,7), ...
    y1(end,1) + R * y1(end,5) * sin(y1(end,9)) / (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
    y1(end,4) - R * y1(end,2) * sin(y1(end,9)) / (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
    (y1(end,2) * y1(end,6) - y1(end,3) * y1(end,5)) / (y1(end,2)^2 + y1(end,5)^2), ...
    y1(end,8), ...
    1/R * (y1(end,2)^2 + y1(end,5)^2)^0.5, ...
    (y1(end,2) * y1(end,3) + y1(end,5) * y1(end,6)) / (R * (y1(end,2)^2 + y1(end,5)^2)^0.5)];
    end
end

