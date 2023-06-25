clear all
close all

% Ejemplo de creación del modelo estadístico de forma usando  análisis de componentes principales
% y calculo de parametros de regresion lineal sobre componentes principales de la base de datos.

% Vector de posiciones predefinidas. 
% Secuencia de tuplas (x,y) por punto.
puntos=[73,199,64,168,62,137,64,118,61,101,60,87,63,65,72,83,75,96,79,109,80,83,79,64,86,41,94,63,94,81,97,102,102,74,104,57,112,31,119,56,118,76,116,102,124,80,128,63,141,43,143,69,141,85,135,105,135,123,141,140,158,124,184,117,171,136,156,158,137,175,122,191]; % Coordenadas base

figure % Viendo los datos
subplot(2,2,1)
title('Base points')
img=imread('Mano.jpg');
imagesc(img)
hold on
for i=1:2:72
        plot(puntos(i),puntos(i+1),'ok')
end

aux=repmat(puntos,100,1); % Generación de eventos

noise=randn(100,72)*1.5; % Ruido
DB=aux+noise;

subplot(2,2,2) % Viendo los datos
title('Data')
imagesc(img)
hold on
for i=1:2:72
    for j=1:100
        plot(DB(j,i),DB(j,i+1),'.k')
    end
end

m=mean(DB')';
DBm=DB-repmat(m,1,72); % Haciendo la base de datos con media cero

% Calculando los componentes principales usando PCA
PcI=mypca(DBm',4)'; % Número de componentes requerido

PcIm=PcI-repmat(mean(PcI')',1,72);

% Regresion lineal de los datos en los componentes

A=inv(PcIm*PcIm'); 
B=PcIm*DB'; 
alphas=A*B; % Parametros de regresion
models=alphas'*PcIm+repmat(m,1,72); % Reconstruyendo los datos

DB=DB+repmat(m,1,72);

% Comparando resultados.
subplot(2,2,3) % Viendo los datos
title('Models')
imagesc(img)
hold on
for i=1:2:72
    for j=1:100
        plot(models(j,i),models(j,i+1),'.r')
    end
end

subplot(2,2,4)
title('Parameters')
hist(alphas(1,:),15)
hold on
hist(alphas(2,:),15)

figure

subplot(2,2,1)
title('Parameters')
hist(alphas(1,:),15)
subplot(2,2,2)
hist(alphas(2,:),15)
subplot(2,2,3)
hist(alphas(3,:),15)
subplot(2,2,4)
hist(alphas(4,:),15)