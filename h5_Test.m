%Test for opening h5-files
for m=(1:13)
   k=20+m; 
   z(m)=5.25+0.5*m;
%Displays all datasets in the h5-file and their group
h5disp("D:\Users\rudit\Downloads\2020_20-03_HHG_CDI_static__run021__to__run033\run0000"+k+"_DA01_00000.h5");
%Opens one specific dataset
A=h5read("D:\Users\rudit\Downloads\2020_20-03_HHG_CDI_static__run021__to__run033\run0000"+k+"_DA01_00000.h5","/tof_digitizer/trace");
B=h5read("D:\Users\rudit\Downloads\2020_20-03_HHG_CDI_static__run021__to__run033\run0000"+k+"_DA01_00000.h5","/tof_digitizer/time_axis_step_in_s");
for n=(1:length(A))
    y=sum(A(n,:));
    x=n*(B(1)*1000000);
    if n==1
        X=[x];
        Y=[y];
    else
        X=[X x];
        Y=[Y y];
    end
end
Y=Y*(-1);
s=size(A);
Y=Y/s(2);
plot(X,Y);
xlabel("Zeit in us");
ylabel("Signal (V)");
xlim([min(X) max(X)]);
title("gemittelte TOF trace aus Run 0"+k+" (Spannungen invertiert)");
saveas(gcf,"average_tof_trace_run"+k+".png","png");

plot(X,Y);
xlabel("Zeit in us");
ylabel("Signal (V)");
xlim([min(X) 4]);
title("gemittelte TOF trace aus Run 0"+k+", rangezoomt");
saveas(gcf,"average_tof_trace_zoom_run"+k+".png","png");

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

%Festlegen Offset
len=length(Y);

aver=mean(Y(42000:len));

%Integrieren über Xe 1+ Peak
for n=(idl1:idr1-1)
    d=(X(n+1)-X(n));
    val=Y(n)+0.5*(Y(n+1)-Y(n));
    off=aver*d;
    int1=(val*d-aver*d);
    
    if n==idl1
        Int1=[int1];
    else
        Int1=[Int1 int1];
    end
end

for a=(idl2:idr2-1)
    d2=(X(a+1)-X(a));
    val2=Y(a)+0.5*(Y(a+1)-Y(a));
    off=aver*d2;
    int2=(val2*d2-aver*d2);
    
    if a==idl2
        Int2=[int2];
    else
        Int2=[Int2 int2];
    end
end

%for b=(idl3:idr3-1)
%    d3=(X(b+1)-X(b));
%    val3=Y(b)+0.5*(Y(b+1)-Y(b));
%    off=aver*d3;
%    int3=(val3*d3-aver*d3);
%    
%    if b==idl3
%        Int3=[int3];
%    else
%        Int3=[Int3 int3];
%    end


Ar1=sum(Int1);
Ar2=sum(Int2);


%Ar3=sum(Int3);
if m==1
    AR1=[Ar1];
    AR2=[Ar2];
    %AR3=[Ar3];
    Z=[m];
else
    AR1=[AR1 Ar1];
    AR2=[AR2 Ar2];
    %AR3=[AR3 Ar3];
    Z=[Z m];
end
end
Div2=AR2./AR1;
Div2=Div2/max(Div2);
%Div3=AR3./AR1;
%Div3=Div3/max(Div3);

AR1=AR1/max(AR1);
AR2=AR2/max(AR2);
%AR3=AR3/max(AR3);
%Z=Z/10;
plot(z,AR1,z,AR2);
legend("Xe 1+","Xe 2+","location","northeast");
title("Integral über Xe-Peaks für verschiedene Runs");
xlabel("Position entlang der Strahlachse [mm]");
ylabel("Integral, auf 1 normiert");
saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\TOF_Trace_integrals_test_h5_run_021_033.png","png");

plot(z,Div2);
legend("Xe2+/Xe1+","location","southwest");
title("Fläche des Xe2+ Peaks im Verhältnis zum Xe1+ Peak");
xlabel("Position entlang der Strahlachse [mm]");
ylabel("Quotient");
saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\TOF_Trace_Divided_h5_test.png","png");

