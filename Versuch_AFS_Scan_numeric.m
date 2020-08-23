%numerische Integration der Gleichung für die Beschreibung des AFS-Scans
A0=100;
sigma=30;
r0=80;
rmax=30;
x0=(-80:0.1:80);
for n=(1:length(x0))
    x0(n)
    phi0=acos(x0(n)/r0);
    fun = @(phi,rho) A0*exp(-(rho.^2-2.*rho*r0.*cos(phi)*cos(phi0)+(r0*cos(phi0))^2)/sigma^2);
    q(n)=integral2(fun,0,2*pi,0,rmax);
end

plot(x0,q);
title("numerische Integration über Strahlquerschnitt in einer Apertur");
xlabel("Entfernung zwischen Apertur- und Strahlzentrum (bel. Einheiten)");
ylabel("num. Integral (bel. Einheiten)");
saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\numeric_integration.png","png")



