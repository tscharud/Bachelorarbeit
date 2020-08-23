%Analyse Scan 030, 10um apertur entlang Strahlachse

%Einlesen der csv-Dateien
%horizontale Position
A=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\2d_10um_x_mechonics_along_beam_axis_scan___neg_limit_plus_220000steps_to_280000steps____030\scan_2d_positions_hori__2020-03-17--01-01-18-755222.csv");
%vertikale Position
B=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\2d_10um_x_mechonics_along_beam_axis_scan___neg_limit_plus_220000steps_to_280000steps____030\scan_2d_positions_vert__2020-03-17--01-01-18-755222.csv");
%Integrale
C=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\2d_10um_x_mechonics_along_beam_axis_scan___neg_limit_plus_220000steps_to_280000steps____030\scan_2d_integrals__2020-03-17--01-01-18-755222.csv");

for n=(1:16)
    l=216000+n*4000;
    X=A(n,:);
    X=reshape(X,[121,1]);
    Y=C(n,:);
    Y=reshape(Y, [121,1]);
    
    
    %Fit an Daten
    T1=22+n*2;
    T2=98+n;
    k1=mean(Y(1:T1));
    k2=mean(Y(T2:121));
    k=(k1+k2)/2;
    Y2=Y-k;
    
        %Fit mit cftool
    g=fit(X,Y2,'Gauss1');
    G=coeffvalues(g);
    Con=confint(g);
    a1=G(1);
    alc=Con(1,1);
    auc=Con(2,1);
    b1=G(2);
    blc=Con(1,2);
    buc=Con(2,2);
    c1=G(3);
    clc=Con(1,3);
    cuc=Con(2,3);
    f=a1*exp(-((X-b1)/c1).^2);
    plot(X,Y2,X,f);
    title("Scan 030 mit 10\mum Apertur "+l+" Schritte vom neg. Limit entfernt");
    xlabel("Smaract-Position in \mum");
    ylabel("Integral (bel. Einheiten)");
    xlim([min(X) max(X)]);
    legend("Scan","Fit");
    saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\030\fit_"+l+"_new.png","png")
    
    Q=[a1,alc,auc,b1,blc,buc,c1,clc,cuc];
    Q=array2table(Q);
    writetable(Q, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\030\fit_parameters_new_"+l+".txt")
    if n==1
        L=[l];
        A1=[a1];
        B1=[b1];
        C1=[c1];
        Alc=[alc];
        Auc=[auc];
        Blc=[blc];
        Buc=[buc];
        Clc=[clc];
        Cuc=[cuc];
    else
        L=[L;l];
        A1=[A1;a1];
        B1=[B1;b1];
        C1=[C1;c1];
        Alc=[Alc;alc];
        Auc=[Auc;auc];
        Blc=[Blc;blc];
        Buc=[Buc;buc];
        Clc=[Clc;clc];
        Cuc=[Cuc;cuc];
    end

    
    
end
W=table(L,A1,Alc,Auc,B1,Blc,Buc,C1,Clc,Cuc);
W.Properties.VariableNames{'L'}='z';
W.Properties.VariableNames{'A1'}='a1';
W.Properties.VariableNames{'Alc'}='a_lower_conf';
W.Properties.VariableNames{'Auc'}='a_upper_conf';
W.Properties.VariableNames{'B1'}='b1';
W.Properties.VariableNames{'Blc'}='b1_lower_conf';
W.Properties.VariableNames{'Buc'}='b1_upper_conf';
W.Properties.VariableNames{'C1'}='c1';
W.Properties.VariableNames{'Clc'}='c1_lower_conf';
W.Properties.VariableNames{'Cuc'}='c1_upper_conf';

writetable(W, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter_030.txt")
    


