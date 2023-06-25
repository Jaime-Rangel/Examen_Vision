function [PcI,PcV,PcD]=mypca(Data,nkeep)

% [PcI,PcV,PcD]=mypca(Data,10);
% Data(220,33)

[nrows,ncols]=size(Data);

Data=Data-repmat(mean(Data),nrows,1);
%Data=Data./repmat(std(Data),nrows,1);

cvm=cov(Data); %covariance matrix
[V,D]=eig(cvm);

d=diag(D);
[a,I]=sort(-d);
DD=diag(-a);
VV=[];
for i=1:ncols
  VV=[VV V(:,I(i))];
end
clear V D
V=VV;
D=DD;

PcV=V(:,1:nkeep);
PcD=D(1:nkeep,1:nkeep)/sum(diag(D)); 

IM=Data*V*inv(sqrt(D));
PcI=IM(:,1:nkeep);

%plot(diag(D),'o')

if (0)
figure
plot(diag(D))
grid on
title('Eigen Values')
   
figure
for i=1:nkeep
   subplot(1,nkeep,i)
   plot(PcI(:,i))
end 
end