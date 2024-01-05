clc
clear all

  addpath('ALOS','TerraSAR','AirSAR_speckled\C3','AirSAR_filtered\C3');
M=input('input data format, 1 for single polarization SAR, 3 for Quad-PolSAR: ');
L=input('nominal number of looks of the speckled data: ');

if M==1
 load TerraSAR_Lee
 load TerraSAR_PPB_S5
 load TerraSAR_PPB_S7
 load TerraSAR_BM3D_S5
 load TerraSAR_BM3D_S7
A=DEI(TerraSAR_Lee)
B=DEI(TerraSAR_PPB_S5)
C=DEI(TerraSAR_PPB_S7)
D=DEI(TerraSAR_BM3D_S5)
E=DEI(TerraSAR_BM3D_S7)
 
 load ALOS_Lee
 load ALOS_PPB_T2
 load ALOS_PPB_T3
 load ALOS_PPB_T4
 load ALOS_BM3D
F=DEI(ALOS_Lee)
G=DEI(ALOS_PPB_T2)
H=DEI(ALOS_PPB_T3)
I=DEI(ALOS_PPB_T4)
J=DEI(ALOS_BM3D)

elseif  M==3
    
config=textread('config.txt','%s');y=str2num(config{2});x=str2num(config{5});
id1=fopen('AirSAR_filtered\C3\C11.bin','r');id2=fopen('AirSAR_filtered\C3\C22.bin','r');id3=fopen('AirSAR_filtered\C3\C33.bin','r');

C1=fread(id1,[x y],'float');C2=fread(id2,[x y],'float');C3=fread(id3,[x y],'float');
fclose('all'); 
    
I1=C1+C2+C3;
A=DEI(I1)

else
  disp('Warning! please input right data format');
end 
    
    
    
