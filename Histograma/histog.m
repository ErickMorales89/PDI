%% Hisgrama de una imagen
%%
%%
close all; 
clear all;
clc;

img = imread("Imagen3.jpg");
[x y]=size(img);
% Variables para histogramas
v=zeros(1,256);
vb=zeros(1,256);
x*y
Ma = img(1,1);    % valor Máximo
mi = img(1,1);    % valor mínimo
for in = 1:x
  for jn = 1:y
    if img(in,jn)>Ma
      Ma = img(in,jn);
    endif
    if img(in,jn)<mi
     mi = img(in,jn);
    endif
    % Histograma
    v(img(in,jn)) = v(img(in,jn)) + 1;
  endfor
endfor
dife = Ma-mi;
linss = 255/dife;
for i = 1:x
  for j = 1:y
    % Variación local del contraste
    imgb(i,j) = (img(i,j)-mi)*linss;
  endfor
endfor

Mab = imgb(1,1);    % valor Máximo
mib = imgb(1,1);    % valor mínimo

for ix = 1:x
  for jy = 1:y
    vb(imgb(ix,jy)+1) = vb(imgb(ix,jy)+1) + 1;
    if imgb(ix,jy)>Mab
      Mab = imgb(ix,jy);
    endif
    if imgb(ix,jy)<mib
     mib = imgb(ix,jy);
    endif
  endfor
endfor
figure;
set(gcf,'Name','Imagen original') 
subplot(1,2,1);
imshow(img);
title('Imagen');
subplot(1,2,2);
stem(v);
title('Histograma');
%bar(v);
figure;
set(gcf,'Name','Variaci´on local del contraste') 
subplot(1,2,1);
imshow(imgb);
title('Imagen');
subplot(1,2,2);
stem(vb);
title('Histograma');