function [eniyiAAsatiri,eniyiXNsatiri,eniyiESIKsatiri,objit] = yz015 (d, suruboy,hata)
%d: kaç bit üretileceğinin sayısı
%suruboy: bir iterasyonda sezgisel olarak hesaplanacak a, başlangıç Xn ve esik sayısı.
%w,c1,c2: hız fonksiyonun sabit değerleri
w=0.5; c1=1.5; c2=2;

%Amaç fonksiyonu hesaplarken d adet bit'i 4er 4er ayırarak decimal
%karşılığını bulma işleminde lazım olacak dizi.
bit=[0,0,0,0;0,0,0,1;0,0,1,0;0,0,1,1;0,1,0,0;0,1,0,1;0,1,1,0;0,1,1,1;1,0,0,0;1,0,0,1;1,0,1,0;1,0,1,1;1,1,0,0;1,1,0,1;1,1,1,0;1,1,1,1];

%Başlangıçta sürüboy sayısınca random suruAAA için 3.5 ile 4 arasında, suruXXNN ve suruEsik
%için 0 ile 1 arasında değişecek değerler Suruboy uzunluğunda bir sütün
%vektörüne yazılır. Böylelikle suruAAA'nın, suruXXNN'ın ve suruEsik'in ilk
%konumları belirlenmiş olur.
suruAAA= unifrnd(3.5,4,[suruboy,1]);
suruXXNN= unifrnd(0,1,[suruboy,1]);
suruEsik=unifrnd(0,1,[suruboy,1]);

%sürülerin sonraki konumlarını belirlemek için her parçacığı sonraki
%konumuna ötelemek gerekiyor. Bunun için her parçacığın belirli bir hıza
%sahip olması gerekiyor ve bu hız konuma eklenerek yeni konum elde ediliyor.
%Başlangıç durumunda bu hızlar 0 olarak, konum sütün vektörleri(suruAAA,
%suruXXNN, suruEsik) ile aynı boyutta belirlenmektedir.
hizAAA = zeros(suruboy,1);
hizXXNN = zeros(suruboy,1);
hizEsik = zeros(suruboy,1);

%Sürü sütün vektörlerinin her bir satırı diğer sürünün ilgili satırı ile
%iterasyona girerek d adedince 0-1 sayısı yani bit üretecektir.
%Bu üretilen bitler sayılarak 0 ile 1 sayısının birbirine yakın olması ve
%bununla birlikte 4er bit seçilerek bu 4 bite karşılık gelen 0 ile 15
%arasındaki oluşacak sayıların adetlerinin birbirine yakın olması istenmektedir,
%bu bizim amaç fonksiyonumu oluşturur.
%amaç fonksiyonundan çıkacak her değer obj sütün vektörünün ilgili satırında tutulacaktır.
%bunun için hız ve konumda(suruXXNN ve diğ) olduğu gibi suruboy büyüklüğünde bir
%sütün vektör oluşturuyoruz..
obj=zeros(suruboy,1);


%%AMAÇ FONKSİYON%%

%d adet bit üretilecektir. d/4 0 ile 15 arasında gelecek olan sayıların adetidir.
%d/4/16 ise her bir sayıdan kaç adet gelmesi gerektiğini gösterir.
f=d/4/16;

