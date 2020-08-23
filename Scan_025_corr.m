%Korrektur von Scan 025 
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

T2=table(S,Sac,Slc,Suc,Aac,Alc,Auc,Cac,Clc,Cuc);

for n=(1:16)
    D=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_025.txt");
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
z=D(n,1);
if n==1
    T=[t];
    V=[v];
    Lc=[lc];
    Uc=[uc];
    Z=[z];
else
    V=[V;v];
    T=[T;t];
    Lc=[Lc;lc];
    Uc=[Uc;uc];
    Z=[Z;z];
end
end
V=sqrt(2)*V;
T=sqrt(2)*T;
U=table(Z,V,Lc,Uc);
U.Properties.VariableNames{'Z'}='z_pos';
U.Properties.VariableNames{'V'}='radius';
U.Properties.VariableNames{'Lc'}='lower_conf';
U.Properties.VariableNames{'Uc'}='upper_conf';
writetable(U, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_025_corrected.txt")

