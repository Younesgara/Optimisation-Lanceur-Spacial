clear 
close all

x_old = [-1;2;1;-2;-2];

disp("--- start ---")
max_iter = 15;
x_new = SQP(@testfun_2,x_old,max_iter);



%disp("x:");
%disp(x_new);