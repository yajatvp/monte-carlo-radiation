clc 
clear 

sigma=5.67*10^-8;Ts=5778;rs=695700000;
% dse=147597870000;
% sc=sigma*(Ts^4)*rs*rs/(dse*dse);
% Te=(0.7*sc/(4*sigma))^0.25;

au=149597870700;
es=0.017; 
for t=0:1:365
d(t+1)=au*(1-es*es)/(1+es*cos(2*pi*(t-4)/365));
sc(t+1)=sigma*(Ts^4)*rs*rs/(d(t+1)*d(t+1));
Te(t+1)=(sc(t+1)/(2.8*sigma))^0.25;
end

plot(Te);grid on; xlim([0,365]);%ylim([300,310]);
title('Average temperature variation of Earth annually');
ylabel('Average Earth Temperature [K]'); xlabel('Day out of 365');

pathtosave = '.\Figures\';
f=zeros(5000,10000);aa=2166; bb=2000;i=0;
for theta=0:0.001:2*pi 
    for rsun=0:1:500
        f(2500+round(rsun*cos(theta)),5000+round(rsun*sin(theta)))=1000;
    end
end


for t=0:(2*pi/12):2*pi
    y=7000-aa+aa*cos(t);x=2500+bb*sin(t);
    for theta=0:0.001:2*pi
        for rp=0:1:200
            f(round(x)+round(rp*cos(theta)),round(y)+round(rp*sin(theta)))=Te(i*30+1);
        end
    end
    %set(gcf, 'Position', get(0, 'Screensize'));
    set(gcf,'Position', [100 100 500 210]);
    pcolor(f); shading flat; c=colorbar; caxis([300,310]);c.Label.String='Earth Temperature[K]'; 
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
