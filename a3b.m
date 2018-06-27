% Imagen estimada con traslape
% f(x,y) = s(x,y) + n(x,y)
%
close all;
clear all;
clc;
Im = imread('engrans.JPG');
Img = (double(rgb2gray(Im)))/255;
[fil,col] = size(Img);
s=5;    % Longitude de la ventana
esp=(s-1)/2;  % esp: espacio de la ventana al centro de esta
Imamp=zeros(fil+2*esp,col+2*esp);   % Imagen agregandole ceros
[nfil,ncol]=size(Imamp);
for f=1:fil
   for c=1:col
       Imamp(f+esp,c+esp)=Img(f,c);
   end
end
Iruido = imnoise(Imamp,'gaussian',0,.1);
%% Traslape
tras=round(s*2/3);
Imrest(nfil-s,ncol-s)=0;
%% Imagen filtrada
for f=1:nfil-s
    for c=1:ncol-s
        %% Estimación de la varianza del ruido
        IRUIDO=fft2(Iruido(f:f+s-1,c:c+s-1));
        autcorr=ifft2(IRUIDO.*IRUIDO)/(s*s);
        csec = extquad(autcorr(1,2), autcorr(1,3), autcorr(1,4),1,2,3,0);
        csef = extquad(autcorr(2,1), autcorr(3,1), autcorr(4,1),1,2,3,0);
        csefc= extquad(autcorr(2,2), autcorr(3,3), autcorr(4,4),1,2,3,0);
        cse=csec-csefc-csef;
        newvar=(autcorr(1,1)-cse);
        if newvar<0
            newvar=0;
        end
        
        media = (sum(sum(Iruido(f:f+s-1,c:c+s-1))))/(s*s);
        vsignal=sum(sum((Iruido(f:f+s-1,c:c+s-1)-media).^2))/(s*s);
        Imrest(f+esp,c+esp)=media+(vsignal/(vsignal+newvar))*(Iruido(f+esp,c+esp)-media);
    end
end
%% PSNR
MSE=sum((sum(Imamp(1:nfil-3,1:ncol-3)-Imrest).^2))/(nfil*ncol);
PSNR = 10*log10((255^2)/MSE);
disp(PSNR);

%% Plot imágenes
figure;
subplot(1,3,1);
imshow(Img);
title('Imagen limpia');
subplot(1,3,2);
imshow(Iruido);
title('Imagen con ruido gaussiano');
subplot(1,3,3);
imshow(Imrest);
title('Imagen restaurada');
