clc
%desi problema ne da T=40s pentru a respecta D=16
%dupa cum se vede in fig semnalului triunghiular
%simetric monoalternant D=T/4=>T=64s
T=64;
f=1/T;
w=2*pi*f;
t = 0:0.0001:4*T;
%reprezint 4 perioade ca in fig
N=50;
C = zeros(1,2*N+1); %facem un vector de coeficienti pe care
                    %il initializam cu 0
x=(sawtooth(w*t,0.5)+abs(sawtooth(w*t,0.5)))/2; %construim semnalul triunghiular monoalternant
for n = -N:N
    C(n+N+1)=1/T*integral(@(t)(1/2*sawtooth(w*t,0.5)+1/2*abs(sawtooth(w*t,0.5))).*exp(-1j*n*w*t),0,T);
    re = real(C(n+N+1));
    im = imag(C(n+N+1));
    if abs(re)<10^-10 %daca modulul partii reale e mai mic decat 10^-10 (neglijabil)
                      %il aprox cu 0
        re = 0;
     end
    if abs(im)<10^-10 %daca modulul partii imaginare e mai mic decat 10^-10 il aprox cu 0
        im = 0;
    end
    C(n+N+1) = re+1j*im ;
end
xr = 0;
for n = -N:N
    xr = xr + C(n+N+1)*exp(1j*n*w*t) ; %construim seria Fourier
end
figure(1);
hold on %pastreaza graficul anterior, fara eliminarea acestuia la adaugarea unui nou grafic
plot(t,real(xr),':r',t,imag(xr),':r');
plot(t,x);
axis([-0 256 -0.1 1.1])
xlabel('Timp[s]');
ylabel('x(t) si xr(t)');

title('Suprapunerea semnalelor x(t) linie continua si xr(t) linie intrerupta')


figure(2);
hold on
stem((-N:N)*w,2*abs(C)); %functia stem este folosita pentru reprezentarea
                         %unor functii sau seturi de valori discrete
                          
plot((-N:N)*w,2*abs(C),':r');
xlabel('Pulsatia w [rad/s]');
ylabel('Amplitudinile Ak=2|C(nw)|');
axis([-5.1 5.1 0 0.55])
title('Spectrul de Amplitudini');


%in consecinta, cu ajutorul analizei Fourier
%putem exprima orice semnal periodic,in conditii precizate
%cu anumite criterii de suficienta (crit Dirichlet)
%intr-o suma finita de semnale elementare
%(oscilatii armonice,exponentiale,impuls Dirac)
%Aceasta analiza este utila in cazul analizei 
%sistemelor liniare;ne permite aflare unui semnal 
%in functie de spectrul de amplitudine/faza




