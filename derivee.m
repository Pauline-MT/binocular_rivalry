
function output = derivee(input)
 
E_L =input(1);
H_L = input(2);
E_R = input(3);
H_R = input(4) ;
L = input(5);
R = input(6);
global Tau;
global Tau_H;
global m;
global g;

global a;
global eps;


    E_Lpoint = (1/Tau)*(-E_L + m*max([L - a*E_R + eps*E_L - g*H_L, 0]));
    H_Lpoint = 1/Tau_H*(-H_L + E_L);  
    E_Rpoint = 1/Tau*(-E_R + m*max([R - a*E_L + eps*E_R - g*H_R, 0]));
    H_Rpoint = 1/Tau_H*(-H_R + E_R);
    
output = [E_Lpoint ;  H_Lpoint ; E_Rpoint ; H_Rpoint];
end 
