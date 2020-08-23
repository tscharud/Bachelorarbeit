%10um Apertur 2D-Scan mit Faltung (Scan 030)
%Einlesen der horizontalen Position
A=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\2d_10um_x_mechonics_along_beam_axis_scan___neg_limit_plus_220000steps_to_280000steps____030\scan_2d_positions_hori__2020-03-17--01-01-18-755222.csv");
%Berechnen der Aperturfaltung
format long;
for s=(1:1:50)
    a=A(1,:);
x0=a(60);
A0=100;

f=A0*exp(-((a-x0)/s).^2);
r=4.76;
r0=a(60);
y=real(sqrt(r^2-(a-r0).^2));
alpha=real(4*acos(abs(a-r0)/r));
Ar=real(r^2/2*(alpha-sin(alpha)));
F=conv(f,Ar,'same');
format long;
a=reshape(a,[121 1]);
F=reshape(F, [121 1]);
g=fit(a,F,'Gauss1');
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
    Aac=[aac];
    Cac=[cac];
    Slc=[slc];
    Suc=[suc];
    Alc=[alc];
    Auc=[auc];
    Clc=[clc];
    Cuc=[cuc];
else
    S=[S; sbc];
    Sac=[Sac;sac];
    Aac=[Aac;aac];
    Cac=[Cac;cac];
    Slc=[Slc;slc];
    Suc=[Suc;suc];
    Alc=[Alc; alc];
    Auc=[Auc; auc];
    Clc=[Clc; clc];
    Cuc=[Cuc; cuc];
end

    
end
plot(S,Sac);
title("Scheinbarer und realer Strahlradius für verschiedene Aperturgrößen");
xlabel("realer Strahlradius in um");
ylabel("scheinbarer Strahlradius der Faltung in um");
xlim([1 50]);
ylim([0 max(Sac)+1]);
legend('5um Aperturradius','location','northwest');
hold off;
saveas(gcf, "Apertur_influence_on_radius_1_to_50.png", 'png');

%Names={'ursprüngliche s-Par.', 's-Parameter nach Faltung', 'untere Grenze s', 'obere Grenze s','Amplitude nach Faltung', 'untere Grenze Amplitude', 'obere Grenze Amplitude','Zentrum nach Faltung', 'untere Grenze Zentrum', 'obere Grenze Zentrum'};
T=table(S,Sac,Slc,Suc,Aac,Alc,Auc,Cac,Clc,Cuc);
T.Properties.VariableNames{'S'}='s';
T.Properties.VariableNames{'Sac'}='s_conv';
T.Properties.VariableNames{'Slc'}='s_lower_conf';
T.Properties.VariableNames{'Suc'}='s_upper_conf';
T.Properties.VariableNames{'Aac'}='Amp_conv';
T.Properties.VariableNames{'Alc'}='Amp_lower_conf';
T.Properties.VariableNames{'Auc'}='Amp_upper_conf';
T.Properties.VariableNames{'Cac'}='Center_conv';
T.Properties.VariableNames{'Clc'}='Center_lower_conf';
T.Properties.VariableNames{'Cuc'}='Center_upper_conf';

writetable(T, 'Convolution_gaussian_10um_apertur.txt')
%Einlesen der Fit-Parameter
for n=(1:16)
    k=216000+4000*n;
    U=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_030.txt");
    U=table2array(U);
    t=U(n,9);
    diff=Sac-t;
    [q, id]=min(abs(diff));
    if diff(id)>0 && id>1
        id=id-1;
    else
        id=id;
    end
    l=S(id);
    if n==1
        K=[k];
        L=[l];
        T1=[t];
    else 
        L=[L l];
        T1=[T1 t];
        K=[K k];
    end
end
L=sqrt(2)*L;
T1=sqrt(2)*T1;

plot(K,L,'b*',K,T1,'rs');
title("Strahlradius (halbe 1/e^2-Weite) für Scan 030 mit 10um Apertur");
xlabel("Entfernung vom neg. Limit in Mech.-Schritten");
ylabel("Strahlradius in um");
ylim([10 30]);
legend("10um Apertur mit Faltung","10um Apertur ohne Faltung","location","northeast");
saveas(gcf, "Strahlradius_Scan_030_Faltung.png","png");

T=table2array(T);
for h=(1:length(L))
    diff2=abs(T(:,2)-L(h)/sqrt(2));
    [q2,id2]=min(diff2);
    lc=T(id2,3);
    uc=T(id2,4);
    z=K(h);
    if h==1  
        Z=[z];
        Lc=[lc];
        Uc=[uc];
    else
        Z=[Z;z];
        Lc=[Lc;lc];
        Uc=[Uc;uc];
    end
end
L=reshape(L,[16 1]);
V=table(Z,L,Lc,Uc);
V.Properties.VariableNames{'Z'}='z_pos';
V.Properties.VariableNames{'L'}='radius';
V.Properties.VariableNames{'Lc'}='lower_conf';
V.Properties.VariableNames{'Uc'}='upper_conf';
writetable(V, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_030_corrected.txt")


