x=reshape((0:0.1:200),[2001 1]);

for s=(0.05:0.05:5)
    s
x0=100;
A0=100;
r=2.5;
f=A0*exp(-((x-x0)/s).^2);
r0=100;
y=real(sqrt(r^2-(x-r0).^2));
alpha=real(4*acos(abs(x-r0)/r));
Ar=real(r^2/2*(alpha-sin(alpha)));
F=conv(f,Ar,'same');
F=reshape(F,[2001 1]);
format long;
g=fit(x,F,'gauss1');
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
if s==0.05
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
writetable(W, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_Apertur_5um_0.05_5.txt")


end
p1=plot(S,Sac);
hold on;
p2=plot(S,S,"k--");
hold off;
legend([p1 p2],{"5\mum-Apertur","ideale Abbildung"},"location","southeast");
p3=xline(2.4,"r","label","Fokusradius für Toroid","HandleVisibility","off");
title("scheinbarer und realer \sigma-Parameter der 5\mum-Apertur");
xlabel("ursprünglicher \sigma-Parameter [\mum]");
ylabel("scheinbarer \sigma-Parameter [\mum]");
saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\5um_Apertur_5e-2_5.png","png");