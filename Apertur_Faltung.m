%Test, ob Faltung und Entfaltung eindeutig sind

%Einlesen SmarAct-Positionen (Test für Scan 009)
A=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\knifeedge_x_mechonics_along_beam_axis___neg_limit_plus_160000steps____009\scan_horiz_positions__2020-03-16--19-34-03-281137.csv");
%Einlesen Integral
B=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\knifeedge_x_mechonics_along_beam_axis___neg_limit_plus_160000steps____009\scan_horiz_integrals__2020-03-16--19-34-03-281137.csv");
%x=(1:0.1:200);
for s=(5:50)
x0=A(125);
A0=100;


f=A0*exp(-((A-x0)/s).^2);
r=22.5;
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
if s==5
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

writetable(T, 'Convolution_gaussian_50um_apertur.txt')

for n=(1:20)
    D=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter.txt");
    D=table2array(D);
    t=D(n,8);
diff=Sac-t;
[m,idx]=min(abs(diff));
if diff(idx)>0 && idx>1
    idx=idx-1;
else
    idx=idx;
end
v=S(idx);
lc=Slc(idx);
uc=Suc(idx);

if n==1
    T=[t];
    V=[v];
    Lc=[lc];
    Uc=[uc];
else
    V=[V;v];
    T=[T;t];
    Lc=[Lc;lc];
    Uc=[Uc;uc];
end
end
V=sqrt(2)*V;
n=reshape((2:21),[20 1]);
V=table(n,V,Lc,Uc);
V.Properties.VariableNames{'n'}='Scan';
V.Properties.VariableNames{'V'}='radius';
V.Properties.VariableNames{'Lc'}='lower_conf';
V.Properties.VariableNames{'Uc'}='upper_conf';
writetable(V, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_002_021_corrected.txt")

