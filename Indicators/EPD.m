clc
clear all


  addpath('ALOS','TerraSAR','AirSAR_speckled\C3','AirSAR_filtered\C3');
M=input('input data format, 1 for single polarization SAR, 3 for Quad-PolSAR: ');
L=input('nominal number of looks of the speckled data: ');

if M==1
 
load TerraSAR_noisy
 load TerraSAR_Lee
 I1=TerraSAR_noisy;
 I2=TerraSAR_Lee;
[x y]=size(I1);

I11=I1(1:x-1,1:y-1);I12=I1(2:x,2:y);
I21=I2(1:x-1,1:y-1);I22=I2(2:x,2:y);

A=0;B=0;
for i=1:(x-1)
for j=1:(y-1)
    if I22(i,j)~=0 & I12(i,j)~=0
        A=A+I21(i,j)/I22(i,j);
        B=B+I11(i,j)/I12(i,j);
    end
end
end

EPD_ROA= A/B


elseif M==3
    
config=textread('config.txt','%s');y=str2num(config{2});x=str2num(config{5});
id1=fopen('AirSAR_speckled\C3\C11.bin','r');id2=fopen('AirSAR_speckled\C3\C22.bin','r');id3=fopen('AirSAR_speckled\C3\C33.bin','r');
id4=fopen('AirSAR_filtered\C3\C11.bin','r');id5=fopen('AirSAR_filtered\C3\C22.bin','r');id6=fopen('AirSAR_filtered\C3\C33.bin','r');

C1=fread(id1,[x y],'float');C2=fread(id2,[x y],'float');C3=fread(id3,[x y],'float');
C4=fread(id4,[x y],'float');C5=fread(id5,[x y],'float');C6=fread(id6,[x y],'float');
fclose('all'); 
    
I1=C1+C2+C3;
I2=C4+C5+C6;

I11=I1(1:x-1,1:y-1);I12=I1(2:x,2:y);
I21=I2(1:x-1,1:y-1);I22=I2(2:x,2:y);

A=0;B=0;
for i=1:(x-1)
for j=1:(y-1)
    if I22(i,j)~=0 & I12(i,j)~=0
        A=A+I21(i,j)/I22(i,j);
        B=B+I11(i,j)/I12(i,j);
    end
end
end

EPD_ROA= A/B   
   
    
else
  disp('Warning! please input right data format');
end 

 
 
 
 

