function [] = test0_15( ag,xng,esik,d,objit)

b4luk='';
xn=xng;
a=ag;
e=esik;

onbesli=zeros(16,2);

for i=1:16
    onbesli(i,1)=i-1;
end

for j=1:d
    xn1=a*xn*(1-xn);
    xn=xn1;
    if(xn1<e)
        b4luk = strcat(b4luk,'0');
    else
        b4luk = strcat(b4luk,'1');
    end
    if(length(b4luk)==4)
        switch (b4luk)
            case '0000',
                k=0;
            case '0001',
                k=1;
            case '0010',
                k=2;
            case '0011',
                k=3;
            case '0100',
                k=4;
            case '0101',
                k=5;
            case '0110',
                k=6;
            case '0111',
                k=7;
            case '1000',
                k=8;
            case '1001',
                k=9;
            case '1010',
                k=10;
            case '1011',
                k=11;
            case '1100',
                k=12;
            case '1101',
                k=13;
            case '1110',
                k=14;
            case '1111',
                k=15;
        end
        onbesli(k+1,2)=onbesli(k+1,2)+1;
        b4luk='';
    end
end
disp('0-15 Adet');
disp(onbesli);
plot(objit);
end

