%Scan 023
%horizontale Position
A=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\2d_x_mechonics_along_beam_axis___neg_limit_plus_280000steps____023\scan_2d_positions_hori__2020-03-16--21-36-18-167669.csv");
%vertikale Position
B=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\2d_x_mechonics_along_beam_axis___neg_limit_plus_280000steps____023\scan_2d_positions_vert__2020-03-16--21-36-18-167669.csv");
%Integrale
C=csvread("C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Daten\focus_scan_tool\2d_x_mechonics_along_beam_axis___neg_limit_plus_280000steps____023\scan_2d_integrals__2020-03-16--21-36-18-167669.csv");
B=B/40;
Q=surf(A,B,C);
%Q.EdgeColor="none";
view(0,90);
xlabel("SmarAct-Position [\mum]");
ylabel("Mechonics-Position [\mum]");
xlim([min(min(A)) max(max(A))]);
ylim([min(min(B)) max(max(B))]);
title("2D-Strahlprofil des XUV 7mm vom negativne Limit entfernt ");
saveas(gcf,"C:\Users\rudit\Desktop\Uni\Bachelor\Bachelor-Arbeit\Bilder\3D_plot_Scan_023_view.png","png");