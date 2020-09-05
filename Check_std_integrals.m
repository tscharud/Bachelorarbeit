%Check std-integrals
for m=(1:13)
   k=20+m; 
   z(m)=5.25+0.5*m;
%Displays all datasets in the h5-file and their group
h5disp("D:\Users\rudit\Downloads\2020_20-03_HHG_CDI_static__run021__to__run033\run0000"+k+"_DA01_00000.h5");
%Opens one specific dataset
A=h5read("D:\Users\rudit\Downloads\2020_20-03_HHG_CDI_static__run021__to__run033\run0000"+k+"_DA01_00000.h5","/tof_digitizer/trace");
B=h5read("D:\Users\rudit\Downloads\2020_20-03_HHG_CDI_static__run021__to__run033\run0000"+k+"_DA01_00000.h5","/tof_digitizer/time_axis_step_in_s");
s=size(A);
m
for n=(1:length(A))
    y=sum(A(n,:));
    x=n*(B(1)*1000000);
    X(n)=x;
    Y(n)=y;
end
Y=Y*(-1);

Y=Y/s(2);
%Begrenzen der Xe Peaks
%Xe 1+ (linke und rechte Grenze)
L1=3.3;
R1=3.8;

%Xe 2+ (Linke und rechte Grenze)
L2=L1-1.3;
R2=R1-1.3;

%Xe 3+ (Linke und rechte Grenze)
%L3=1.85e-6;
%R3=2.25e-6;

%Festlegen auf X-Achse
diffl1=X-L1;
[q1,idl1]=min(abs(diffl1));
if diffl1(idl1)>0
    idl1=idl1-1;
else
    idl1=idl1;
end

diffl2=X-L2;
[q3,idl2]=min(abs(diffl2));
if diffl2(idl2)>0
    idl2=idl2-1;
else
    idl2=idl2;
end

%diffl3=X-L3;
%[q4,idl3]=min(abs(diffl3));
%if diffl3(idl3)>0
%    idl3=idl3-1;
%else
%    idl3=idl3;
%end

diffr1=X-R1;
[q2, idr1]=min(abs(diffr1));
if diffr1(idr1)<0
    idr1=idr1+1;
else
    idr1=idr1;
end

diffr2=X-R2;
[q5, idr2]=min(abs(diffr2));
if diffr2(idr2)<0
    idr2=idr2+1;
else
    idr2=idr2;
end

%diffr3=X-R3;
%[q6, idr3]=min(abs(diffr3));
%if diffr3(idr3)<0
%    idr3=idr3+1;
%else
%   idr3=idr3;
%end

%Integrieren über einzelne Traces
for idx=1:s(2)
    Y2=A(:,idx);
    Y2=Y2*(-1);
    len=length(Y2);
    aver2=mean(Y2(42000:len));
    Y2=Y2-aver2;
    
    %Xe1+
    Xe1_Diff(idx,m)=trapz(Y2(idl1:idr1));
    
    %Xe2+
    Xe2_Diff(idx,m)=trapz(Y2(idl2:idr2));
end
Ar_Xe1(m)=sum(Xe1_Diff(:,m))/s(2);
Ar_Xe2(m)=sum(Xe2_Diff(:,m))/s(2);
Div(m)=Ar_Xe2(m)/Ar_Xe1(m);

%Berechnung Standardabweichung und mittlere Fehler der Einzelmessung
Diff1=(Xe1_Diff(:,m)-sum(Xe1_Diff(:,m))/s(2)).^2;
Diff2=(Xe2_Diff(:,m)-sum(Xe2_Diff(:,m))/s(2)).^2;
sigma1(m)=sqrt(sum(Diff1)/s(2));
sigma2(m)=sqrt(sum(Diff2)/s(2));
sigma_mittelwert1(m)=sigma1(m)/sqrt(s(2));
sigma_mittelwert2(m)=sigma2(m)/sqrt(s(2));
%Fehlerfortpflanzung
dA1(m)=2*sigma_mittelwert1(m);
dA2(m)=2*sigma_mittelwert2(m);
deltaV(m)=abs((Ar_Xe2(m)*dA1(m))/(Ar_Xe1(m)^2))+abs(dA2(m)/Ar_Xe1(m));

end
m2=(1:13);
M=max(Div);
deltaV=deltaV/M;
Div=Div/M;
%Plot Diagramm mit Fehlerbalken
set(gca,'FontSize',17);
errorbar(z,Div,deltaV,deltaV,'LineWidth',2);
title("Verhältnis des Xe^{2+}-Peaks zum Xe^{1+}-Peak für XUV-TOF-Scan",'FontSize',14);
xlabel("Position entlang der Strahlachse [mm]",'FontSize',17);
ylabel("Quotient, normiert",'FontSize',17);
saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\TOF_Trace_Divided_h5_test_error.png","png");

