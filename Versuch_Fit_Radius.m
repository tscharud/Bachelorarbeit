%Fit an Strahlradien Versuch
U=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_002_021_corrected.txt");
U=table2array(U);
s5=U(:,2);
s5neg=U(:,3);
s5neg=s5-sqrt(2)*s5neg;
s5pos=U(:,4);
s5pos=s5pos*sqrt(2)-s5;
z=[320 0 0 40 80 120 120 160 200 240 280 320 320 220 240 260 280 300 320 320];
z=z/40;


V=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_030_corrected.txt");
V=table2array(V);
Z=V(:,1);
Z=Z/40000;
s4=V(:,2);
s4neg=V(:,3);
s4neg=s4-s4neg*sqrt(2);
s4pos=V(:,4);
s4pos=s4pos*sqrt(2)-s4;

Z=reshape(Z,[1 16]);
s4=reshape(s4, [1 16]);
x=[8 0 1 2 3 4 5 Z];
x=reshape(x, [length(x) 1]);
k=(s5(1)+s5(20))/2;
k2=(s5(2)+s5(3))/2;
k3=(s5(6)+s5(7))/2;
y=[k k2 s5(4) s5(5) k3 s5(8) s5(9) s4];
y=reshape(y,[length(y) 1]);
plot(x,y,'ks')
hold on;
eq=fittype('a1*sqrt(1+((x-b1)/c1)^2)','dependent',{'y'},'independent',{'x'},'coefficients',{'a1','b1','c1'});
g=fit(x,y,eq);
C=coeffvalues(g);
Con=confint(g);
a1=C(1);
aneg=a1-Con(1,1);
apos=Con(2,1)-a1;
b1=C(2);
bneg=b1-Con(1,2);
bpos=Con(2,2)-b1;
c1=C(3);
x2=(0:0.01:8);
f=a1*sqrt(1+((x2-b1)/c1).^2);
plot(x2,f);
title("Fit an aus Messungen erhaltene 1/e^2-Strahlradien");
xlabel("Entfernung vom positiven Limit [mm]");
ylabel("Strahlradius [\mum]");
errorbar(b1,a1,aneg,apos,bneg,bpos,'r*');
legend("Radien aus Scans","Fit","Fokus (Fit) mit Konfidenzintervallen");
hold off;
%saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Fit_beamradius.png","png");
xlim([5 8.5]);
ylim([12 30]);
%saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Fit_beamradius_zoom.png","png");


