%Test for Integrating over the Xe peaks in the TOF trace
%Plotting of the Traces
for m=(40:5:140)
fid=fopen("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\TOF Traces\S.85\IR_z_scan_"+m+".csv");
t=fgetl(fid);
M=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\TOF Traces\S.85\IR_z_scan_"+m+".csv",1);
id1=strfind(t,'XIN');
w=t(id1+7:id1+18);
xin=str2num(w);
id2=strfind(t,'YMU');
v=t(id2+7:id2+17);
v=strrep(v,'"',' ');
ymu=str2num(v);
id3=strfind(t,'YOF');
u=t(id3+7:id3+13);
yof=str2num(u);
for n=(1:size(M))
    x=n*xin;
    y=((M(n)-yof)*ymu);
    if n==1
        X=[x];
        Y=[y];
    else
        X=[X x];
        Y=[Y y];
    end
end
Y=Y*(-1);
m2=m/10;
plot(X,Y);
title("TOF trace mit NIR bei z="+m2+"mm mit Xe");
xlabel("Zeit in s");
ylabel("Spannung in V (invertiert)");
xlim([0 5.5e-6]);
saveas(gcf, "TOF_Trace_IR_z_scan_z_"+m+"_cropped.png","png");


%Begrenzen der Xe Peaks
%Xe 1+ (linke und rechte Grenze)
L1=3.65e-6;
R1=max(X);

%Xe 2+ (Linke und rechte Grenze)
L2=L1-1.15e-6;
R2=R1-1.15e-6;

%Xe 3+ (Linke und rechte Grenze)
L3=1.9e-6;
R3=2.2e-6;

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

diffl3=X-L3;
[q4,idl3]=min(abs(diffl3));
if diffl3(idl3)>0
    idl3=idl3-1;
else
    idl3=idl3;
end

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

diffr3=X-R3;
[q6, idr3]=min(abs(diffr3));
if diffr3(idr3)<0
    idr3=idr3+1;
else
    idr3=idr3;
end

%Festlegen Offset
len=length(Y);
aver=mean(Y(7300:9000));

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

for b=(idl3:idr3-1)
    d3=(X(b+1)-X(b));
    val3=Y(b)+0.5*(Y(b+1)-Y(b));
    off=aver*d3;
    int3=(val3*d3-aver*d3);
    
    if b==idl3
        Int3=[int3];
    else
        Int3=[Int3 int3];
    end
end

Ar1=sum(Int1);
Ar2=sum(Int2);
Ar3=sum(Int3);
if m==40
    AR1=[Ar1];
    AR2=[Ar2];
    AR3=[Ar3];
    Z=[m];
else
    AR1=[AR1 Ar1];
    AR2=[AR2 Ar2];
    AR3=[AR3 Ar3];
    Z=[Z m];
end

end

Div2=AR2./AR1;
Div2=Div2/max(Div2);
Div3=AR3./AR1;
Div3=Div3/max(Div3);

AR1=AR1/max(AR1);
AR2=AR2/max(AR2);
AR3=AR3/max(AR3);
Z=Z/10;
plot(Z,AR1,Z,AR2,Z,AR3);
legend("Xe 1+","Xe 2+","Xe 3+","location","best");
title("Integral über Xe-Peaks für verschiedene Positionen entlang der Strahlachse");
xlabel("z-Position in mm");
ylabel("Integral, auf 1 normiert");
%saveas(gcf, "TOF_Trace_006_IR_z_scan_integrals_2.png","png");

plot(Z,Div2);
legend("Xe2+/Xe1+","location","best");
title("Fläche des Xe2+ Peaks im Verhältnis zum Xe1+ Peak");
xlabel("z-Position in mm");
ylabel("Quotient");
%saveas(gcf,"TOF_Trace_006_IR_z_scan_Divided.png","png");

