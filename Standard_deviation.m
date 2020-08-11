%Skript für Standardabweichung der Einzelschussdaten vom Mittelwert
for m=(1:1)
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
    y=sum(A(n,:))/s(2);
    for d=(1:s(2))
        diff(d)=(A(n,d)-y)^2;
    end
    Diff=sum(diff);
    D(n)=sqrt(Diff/s(2));
    x=n*(B(1)*1000000);
    Y(n)=y;
    X(n)=x;
    
end
    Y=Y*(-1);
    s=size(A);
    plot(X,Y);
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
M1(m)=max(D(idl1:idr1));
M2(m)=max(D(idl2:idr2));
end
plot(z,M1,z,M2);
xlabel("z-Position [mm]");
ylabel("Standardabweichung");
legend("Xe^{1+}-Peak","Xe^{2+}-Peak","Location","northwest");
title("maximale Standardabweichung im Bereich der einzelnen Xenon-Peaks");
saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\standard_deviation_h5.png","png");