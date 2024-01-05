The source codes and sample datasets are provided by Xiaoshuang Ma, Anhui University, China.

EPD.m is the program to implement the EPD-ROA indicator;

run_DEI.m is the program to implement the DEI indicator;

RGO_BAI.m is the program to implement the RGO-BAI indicator;

Sample datasets include:
1) Single polarization SAR intensity data: the single-look ALOS and TerraSAR-X images, where ALOS_PPB_T2.mat file is  the image filtered by PPB with 2 ieteration times; TerraSAR_PPB_S5.mat file is the image filtered by PPB with 5*5 patch size; other .mat files are similarly defined.
3) Fully polarimetric SAR data: the 4-look AirSAR data, where the "AirSAR_speckled" folder provides the C3 files of the speckled data,and the "AirSAR_filtered" folder provides the C3 files of the nonlocal means filtered data.