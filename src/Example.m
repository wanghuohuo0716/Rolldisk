function Testode45
R = 10;
m = 5;
h = 2;
tao(1) = 1;
tao(2) = 1;
J(1) = 0.5 * m * R^2;
J(2) = m/12 * (3 * R^2 + h^2);
tspan=[0 10]; %求解区间
y0=[pi 1 0 1 0 0]; %初值
[t,y]=ode45(@odefun,tspan,y0);
plot(y(:,5),y(:,6))
title('Track')
xlabel('x')
ylabel('y')
function y=odefun(t,u)
y=zeros(6,1); % 列向量
y(1,1)=u(2,1);
y(2,1)= tao(1) / (J(1) + m * R^2);
y(3,1) = u(4,1);
y(4,1) = tao(2) / J(2);
y(5,1) = R * cos(u(3,1)) * u(2,1);
y(6,1) = R * sin(u(3,1)) * u(2,1);%常微分方程公式
end
end