%1. for suruboy kadar döner. Bu da sürülerin her bir satırına denk gelir.
for i=1:suruboy
    %xn1=a*xn*(1-xn) formülü xn{0 ile 1} arasında a{3.5 ile 4} arasında
    %değişmek şartıyla 0 ile 1 arasında sayı üretir.
    %bu formüle başlangıç değeri xn yukarıdaki sürüden gelir.
    xn=suruXXNN(i,1);
    
    %aynı şekilde a değeri de suruAAA da ilgili satırdan gelir.
    a=suruAAA(i,1);
    
    %eşik değeri suruEsik'in ilgili satırından gelir ve eşiğe göre üretilen
    %sayının 0 veya 1 olmasına karar verilir.
    e=suruEsik(i,1);
    
    %Oluşacak birleri 4er şekilde ayırmak için oluşturulan dizi
    bit4luk=zeros(1,4);
    
    %4bittin karşılığı decimal sayının kaç olduğunu saymak için oluşturuşan
    %dizi
    onbeslik=zeros(1,16);
    
    %oluşacak bitleri 4er şekilde ayırmaya yarayacak sayaç
    say=1;
    
    %d adet bit üretmek için gerekli for
    for j=1:d
        
        %sürülerin ilgili satırından aldığı değerler ile 0 ile bir arasında
        %sayı üreten formül
        xn1=a*xn*(1-xn);
        
        %bir sonraki üretilecek olan bitin xn değeri şimdiki üretilen bit.
        xn=xn1;
        
        %üretilen biti suruEsik sütün vek. ilgili değerine göre 0 mı bir 
        %olduğu belirlenir ve  bit4luk dizisine say sayacına göre atılır. 
        if(xn1<e)
            bit4luk(1,say) = 0;
        else
            bit4luk(1,say) = 1;
        end
        
        %say sayacı eğer 4 olmuşsa bit4luk dizisi dolmuş demektir ve
        %decimal karşılığına bakmak gerekir. bit4luk dizisinin decimal
        %karşılığı kaç ise onbeslik dizide ilgili alan bir arttırılır 
        %böylece kaç adet 0-15 arasında sayı olduğu ortaya çıkar.
        if(say==4)
            if(bit4luk(1,:)==bit(1,:))
                onbeslik(1,1)=onbeslik(1,1)+1;
                say=0;
            elseif(bit4luk==bit(2,:))
                onbeslik(1,2)=onbeslik(1,2)+1;
                say=0;
            elseif(bit4luk==bit(3,:))
                onbeslik(1,3)=onbeslik(1,3)+1;
                say=0;
            elseif(bit4luk==bit(4,:))
                onbeslik(1,4)=onbeslik(1,4)+1;
                say=0;
            elseif(bit4luk==bit(5,:))
                onbeslik(1,5)=onbeslik(1,5)+1;
                say=0;
            elseif(bit4luk==bit(6,:))
                onbeslik(1,6)=onbeslik(1,6)+1;
                say=0;
            elseif(bit4luk==bit(7,:))
                onbeslik(1,7)=onbeslik(1,7)+1;
                say=0;
            elseif(bit4luk==bit(8,:))
                onbeslik(1,8)=onbeslik(1,8)+1;
                say=0;
            elseif(bit4luk==bit(9,:))
                onbeslik(1,9)=onbeslik(1,9)+1;
                say=0;
            elseif(bit4luk==bit(10,:))
                onbeslik(1,10)=onbeslik(1,10)+1;
                say=0;
            elseif(bit4luk==bit(11,:))
                onbeslik(1,11)=onbeslik(1,11)+1;
                say=0;
            elseif(bit4luk==bit(12,:))
                onbeslik(1,12)=onbeslik(1,12)+1;
                say=0;
            elseif(bit4luk==bit(13,:))
                onbeslik(1,13)=onbeslik(1,13)+1;
                say=0;
            elseif(bit4luk==bit(14,:))
                onbeslik(1,14)=onbeslik(1,14)+1;
                say=0;
            elseif(bit4luk==bit(15,:))
                onbeslik(1,15)=onbeslik(1,15)+1;
                say=0;
            else
                onbeslik(1,16)=onbeslik(1,16)+1;
                say=0;
            end
        end
        say=say+1;
    end
    
    %iç for d adet bit üretildikten sonra üretilen 0-15 arası
    %sayılardan yukarıda belirlenen f değeri mutlak değer içerisinde
    %çıkartılır ve bulunan 16 değer toplanır obj() sütün vektörünün ilgili
    %satırına yazılır.
    fark=0;
    for s=1:16
        z=abs(onbeslik(:,s)-f);
        fark=fark+z;
    end
    obj(i,1)=fark;
end
                        %AMAÇ FONKSİYON SONU


%Sürülerin en iyi hallerini tutmamız gerekiyor. 
%ilk iterasyon olduğu için sürünün en iyi hali ilk sürüdür 
suruAAenIyi=suruAAA;
suruXNenIyi=suruXXNN;
suruEsikEnIyi=suruEsik;

%amaç fonksiyonun en iyi halini tutmamız gerekiyor. 
%ilk iterasyon olduğu için obj en iyi halidir.
objEnIyiler=obj;

%obj nin minumum geldiği satır en iyi satırdır bu satırın indexi bulunur.
objEnIyiDeg=min(obj);
indx=find(objEnIyiDeg==obj,1);

