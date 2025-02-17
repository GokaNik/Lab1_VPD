

files = ["data--100", "data--80", "data--60", "data--40", "data--20" , "data-0" , "data-20", "data-40", "data-60", "data-80", "data-100"];
voltages = [-100, -80, -60, -40, -20, 0, 20, 40, 60, 80, 100];
k_all = [];
Tm_all = [];
w_nls=[];

for i = 1:length(files)
    data=readmatrix(files(i))
    U=voltages(i);
    time=data(:,1)
    angle_0=data(1,2)*pi/180
    angle = data(:,2)*pi/180 - angle_0
    omega = data(:,3)*pi/180
    figure(1)
    hold on
    plot(time,angle)
    xlabel("tiime, s")
    ylabel("angle, rad")


    par0=[0.1;0.006];
    fun = @(par,time)U*par(1)*(time - par(2)*(1 - exp(-time/par(2))));
    par = lsqcurvefit(fun,par0,time,angle)
    k = par(1);
    Tm = par(2);
    theta = U*k*(time - Tm*(1 - exp(-time/Tm)));
    plot(time,theta)
    k_all ( end +1) = k;
    Tm_all ( end +1) = Tm ;
    w_nls ( end +1) = U* k ;
    hold on


    figure(2)
    hold on;  
    plot(time,omega)
    xlabel("tiime, s")
    ylabel("omega, rad/s")

    par0 = [0.1; 0.06]; 
    fun1 = @(par,time)par(1)*U*(1-exp(-time/par(2)));
    par = lsqcurvefit(fun1,par0,time,omega)
    k = par(1);
    Tm = par(2);
    theta = U*k*(1-exp(-time/Tm))
    plot(time,theta)
 

    hold on;
end

figure (3)
plot ( voltages , Tm_all )
xlabel (" voltages , %")
ylabel (" Tm , c ")
grid on

figure (4)
plot ( voltages , w_nls )
xlabel (" voltages , %")
ylabel ('w уст , рад/с')
grid on

U = -100;
k = mean ( k_all ) ;
Tm = mean ( Tm_all );

file = "data--100";
data = readmatrix(file);
time_exp = data(:, 1);
angle_0 = data(1,2)*pi/180;
angle_exp = data(:, 2) * pi / 180 - angle_0;
omega_exp = data(:, 3) * pi / 180;

sim('simulink.slx');

figure(5);
time_aprx = 0:0.01:1;
theta_aprx = U * k * (time_aprx - Tm * (1 - exp(-time_aprx / Tm)));
plot(time_aprx, theta_aprx, 'r'); 
hold on;
plot(time_exp, angle_exp, ':m'); 
plot(out.theta.Time, out.theta.Data, '-.b'); 
legend({"Approximation", "Experiment", "Modeling"}, "Location", "southeast");
xlabel("Time, s");
ylabel("Angle, rad");
grid on;


figure(6);
omega_aprx = k * U * (1 - exp(-time_aprx / Tm));
plot(time_aprx, omega_aprx, 'r'); 
hold on;
plot(time_exp, omega_exp, ':m'); 
plot(out.omega.Time, out.omega.Data, '-.b'); 
legend({"Approximation", "Experiment", "Modeling"}, "Location", "southeast");
xlabel("Time, s");
ylabel("Omega, rad/s");
grid on;



