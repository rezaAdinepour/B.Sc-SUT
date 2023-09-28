function result = AC_LOAD_LINE()
clear;
clc;
V_CEQ = 0.35;
R_C = 5.6;
I_CQ = 0.5;
V_CE = V_CEQ + (R_C*I_CQ);
IC = I_CQ + (1/R_C).*(V_CE-V_CEQ-R_C*I_CQ);
plot([V_CE, IC]);
title('AC Load Line');
xlabel('VCE');
ylabel('IC');
legend('-1/RAC');
grid on;
end