%bulunan indexin gösterdiği satır en iyi satırdır.
eniyiAAsatiri=suruAAA(indx,:);
eniyiXNsatiri=suruXXNN(indx,:);
eniyiESIKsatiri=suruEsik(indx,:);


iterasyon=0;

%objit dizisinde her iterasyonda gelen en iyi değerleri tutmak 
%iterasyon sayısına göre boyutu değişmektedir.
objit=objEnIyiDeg;

%iterasyonumuz hesaplanan fark dışarıdan girilecek hata'dan büyük olduğu sürece devam edecektir. 
while(fark>hata ||iterasyon < 500 )
    disp(iterasyon);
    
    %psa hız fonksiyonu her bir sürü için ayrı ayrı hesaplanır
    for i=1:suruboy
        hizAAA(i,:)=w*hizAAA(i,:)+c1*unifrnd(0,1)*(suruAAenIyi(i,:)-suruAAA(i,:))+c2*unifrnd(0,1)*(eniyiAAsatiri-suruAAA(i,:));
        hizXXNN(i,:)=w*hizXXNN(i,:)+c1*unifrnd(0,1)*(suruXNenIyi(i,:)-suruXXNN(i,:))+c2*unifrnd(0,1)*(eniyiXNsatiri-suruXXNN(i,:));
        hizEsik(i,:)=w*hizEsik(i,:)+c1*unifrnd(0,1)*(suruEsikEnIyi(i,:)-suruEsik(i,:))+c2*unifrnd(0,1)*(eniyiESIKsatiri-suruEsik(i,:));
    end
    
    %local optimuma takilmaması için hesaplanan hızlar eğer
    %maxhizsinirindan büyük veya küçük ise maxhizsinirına çekilir.
    maxhizsinirAA=(4-3.5)/2;
    maxHizXnVesik=(1)/2;
    for i=1:suruboy
        if(hizAAA(i,1)>maxhizsinirAA)
            hizAAA(i,1)=maxhizsinirAA;
        elseif(hizAAA(i,1)<-maxhizsinirAA)
            hizAAA(i,1)=-maxhizsinirAA;
        end
        
        if(hizXXNN(i,1)>maxHizXnVesik)
            hizXXNN(i,1)=maxHizXnVesik;
        elseif(hizXXNN(i,1)<-maxHizXnVesik)
            hizXXNN(i,1)=-maxHizXnVesik;
        end
        
        if(hizEsik(i,1)>maxHizXnVesik)
            hizEsik(i,1)=maxHizXnVesik;
        elseif(hizEsik(i,1)<-maxHizXnVesik)
            hizEsik(i,1)=-maxHizXnVesik;
        end
    end
    
    %elde edilen hızlar konumlara yani sürü sutun vek. eklenerek yeni
    %konumlar yeni sürü elde edilir.
    suruAAA=suruAAA+hizAAA;
    suruXXNN=suruXXNN+hizXXNN;
    suruEsik=suruEsik+hizEsik;
    
    %yeni sürüler eğer sınır değerlerini geçiyorsa sınır değerlerine
    %çekilir.
    for i=1:suruboy
        if(suruAAA(i,1)>4)
            suruAAA(i,1)=4;
        elseif(suruAAA(i,1)<3.5)
            suruAAA(i,1)=3.5;
        end
        
        if(suruXXNN(i,1)>1)
            suruXXNN(i,1)=1;
        elseif(suruXXNN(i,1)<0)
            suruXXNN(i,1)=0;
        end
        
        if(suruEsik(i,1)>1)
            suruEsik(i,1)=1;
        elseif(suruEsik(i,1)<0)
            suruEsik(i,1)=0;
        end
    end
    
    
    %bu durumda sürülere yeni hızları eklenmiş ve hızlarına göre yeni
    %konumları belirlenmiştir. böylece yeni konum ile amaç fonksiyon tekrar
    %hesaplanabilir 
    
    %AMAÇ FONKSİYON 1. iterasyondaki gibi
    f=d/4/16;
    for i=1:suruboy
        xn=suruXXNN(i,1);
        a=suruAAA(i,1);
        e=suruEsik(i,1);
        onbeslik=zeros(1,16);
        bit4luk=zeros(1,4);
        say=1;
        for j=1:d
            xn1=a*xn*(1-xn);
            xn=xn1;
            
            if(xn1<e)
                bit4luk(1,say) = 0;
            else
                bit4luk(1,say) = 1;
            end
            
            if(say==4)
                if(bit4luk(1,:)==bit(1,:))
                    onbeslik(1,1)=onbeslik(1,1)+1;
                    say=0;
                elseif(bit4luk==bit(2,:))
                    onbeslik(1,2)=onbeslik(1,2)+1;
                    say=0;
                elseif(bit4luk==bit(3,:))
                    onbeslik(1,3)=onbeslik(1,3)+1;
                    say=0;
                elseif(bit4luk==bit(4,:))
                    onbeslik(1,4)=onbeslik(1,4)+1;
                    say=0;
                elseif(bit4luk==bit(5,:))
                    onbeslik(1,5)=onbeslik(1,5)+1;
                    say=0;
                elseif(bit4luk==bit(6,:))
                    onbeslik(1,6)=onbeslik(1,6)+1;
                    say=0;
                elseif(bit4luk==bit(7,:))
                    onbeslik(1,7)=onbeslik(1,7)+1;
                    say=0;
                elseif(bit4luk==bit(8,:))
                    onbeslik(1,8)=onbeslik(1,8)+1;
                    say=0;
                elseif(bit4luk==bit(9,:))
                    onbeslik(1,9)=onbeslik(1,9)+1;
                    say=0;
                elseif(bit4luk==bit(10,:))
                    onbeslik(1,10)=onbeslik(1,10)+1;
                    say=0;
                elseif(bit4luk==bit(11,:))
                    onbeslik(1,11)=onbeslik(1,11)+1;
                    say=0;
                elseif(bit4luk==bit(12,:))
                    onbeslik(1,12)=onbeslik(1,12)+1;
                    say=0;
                elseif(bit4luk==bit(13,:))
                    onbeslik(1,13)=onbeslik(1,13)+1;
                    say=0;
                elseif(bit4luk==bit(14,:))
                    onbeslik(1,14)=onbeslik(1,14)+1;
                    say=0;
                elseif(bit4luk==bit(15,:))
                    onbeslik(1,15)=onbeslik(1,15)+1;
                    say=0;
                else
                    onbeslik(1,16)=onbeslik(1,16)+1;
                    say=0;
                end
            end
            say=say+1;
        end
        fark=0;
        for s=1:16
            z=abs(onbeslik(:,s)-f);
            fark=fark+z;
        end
        obj(i,1)=fark;
    end
                   %AMAÇ FONKSİYON SON
    
    
    %yeni bulunan obj değerlerine göre yeni konumdan daha iyi bir sonuç
    %elde edilmiş ise suruAAenIyi(ve diğerleri) en iyilerin tutulduğu 
    %sütün vektörüne yeni konumdaki değer yazılır 
    for i=1:suruboy
        if(obj(i)<objEnIyiler(i))
            objEnIyiler(i)=obj(i);
            
            suruAAenIyi(i)=suruAAA(i);
            suruXNenIyi(i)=suruXXNN(i);
            suruEsikEnIyi(i)=suruEsik(i);
        end
    end
    
    %Eğer yeni oluşan obj değerinde eskisinden daha min bir değer varsa
    %bu demek oluyor ki şimdiye kadarki en iyi değer bu tüm sürüler içinde
    %eniyisuru olarak yazılır hiz fonksiyonun son bölümünde parçacıklar buraya
    %yönelmek ister
    if(min(obj)<objEnIyiDeg)
        objEnIyiDeg=min(obj);
        indx=find(objEnIyiDeg==obj,1);
        
        eniyiAAsatiri=suruAAA(indx,:);
        eniyiXNsatiri=suruXXNN(indx,:);
        eniyiESIKsatiri=suruEsik(indx,:);
    end
    disp(objEnIyiDeg);
    disp(min(obj));
    disp('');
    
    iterasyon=iterasyon+1;
    
    objit(iterasyon)=objEnIyiDeg;
    
    if(objEnIyiDeg<hata)
        break
    end
    
end

%elde edilen a xn ve esik değerinin sağlamasını yapmak için yazılmış
%fonksiyon çağrılarak sonuç görülebilir.
test0_15( eniyiAAsatiri,eniyiXNsatiri,eniyiESIKsatiri,d,objit  )
end
