clc
clear all
close all
 addpath('ALOS','TerraSAR','AirSAR_speckled\C3','AirSAR_filtered\C3');
M=input('input data format, 1 for single polarization SAR, 3 for Quad-PolSAR: ');
L=input('nominal number of looks of the speckled data: ');

if M==1
 
 load ALOS_noisy
 load ALOS_Lee
 
 x_noisy=ALOS_noisy;
 x_filtered=ALOS_Lee;
%  figure,imshow(uint8(x_filtered.^0.5)); % show the filtered Terrasar-x data
%  figure,imshow(x_filtered.^0.5);    % show the filtered ALOS data
  
ratio=x_noisy./x_filtered; 
figure,imshow(ratio); % show the ratio image

RGOBAI=calculate_index(x_noisy,x_filtered,L)   


elseif M==3
    
config=textread('config.txt','%s');y=str2num(config{2});x=str2num(config{5});
id1=fopen('AirSAR_speckled\C3\C11.bin','r');id2=fopen('AirSAR_speckled\C3\C22.bin','r');id3=fopen('AirSAR_speckled\C3\C33.bin','r');
id4=fopen('AirSAR_speckled\C3\C12_real.bin','r');id5=fopen('AirSAR_speckled\C3\C12_imag.bin','r');id6=fopen('AirSAR_speckled\C3\C13_real.bin','r');
id7=fopen('AirSAR_speckled\C3\C13_imag.bin','r');id8=fopen('AirSAR_speckled\C3\C23_real.bin','r');id9=fopen('AirSAR_speckled\C3\C23_imag.bin','r');
C0(:,:,1)=fread(id1,[x y],'float');C0(:,:,2)=fread(id2,[x y],'float');C0(:,:,3)=fread(id3,[x y],'float');
C0(:,:,4)=fread(id4,[x y],'float');C0(:,:,5)=fread(id5,[x y],'float');C0(:,:,6)=fread(id6,[x y],'float');
C0(:,:,7)=fread(id7,[x y],'float');C0(:,:,8)=fread(id8,[x y],'float');C0(:,:,9)=fread(id9,[x y],'float');
fclose('all');

id1=fopen('AirSAR_filtered\C3\C11.bin','r');id2=fopen('AirSAR_filtered\C3\C22.bin','r');id3=fopen('AirSAR_filtered\C3\C33.bin','r');
id4=fopen('AirSAR_filtered\C3\C12_real.bin','r');id5=fopen('AirSAR_filtered\C3\C12_imag.bin','r');id6=fopen('AirSAR_filtered\C3\C13_real.bin','r');
id7=fopen('AirSAR_filtered\C3\C13_imag.bin','r');id8=fopen('AirSAR_filtered\C3\C23_real.bin','r');id9=fopen('AirSAR_filtered\C3\C23_imag.bin','r');
C1(:,:,1)=fread(id1,[x y],'float');C1(:,:,2)=fread(id2,[x y],'float');C1(:,:,3)=fread(id3,[x y],'float');
C1(:,:,4)=fread(id4,[x y],'float');C1(:,:,5)=fread(id5,[x y],'float');C1(:,:,6)=fread(id6,[x y],'float');
C1(:,:,7)=fread(id7,[x y],'float');C1(:,:,8)=fread(id8,[x y],'float');C1(:,:,9)=fread(id9,[x y],'float');
fclose('all'); 
    
 x_noisy=C0(:,:,1)+C0(:,:,2)+C0(:,:,3);
 x_filtered=C1(:,:,1)+C1(:,:,2)+C1(:,:,3);
ratio=x_noisy./x_filtered; 
figure,imshow(ratio); % show the ratio image

RGOBAI=calculate_index_PolSAR(C0,C1,L)   
   
    
else
  disp('Warning! please input right data format');
end 











 
