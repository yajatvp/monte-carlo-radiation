clc
% File names below correspond to radii (2_4397e5 => 2.4397e5)
A=load('2_4397e5.txt');
B=load('1_00e5.txt');
C=load('5_00e4.txt');
D=load('1_00e4.txt');
E=load('5_00e3.txt');
F=load('1_00e3.txt');

len=2.4482e7;
dx=len/50;
for l=1:51
    d(l)=dx*(l-1);
end
Ts = 700; % K
for j=1:51
    A1(j,1)=A(j,1); %sf_an
    A2(j,1)=A(j,2); %sf
    B1(j,1)=B(j,1); %sf_an
    B2(j,1)=B(j,2); %sf
    C1(j,1)=C(j,1); %sf_an
    C2(j,1)=C(j,2); %sf
    D1(j,1)=D(j,1); %sf_an
    D2(j,1)=D(j,2); %sf
    E1(j,1)=E(j,1); %sf_an
    E2(j,1)=E(j,2); %sf
    F1(j,1)=F(j,1); %sf_an
    F2(j,1)=F(j,2); %sf
end

for n=1:51
    TPA(n)=((Ts^4)*(1-((1-2*A2(n))^2))/4)^(0.25);TPAn(n)=((Ts^4)*(1-((1-2*A1(n))^2))/4)^(0.25);
    TPB(n)=((Ts^4)*(1-((1-2*B2(n))^2))/4)^(0.25);
    TPC(n)=((Ts^4)*(1-((1-2*C2(n))^2))/4)^(0.25);TPCn(n)=((Ts^4)*(1-((1-2*C1(n))^2))/4)^(0.25);
    TPD(n)=((Ts^4)*(1-((1-2*D2(n))^2))/4)^(0.25);
    TPE(n)=((Ts^4)*(1-((1-2*E2(n))^2))/4)^(0.25);
    TPF(n)=((Ts^4)*(1-((1-2*F2(n))^2))/4)^(0.25);
end  

% figure(1)
% plot(TPC)
% hold on
% plot(TPCn)
% plot(TPB)
% plot(TPC)
% plot(TPD)
% plot(TPE)
% plot(TPF)
% 
% figure(2)
% loglog(TPA)
% hold on
% loglog(TPB)
% loglog(TPC)
% loglog(TPD)
% loglog(TPE)
% loglog(TPF)

% sigma=5.67*10^-8;Ts=5778;rs=695700000;
% % dse=147597870000;
% % sc=sigma*(Ts^4)*rs*rs/(dse*dse);
% % Te=(0.7*sc/(4*sigma))^0.25;
% 
% au=149597870700;
% es=0.96714; 
% for t=0:1:365
% d(t+1)=17.834*au*(1-es*es)/(1+es*cos(2*pi*(t)/365));
% sc(t+1)=sigma*(Ts^4)*rs*rs/(d(t+1)*d(t+1));
% Te(t+1)=(0.96*sc(t+1)/(4*sigma))^0.25;
% end
TPCn=[364.221045474640    368.057250790529    370.447517691002    371.242578445095    370.390651309897    367.947180288414    364.064417902048    358.964605204927    352.905640939880    346.148702961917    338.934090865257    331.467246025260    323.913674931488    316.400068947168    309.018881057647    301.834267187870    294.888074981849    288.205196041107    281.798020611365    275.669975632527    269.818243635554    264.235801334290    258.912918427319    253.838240980904    248.999561907846    244.384359475171    239.980165962020    235.774813245198    231.756590062569    227.914336512901    224.237494448183    220.716127290333    217.340919031831    214.103159419404    210.994720309660    208.008026724862    205.136025081867    202.372150304386    199.710292982235    197.144767347212    194.670280558280    192.281903588749    189.975043872107    187.745419765417    185.589036824618    183.502165844827    181.481322587379    179.523249103762    177.624896554386];
pathtosave = '.\';
f=zeros(5000,10500);
for theta=0:0.001:2*pi 
    for rsun=0:1:500
        f(2000+round(rsun*cos(theta)),1250+round(rsun*sin(theta)))=1000;
    end
end

ff=f;i=1;
for y=250:200:10250
    f=ff;
    for theta=0:0.001:2*pi
        for rp=0:1:150
            f(3500+round(rp*cos(theta)),y+round(rp*sin(theta)))=TPCn(i);
        end
    end
    %set(gcf, 'Position', get(0, 'Screensize'));
    set(gcf,'Position', [100 100 500 210]);
    pcolor(f); shading flat; c=colorbar; caxis([150,400]);c.Label.String="Probe Temperature[K]"; 
    saveas(gca,fullfile(pathtosave,['',num2str(i)]),'png');
    i=i+1;
end

list = dir('.\*.png');
% create the video writer with 1 fps
writerObj = VideoWriter('myVideo.avi');
writerObj.FrameRate = 1;
% set the seconds per image
secsPerImage = 1;%[5 10 15];
% open the video writer
open(writerObj);
% write the frames to the video
for u=1:length(list)
    images{u}=imread(list(u).name);
    % convert the image to a frame
    frame = im2frame(images{u});
    for v=1:secsPerImage
        writeVideo(writerObj, frame);
    end
end
% close the writer object
close(writerObj);
