%Quelle nichtlineare Regression: https://www.youtube.com/watch?v=8eHYx5RYfMk
%Gaussian Fit%


   T=readtable("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\002-021_ROI.txt");
   T=table2array(T);
   
   for n=(1:1:20)  
   
       m=n+1;
       q1=T(n,1);
       q2=T(n,2);
    %Eingabe der csv-Dateien als Arrays
    if m<=9
    %Position
    A=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\00"+m+"\Position.csv");
    %Werte
    B=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\00"+m+"\Integrals.csv");
    else
        %Position
    A=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\0"+m+"\Position.csv");
    %Werte
    B=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\0"+m+"\Integrals.csv");
    end
    %Reduzierung auf ROI
    l=length(A);
    q1=T(n,1);
    q2=T(n,2);
    k1=mean(B(1:q1));
    k2=mean(B(q2:l));
    k=((k1+k2)/2);
    a=A(q1:q2);
    d=B(q1:q2);
    d=d-k;
    g=fit(a,d,'Gauss1');
    G=coeffvalues(g);
    Con=confint(g);
    a1=G(1);
    b1=G(2);
    c1=G(3);
    f=a1*exp(-((a-b1)/c1).^2);
    alc=Con(1,1);
    auc=Con(2,1);
    blc=Con(1,2);
    buc=Con(2,2);
    clc=Con(1,3);
    cuc=Con(2,3);   
    Q=[a1,alc,auc,b1,blc,buc,c1,clc,cuc];
    Q=array2table(Q);
    if m<=9
        writetable(Q, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\00"+m+"\fit_parameters_new.txt")
    else
        writetable(Q, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\0"+m+"\fit_parameters_new.txt")
    end
    
    plot(a,d,a,f);
    set(gca,'FontSize',17);
    title("Plot von Scan "+m+" (50\mum Apertur) mit Gauß-Fit");
    xlabel("Smaract-Position in \mum");
    ylabel("Integral (bel. Einheiten)");
    legend("Scan", "Gauß-Fit");
    xlim([min(a) max(a)]);
    if m<=9
    saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\00"+m+"\Scan_"+m+"_new.png","png");
    else
        saveas(gcf, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\0"+m+"\Scan_"+m+"_new.png","png");
    end
    
    if n==1
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
m=(2:21);
m=reshape(m,[20 1]);
W=table(m,A1,Alc,Auc,B1,Blc,Buc,C1,Clc,Cuc);
W.Properties.VariableNames{'m'}='Scan';
W.Properties.VariableNames{'A1'}='a1';
W.Properties.VariableNames{'Alc'}='a_lower_conf';
W.Properties.VariableNames{'Auc'}='a_upper_conf';
W.Properties.VariableNames{'B1'}='b1';
W.Properties.VariableNames{'Blc'}='b1_lower_conf';
W.Properties.VariableNames{'Buc'}='b1_upper_conf';
W.Properties.VariableNames{'C1'}='c1';
W.Properties.VariableNames{'Clc'}='c1_lower_conf';
W.Properties.VariableNames{'Cuc'}='c1_upper_conf';

writetable(W, "C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Scan_Auswertung\Fit-Parameter.txt")
