x=(0:0.01:200);
s=15;
x0=100;
A0=100;
r=25;
f=A0*exp(-((x-x0)/s).^2);
r0=100;
y=real(sqrt(r^2-(x-r0).^2));
alpha=real(4*acos(abs(x-r0)/r));
Ar=real(r^2/2*(alpha-sin(alpha)));
F=conv(f,Ar,'same');
f=f/max(f);
F=F/max(F);
plot(x,f,x,F);
title("Faltung eines Gauﬂ-Profils mit der Aperturfunktion");
legend("Gauﬂ-Profil","Faltung");
saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Fold.png","png");

