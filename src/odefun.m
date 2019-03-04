function [i,j] = odefun(a,b,c) % aΪʱ�䷶Χ����2������ɣ�bΪ��ʼֵ��Ϊx1-x9����9������ɣ�c=[v1,v3]
    R = 0.2;
    m = 2;
    g = 9.8;
    J(1) = 0.5 * m * R^2;
    J(2) = 0.25 * m * R^2;
    K1 = 2;
    K2 = 1;
    
    v1 = c(1);
    v3 = c(2);

    %z������z1-z9
    d = [b(4) + R * sin(b(2)) * sin(b(1)), ...
    - R * cos(b(1)) * b(8), ...
    R * sin(b(1)) * b(6) * b(8) - R * cos(b(1)) * b(9), ...
    b(5) - R * sin(b(2)) * cos(b(1)), ...
    - R * sin(b(1)) * b(8), ...
    - R * cos(b(1)) * b(6) * b(8) - R * sin(b(1)) * b(9), ...
    b(3), ...
    b(7), ...
    b(2)];

    tspan = a;
    y0 = d;
    [t,y] = ode45(@odefun,tspan,y0); %����z��΢�ַ����������z
    i = t;
    j = y;

    function dydt = odefun(t,y) %y��t�ĺ�����dydt��y�ĵ���,����һ��΢�ַ�����
        dydt = zeros(9,1);
        dydt(1,1) = y(2,1); %dy1dt = y2
        dydt(2,1) = y(3,1); %dy2dt = y3
        dydt(3,1) = v1;
        dydt(4,1) = y(5,1); %dy4dt = y5
        dydt(5,1) = y(6,1); %dy5dt = y6
        dydt(6,1) = v3;
        dydt(7,1) = -1/R * (y(2,1)^2 + y(5,1)^2)^0.5;
        dydt(8,1) = - K1 * y(9,1) - K2 * y(8,1);
        dydt(9,1) = y(8,1); %dy9dt = y8
    end
end