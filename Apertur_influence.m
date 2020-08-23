%Diagramm Apertureinfluss
%Einlesen SmarAct-Positionen (Test für Scan 009)
A=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\knifeedge_x_mechonics_along_beam_axis___neg_limit_plus_160000steps____009\scan_horiz_positions__2020-03-16--19-34-03-281137.csv");
%Einlesen Integral
B=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\knifeedge_x_mechonics_along_beam_axis___neg_limit_plus_160000steps____009\scan_horiz_integrals__2020-03-16--19-34-03-281137.csv");
%x=(1:0.1:200);
for m=(1:3)
   R=[2.0;4.76;22.5];
for s=(1:50)
x0=A(125);
A0=100;
r=R(m);
f=A0*exp(-((A-x0)/s).^2);
r0=A(125);
y=real(sqrt(r^2-(A-r0).^2));
alpha=real(4*acos(abs(A-r0)/r));
Ar=real(r^2/2*(alpha-sin(alpha)));
F=conv(f,Ar,'same');
format long;
g=fit(A,F,'gauss1');
G=coeffvalues(g);
Con=confint(g);
sbc=s;
aac=G(1);
cac=G(2);
sac=G(3);
slc=Con(1,3);
suc=Con(2,3);
alc=Con(1,1);
auc=Con(2,1);
clc=Con(1,2);
cuc=Con(2,2);
if s==1
    S=[sbc];
    Sac=[sac];
    Slc=[slc];
    Suc=[suc];
else
    S=[S; sbc];
    Sac=[Sac;sac];
    Slc=[Slc;slc];
    Suc=[Suc;suc];
end

W=table(S,Sac,Slc,Suc);
W.Properties.VariableNames{'S'}='s_bef_conv';
W.Properties.VariableNames{'Sac'}='s_after_conv';
W.Properties.VariableNames{'Slc'}='Sac_lower_conf';
W.Properties.VariableNames{'Suc'}='Sac_upper_conf';
writetable(W, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_Apertur_"+2*r+".txt")


end
plot(S,Sac);
hold on;
end
plot(S,S,"k--");
hold off;
%set(gcf,'FontSize',17);
ax=gca;
ax.FontSize=15;
title("Einfluss der Aperturfunktion auf \sigma-Parameter");
xlabel("ursprünglicher \sigma-Parameter [\mum]");
ylabel("\sigma-Parameter nach Faltung [\mum]");
legend("5 \mum Apertur", "10 \mum Apertur","50 \mum Apertur","ideale Abbildung", "location", "best");
saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Apertur_influence_5_10_50.png","png");
xlim([0 10]);
legend('off');
title("Vergrößerung der Auflösungsgrenze der Aperturen");
%legend("5 \mum Apertur", "10 \mum Apertur","50 \mum Apertur","ideale Abbildung", "location", "best","FontSize",15 );
saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\Apertur_influence_5_10_50_zoom.png","png");
