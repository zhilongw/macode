function S=calculate_index(x_noisy,x_filtered,L)
   N=9;  % window size of the patches to caculate ratio gradient, defult 3*3 
%% calculate confidence level [cmin, cmax]
  switch L
      case 1
          K=2.2;
      case 2
          K=3.0;
      case 3
          K=2.5;
      case 4
          K=5.0;
      case 5
          K=2.0;
      case 6
          K=1.9;
  end
  
  
  
  [x,y]=size(x_noisy);
    pixelnum=0; S=0;
    
    h=waitbar(0,'calculating index...'); 
 for m=10:x-9
        waitbar((m-9)/(x-18),h)
 for n=10:y-9

%% compute homogeneity
  a=x_noisy(m-3:m+3,n-3:n+3); a=a(:);
  hom=(var(a)-mean(a)^2/L)/(1+1/L);
  
   if hom>0  %% nonhomogeneouse areas
       
       
    flag1=0;flag2=0;flag3=0;flag4=0;

  % up left to lower right
    A=x_noisy(m-3:m-1,n-1:n+1);a1=mean(A(:)); 
    B=x_noisy(m+1:m+3,n-1:n+1);b1=mean(B(:));
    C=x_filtered(m-3:m-1,n-1:n+1);C=mean(C(:));  
    D=x_filtered(m+1:m+3,n-1:n+1);D=mean(D(:));
    A1=a1/b1;  B1=C/D;
    [cmin,cmax]=confidence_level(B1,N,L,K);
    if A1>=cmin & A1<=cmax
        flag1=1;
    end
        
        
   % left to right
    A=x_noisy(m-1:m+1,n-3:n-1);a2=mean(A(:));  
    B=x_noisy(m-1:m+1,n+1:n+3);b2=mean(B(:));
    C=x_filtered(m-1:m+1,n-3:n-1);C=mean(C(:));  
    D=x_filtered(m-1:m+1,n+1:n+3);D=mean(D(:));
    A2=a2/b2;  B2=C/D;
   [cmin,cmax]=confidence_level(B2,N,L,K);
    if A2>=cmin & A2<=cmax
        flag2=1;
    end
    
    
   % lower left to up right 
    A=x_noisy(m-3:m-1,n-3:n-1);a3=mean(A(:));  %左上右下
    B=x_noisy(m+1:m+3,n+1:n+3);b3=mean(B(:));
    C=x_filtered(m-3:m-1,n-3:n-1);C=mean(C(:));  %左上右下
    D=x_filtered(m+1:m+3,n+1:n+3);D=mean(D(:));   
    A3=a3/b3;  B3=C/D;
   [cmin,cmax]=confidence_level(B3,N,L,K);
    if A3>=cmin & A3<=cmax
        flag3=1;
    end
    
    
    % up to down
    A=x_noisy(m-3:m-1,n+1:n+3);a4=mean(A(:));  %右上左下
    B=x_noisy(m+1:m+3,n-3:n-1);b4=mean(B(:));
    C=x_filtered(m-3:m-1,n+1:n+3);C=mean(C(:));  %右上左下
    D=x_filtered(m+1:m+3,n-3:n-1);D=mean(D(:));   
    A4=a4/b4;  B4=C/D;
   [cmin,cmax]=confidence_level(B4,N,L,K);
    if A4>=cmin & A4<=cmax
        flag4=1;
    end
     
    S=S+flag1+flag2+flag3+flag4;
    pixelnum=pixelnum+1;
   end
    
 end
 end
    S=S/pixelnum/4;
    close(h);
           
    
end


  
function [cmin,cmax]=confidence_level(r,N,L,K)
r;
%% numeric searching approach for solving cmin and cmax (slow, not suggested) 
% c=0.9;
%     syms R
%    
%     F=  gamma(2*N*L)/gamma(N*L)^2*  r^(N*L)/(R+r)^(2*N*L)  *  R^(N*L-1);
% 
% %% calculate cmin    
% a=0;cmin=0;
% while a<(1-c)/2
%  cmin=cmin+0.05*r/L;
%     a=vpa(int(F,0,cmin)/int(F,0,100));
% end
% 
% %% calculate cmax    
% b=0;cmax=r;
% while b<c
%  cmax=cmax+0.1*r/L;
%     b=vpa(int(F,cmin,cmax)/int(F,0,100));
% end
% 
% r1=cmax/cmin
% r2=sqrt(cmax*cmin)
% r3=(cmax+cmin)/2
%% fast and approximate solutions for cmin and cmax 
%    cmin=r/1.5/L^0.5;
%    cmax=r*1.5/L^0.5; 
   cmin=r/sqrt(K);
   cmax=r*sqrt(K); 
end
