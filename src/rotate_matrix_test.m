syms alpha beta gamma alpha_dot beta_dot gamma_dot; %z(alpha)-x(beta)-z(gamma) sequence axis
syms phi theta psi phi_dot theta_dot psi_dot;
syms OMEGA omega_x omega_y omega_z;
syms VELOCITY r R; %radius
alpha = phi; %ת��Ϊ����ҵ��Ӧ�ĽǶ�
beta = pi/2 - theta;
%gamma = 3*pi/2 + psi;
gamma = 0;
alpha_dot = phi_dot;
beta_dot =  -theta_dot;
gamma_dot = psi_dot;

% alpha = phi; %ת��Ϊ����ŷ���� psi-theta-phi
% beta =  theta;
% gamma = psi;
% alpha_dot = phi_dot; 
% beta_dot =  theta_dot;
% gamma_dot = psi_dot;

Rz1 = [cos(alpha),sin(alpha),0;   %��sin���ŶԵ���ʱ�򣬲Ż����wikipedia�Ĺ�ʽ��ŷ���Ǳ�ʾ����������
       -sin(alpha), cos(alpha),0;
                0,          0,1;];

Rx = [1,         0,          0;
      0,cos(beta),sin(beta);
      0,-sin(beta), cos(beta);];
            
Rz2 = [  cos(gamma),sin(gamma),0;
       -sin(gamma), cos(gamma),0;
                0,           0,1;];
          
Rzxz = simplify(Rz2 * Rx * Rz1)

OMEGA_calssic = [alpha_dot beta_dot gamma_dot].'; %��������' ����ת�ã�.���ǹ���ת��,gamma_dot beta_dot alpha_do ˳��

A = [sin(beta) * sin(gamma), cos(gamma) ,0
     sin(beta) * cos(gamma), -sin(gamma),0
                  cos(beta),           0,1];
            
OMEGA_homework = simplify(A * OMEGA_calssic)%������,omega_x,omega_y,omega_z ˳��
omega_x = OMEGA_homework(1);
omega_y = OMEGA_homework(2);
omega_z = OMEGA_homework(3);

Rca = [0,-R,0].';
VELOCITY_a = [0,0,0];
VELOCITY_c_fixed = -cross(OMEGA_homework, Rca) %�������������ע��˳��
VELOCITY_c_inertial = simplify(inv(Rzxz)) * VELOCITY_c_fixed
           
           