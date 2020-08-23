
%Plot with errorbars
%Einlesen der Daten für 1D-Scans 002-021
T=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter.txt");
T=table2array(T);
s=reshape(sqrt(2)*T(:,8),[1 20]);
sneg=reshape(sqrt(2)*T(:,9),[1 20]);
sneg=s-sneg;
spos=reshape(sqrt(2)*T(:,10),[1 20]);
spos=spos-s;
z=[320 0 0 40 80 120 120 160 200 240 280 320 320 220 240 260 280 300 320 320];
z=z/40;
%zneg=[0 0 0 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0 0 0.025 0.025 0.025 0.025 0.025 0 0];
errorbar(z,s,sneg,spos,'.b');
hold on;

%Einlesen für Scan 025
W=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_025.txt");
W=table2array(W);
l=reshape(W(:,1),[1 16]);
l=l/40000;
s2=reshape(sqrt(2)*W(:,8), [1 16]);
s2neg=reshape(sqrt(2)*W(:,9),[1 16]);
s2neg=s2-s2neg;
s2pos=reshape(sqrt(2)*W(:,10),[1 16]);
s2pos=s2pos-s2;
%zneg2=[0.005 0.005 0.005 0.005 0.005 0.005 0.005 0.005 0.005 0.005 0.005 0.005 0.005 0.005 0.005 0.005 ];
errorbar(l,s2,s2neg,s2pos,'r.');
hold on;

%Einlesen für Scan 030
Q=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_030.txt");
Q=table2array(Q);
l2=reshape(Q(:,1),[1 16]);
l2=l2/40000;
s3=reshape(sqrt(2)*Q(:,8), [1 16]);
s3neg=reshape(sqrt(2)*Q(:,9),[1 16]);
s3neg=s3-s3neg;
s3pos=reshape(sqrt(2)*Q(:,10),[1 16]);
s3pos=s3pos-s3;
errorbar(l2,s3,s3neg,s3pos,'ko');
legend("50\mum Apertur","50\mum Apertur", "10\mum Apertur");
hold off;
title("1/e^2-Strahlradius ermittelt aus Gauß-Fits");
xlabel("Entfernung vom negativen Limit [mm]");
ylabel("scheinbarer Strahlradius in \mum");
xlim([-0.25 8.25]);
saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Strahlradius_errors.png","png")
xlim([5.25 7.25]);
title("Vergrößerung des Bereichs der Scans 025 und 030");
saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Strahlradius_errors_closeup.png","png");

%Plotten der korrigierten Grafiken
%Scan 030
V=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_030_corrected.txt");
V=table2array(V);
Z=V(:,1);
Z=Z/40000;
s4=V(:,2);
s4neg=V(:,3);
s4neg=s4-s4neg*sqrt(2);
s4pos=V(:,4);
s4pos=s4pos*sqrt(2)-s4;
errorbar(l2,s3,s3neg,s3pos,'ko');
hold on;
errorbar(Z,s4,s4neg,s4pos,'ro');
hold off;
title("Vergleich der Strahlradien für Scan 030 mit Korrektur und ohne");
xlabel("Entfernung vom neg. Limit [mm]");
ylabel("Strahlradius in \mum");
legend("Scan 030 ohne Korrektur", "Scan 030 mit Korrektur");
xlim([5.25 7.25]);
saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Strahlradius_030_corrected.png","png");

%Scan 002-021
U=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_002_021_corrected.txt");
U=table2array(U);
s5=U(:,2);
s5neg=U(:,3);
s5neg=s5-sqrt(2)*s5neg;
s5pos=U(:,4);
s5pos=s5pos*sqrt(2)-s5;
errorbar(z,s,sneg,spos,'s');
reshape(z,[20 1]);
hold on;
errorbar(z,s5,s5neg,s5pos,'rs');
hold off;
title("Vergleich der Strahlradien für die Scans 002-021 mit und ohne Korrektur");
xlabel("Entfernung vom neg. Limit [mm]");
ylabel("Strahlradius in \mum");
legend("Scans ohne Korrektur", "Scans mit Korrektur");
saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Strahlradius_002_021_corrected.png","png");

%Scan 025
X=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_025_corrected.txt");
X=table2array(X);
Y=X(:,1);
Y=Y/40000;
s6=X(:,2);
s6neg=X(:,3);
s6neg=s6-sqrt(2)*s6neg;
s6pos=X(:,4);
s6pos=s6pos*sqrt(2)-s6;
errorbar(Y,s2,s2neg,s2pos,'s');
hold on;
errorbar(Y,s6,s6neg,s6pos,'rs');
hold off;
title("Vergleich der Strahlradien für die Scan 025 mit und ohne Korrektur");
xlabel("Entfernung vom neg. Limit [mm]");
ylabel("Strahlradius in \mum");
legend("Scans ohne Korrektur", "Scans mit Korrektur");
saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Strahlradius_025_corrected.png","png");

%Vergleich korrigierte Scans
errorbar(z,s5,s5neg,s5pos,'b*');
hold on;
errorbar(Y,s6,s6neg,s6pos,'r*');
hold on;
errorbar(Z,s4,s4neg,s4pos,'k*');
hold off;
title("korrigierte 1/e^2-Strahlradien für verschiedene Scans entlang der Strahlachse");
xlabel("Entfernung vom neg. Limit [mm]");
ylabel("Strahlradius in \mum");
legend("50\mum Apertur","50\mum Apertur","10\mum Apertur","location","southwest");
saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Strahlradius_all_scans_corr.png","png");
xlim([5.375 7.125]);
saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Strahlradius_all_corrected_zoom.png","png");

