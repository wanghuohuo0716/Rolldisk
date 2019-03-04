syms alpha beta gamma alpha_dot beta_dot gamma_dot; %z(alpha)-x(beta)-z(gamma) sequence axis
syms phi theta psi phi_dot theta_dot psi_dot;
syms OMEGA omega_x omega_y omega_z;
syms VELOCITY r R; %radius
alpha = phi; %转换为大作业对应的角度
beta = pi/2 - theta;
%gamma = 3*pi/2 + psi;
gamma = 0;
alpha_dot = phi_dot;
beta_dot =  -theta_dot;
gamma_dot = psi_dot;

% alpha = phi; %转换为经典欧拉角 psi-theta-phi
% beta =  theta;
% gamma = psi;
% alpha_dot = phi_dot; 
% beta_dot =  theta_dot;
% gamma_dot = psi_dot;

Rz1 = [cos(alpha),sin(alpha),0;   %当sin符号对调的时候，才会出现wikipedia的公式，欧拉角表示方法？？？
       -sin(alpha), cos(alpha),0;
                0,          0,1;];

Rx = [1,         0,          0;
      0,cos(beta),sin(beta);
      0,-sin(beta), cos(beta);];
            
Rz2 = [  cos(gamma),sin(gamma),0;
       -sin(gamma), cos(gamma),0;
                0,           0,1;];
          
Rzxz = simplify(Rz2 * Rx * Rz1)

OMEGA_calssic = [alpha_dot beta_dot gamma_dot].'; %列向量，' 共轭转置，.’非共轭转置,gamma_dot beta_dot alpha_do 顺序

A = [sin(beta) * sin(gamma), cos(gamma) ,0
     sin(beta) * cos(gamma), -sin(gamma),0
                  cos(beta),           0,1];
            
OMEGA_homework = simplify(A * OMEGA_calssic)%列向量,omega_x,omega_y,omega_z 顺序
omega_x = OMEGA_homework(1);
omega_y = OMEGA_homework(2);
omega_z = OMEGA_homework(3);

Rca = [0,-R,0].';
VELOCITY_a = [0,0,0];
VELOCITY_c_fixed = -cross(OMEGA_homework, Rca) %两个向量叉积，注意顺序
VELOCITY_c_inertial = simplify(inv(Rzxz)) * VELOCITY_c_fixed
           
           