function D=DEI(x_refer)
    %%    计算结构丢失指??
    total=0;number1=0;
    [x, y]=size(x_refer);
%    ratio=x_noisy./x_refer;
 x_refer(isnan(x_refer)==1)=1;
 
    h=waitbar(0,'Calculating DEI....: ');
    for m=13:23:x-12
        waitbar((m-12)/(x-24),h)
    for n=13:23:y-12
        AA=x_refer(m-11:m+11,n-11:n+11); 
%         S=std(AA(:))/mean(AA(:));
        S=std(AA(:))/mean(AA(:));number1=number1+1; number2=0;
        for p=m-11:m+11
        for q=n-11:n+11
            number2=number2+1;
            BB=x_refer(p-1:p+1,q-1:q+1);
            s(number2)=std(BB(:))/mean(BB(:));
        end
        end
        

            total=total+ min(s)/S;
        
    end
    end
        D=total/number1;

close(h)
    