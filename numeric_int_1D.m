%1D-Numerical Integration
A0=100;
sigma=3;
r=10;
e=exp(1);
y=(-80:0.1:80);
for n=1:length(y)
    x0=y(n)
    fun = A0*exp(-((y-x0).^2./sigma^2));
    for m=1:length(fun)
        if fun(m)<A0/e^2
            fun(m)=0;
        end
    end
    fun2=fun(701:901);
    q=trapz(fun2);
    f(n)=q;
end

plot(y,f)
