clear clc
r1=695700000; r2=1100;
d=17.83*149597870000;
% r1=1; r2=0.00917;
% d=215;
% r1=5; r2=1; d=10;
nrays=1000000; %no. of rays into consideration
nhits=0; %initializing 
count=0;
for i=1:nrays
    %% creating ray source
    phi=2*pi*rand;
    theta1=acos(1-rand);
    source=[r1*sin(theta1)*cos(phi) r1*sin(theta1)*sin(phi) d-r1*cos(theta1)];
    if source(3)<d
        count=count+1;
        aa=sqrt(source(1)^2+source(2)^2+(source(3)-d)^2);
        n=[source(1)/aa source(2)/aa (source(3)-d)/aa]; %creating normal to point source on sphere
        %% creating direction
        lol=null(n)';
        t1=lol(1,:); t2=lol(2,:);
        theta=asin(sqrt(rand)); psi=2*pi*rand; %in the x-y plane
        u=cos(theta)*n + sin(theta)*(cos(psi)*t1+sin(psi)*t2); %direction of current ray
        %% checking for intersection with the sphere
        po=source+u;
        dist=norm(cross(source,u))/norm(u);
        %     sphere_centre=[0 0 0.2];
        %     dist=norm(cross((source-sphere_centre),u))/norm(u); %perpendicular dist. of the centre from the line of ray
        if dist<=r2 && u(3)<0
            nhits=nhits+1;
        end
    end
end
shape_factor=nhits/nrays/2; %shape factor from disk to sphere
sf_an=(1-sqrt(1-(r2/d)^2))*(1-sqrt(1-(r1/d)^2))/((r1/d)^2);
sf_an1=(1-sqrt(1-(r2/d)^2))*0.5;

sf_an
sf_an1
shape_factor

% sigma=5.67*10^-8;Ts=5778;rs=695700000;dse=152597870000;
% sc=sigma*(Ts^4)*rs*rs/(dse*dse);
% Te=(0.7*sc/(4*sigma))^0.25;