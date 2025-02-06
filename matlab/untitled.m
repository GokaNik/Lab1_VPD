clear all;
files = ["data--100", "data--80", "data--60", "data--40", "data--20", "data-0", "data-20", "data-40", "data-60", "data-80", "data-100"];
voltages = [-100, -80, -60, -40, -20, 0, 20, 40, 60, 80, 100];
k_all = [];
Tm_all = [];

for i = 1:length(files)
    data=readmatrix(files(i))
    U=voltages(i);
    time=data(:,1)
    angle_0=data(1,2)*pi/180
    angle = data(:,2)*pi/180 - angle_0
    omega = data(:,3)*pi/180
    figure(1)
    plot(time,angle)
    xlabel("tiime, s")
    ylabel("angle, rad")
    par0=[0.1;0.06];
    U_pr = 100;
    fun = @(par,time)U_pr*par(1)*(time - par(2)*(1 - exp(-time/par(2))));
    par = lsqcurvefit(fun,par0,time,angle)
    k = par(1);
    Tm = par(2);
    theta = U_pr*k*(time - Tm*(1 - exp(-time/Tm)));
    plot(time,theta)
    hold on


    figure(2)
    plot(time,omega)
    xlabel("tiime, s")
    ylabel("omega, rad")
    par0 = [0.1; 0.06]; 
    U_pr = 100;  
    fun1 = @(par,time)par(1)*U_pr*(1-exp(-time/par(2)));
    par = lsqcurvefit(fun1,par0,time,omega)
    k = par(1);
    Tm = par(2);
    theta = U_pr*k*(1-exp(-time/Tm))
    plot(time,theta)

    hold on;
end
