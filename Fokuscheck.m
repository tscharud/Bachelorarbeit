%Überprüfen der Fokusposition
%3mm als Strahldurchmesser am Spiegel

lam=760e-9;
w0=280e-6;
x=(0:0.001:14.7);

z_R=(pi*w0^2)/lam;
theta0=w0/z_R;
d=5.7e-03;
theta2=d/(2*12.7);
w4=x(12701:length(x))*theta2;

w=w0*sqrt(1+(x/z_R).^2);
w(12701:length(x))=w4;
for n=(1:length(x))
    y=x(n);
    r=y*(1+(z_R/y)^2);
    
    if n==1
        R=[r];
    else
        R=[R r];
    end
end

r_2=1/(1/R(length(x))-1/0.45);
q=w(length(x));
z=-r_2/(1+((lam*r_2)/(pi*q^2))^2);
zr2=z*sqrt((r_2/-z)-1);
w02=sqrt((zr2*lam)/pi);
x2=(0:0.000001:0.750);
z_r3=(pi*w02^2)/lam;
w03=q/sqrt(1+(z/zr2)^2);
w2=w03*sqrt(1+((x2-z)/zr2).^2);
w2=w2;
w=w;
x2=x2+14.7;
w=w*1000;
w2=w2*1000;
plot(x,w,'LineWidth',2);
hold on;
plot(x2,w2,'LineWidth',2);
hold off;
set(gca,'FontSize',17);
xl1=xline(14.7,"label","sphärischer Spiegel","LabelVerticalAlignment","top","LabelHorizontalAlignment","left");
xl1.FontSize=19;
xl2=xline(12.7,"label","verstellbare Iris (d=5,7mm)","LabelVerticalAlignment","bottom","LabelHorizontalAlignment","left");
xl2.FontSize=19;
title("Strahlradius in Abhängigkeit von der Entfernung von der Quelle");
xlabel("Entfernung von virtuellem Quellpunkt [m]");
ylabel("Strahlradius \omega [mm]");
xlim([0 15.5]);
set(gcf, 'Position',[100, 100, 800, 525]);
legend("einfallender Strahl","reflektierter Strahl","location","best");
saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\IR_beamprofile_mirror","png");
plot(x,w,'LineWidth',2);
hold on;
plot(x2,w2,'LineWidth',2);
hold off;
set(gca,'FontSize',17);
title("Strahlradius in Abhängigkeit von der Entfernung von der Quelle");
xlabel("Entfernung von virtuellem Quellpunkt [m]");
ylabel("Strahlradius \omega [mm]");
xlim([14.5 max(x2)]);
xl1=xline(14.7,"label","sphärischer Spiegel","LabelVerticalAlignment","bottom","LabelHorizontalAlignment","left");
xl1.FontSize=17;
legend("einfallender Strahl","reflektierter Strahl","location","best");
set(gcf, 'Position',[100, 100, 800, 525]);
saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\IR_beamprofile_mirror_close","png");

%Überprüfen der q-Parameter
len=length(R);
w=w/1000;
q1=1/((1/R(len))-i*(lam/(pi*(w(len))^2)));
q2_ber=1/((1/r_2)-i*(lam/(pi*(w(len))^2)));
q2_Matrix=q1/((-q1/0.45)+1);
real(q2_ber)-real(q2_Matrix)
imag(q2_ber)-imag(q2_Matrix)

