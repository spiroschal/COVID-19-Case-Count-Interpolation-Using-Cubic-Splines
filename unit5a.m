pkg load io

function unit5a = unit5a(f)

%1.
printf('EXERSICE_1\n');

F = [f];
[m,n] = size(F);

ai = [];
bi = [];
ci = [];
di = [];
All = [];

for i=1:m-1
  h(i) = 1; %simfona me tin bonus_askisi_5 kai tin ipodi3i_1
end

C = [];
q = [];

counter = 1;


%ipologizoume ta ai
for i=1:m-1,
  ai(i) = F(i);
end


%ipologizoume ta ci
%ipologizoume ton pinaka C
for j=1:m,
  for i=1:m,
    if (j==1) %proti grammi
      if (i==1)
        C(j,i) = 1;
      else
        C(j,i) = 0;
      end
    
    elseif (j==m) %teleytea grammi
      if (i==m)
        C(j,i) = 1;
      else
        C(j,i) = 0;
      end
    
    else
      if (counter==1)
        C(j,i) = h(j-1);
        counter++;
      elseif (counter==2)
        C(j,i) = 2*(h(j-1)+h(j));
        counter++;
      elseif (counter==3)
        C(j,i) = h(j);
        counter=-m+3;
      else
        C(j,i) = 0;
        counter++;
      end
    end
  end
end

%ipologizoume to dianisma q
for j=1:m,
  for i=1:1,
    if (j==1 || j==m) %o protos kai o teleytaios ari8mos toy dianismatos q
      q(j,i)=0;
    else
      q(j,i)=((3/h(j))*(F(j+1)-F(j)))-((3/h(j-1))*(F(j)-F(j-1)));
    end
  end
end

%to pro4 ligo diaforopoihmeno
A = [C q];  % augmented system matrix
[l,o]=size(A);

% ELIMINATION PHASE 
for i=1:l-1,
  % Partial Pivoting
  [val,pos] = max(abs(A(i:end,i)));  % maximum absolute pivot
  npos = i-1+pos;
  if (npos != i)
    z = A(i,:);
    A(i,:) = A(i-1+pos,:);  % exchange lines
    A(i-1+pos,:) = z;
  end
  % Eliminate variables
  for j=i+1:l,
    a = -A(j,i)/A(i,i);
    for k=i:o,
      A(j,k) = A(j,k) + a*A(i,k);
    end
  end
end

% BACK-SUBSTITUTION PHASE
for i=l:-1:1,
  sum = 0;
  for j=i+1:o-1,
    sum = sum + A(i,j)*ci(j);
  end
  ci(i) = (A(i,o) - sum)/A(i,i);
end
%telos tou prog4


%ipologizoume ta bi
for i=1:m-1,
  bi(i)=((1/h(i))*(f(i+1)-f(i)))-((h(i)/3)*(2*ci(i)+ci(i+1)));
end


%ipologizoume ta di
for i=1:m-1,
  di(i)=(1/(3*h(i)))*(ci(i+1)-ci(i));
end


%ftiaxnei enan pinaka me tis plirofories pou exoume ftia3i parapano, diladi ta ai, ta bi, ta ci kai ta di
for j=1:4,
  for i=1:m,
    if (j==1)
      if (i!=m)
        All(j,i)=ai(i);
      else
        All(j,i)=0;%kanonika den iparxei to ai(m), alla gia na ftia3oume ton pinaka bazoume 0
      end
    elseif (j==2)
      if (i!=m)
        All(j,i)=bi(i);
      else
        All(j,i)=0;%kanonika den iparxei to bi(m), alla gia na ftia3oume ton pinaka bazoume 0
      end
    elseif (j==3)
      All(j,i)=ci(i);
    else
      if (i!=m)
        All(j,i)=di(i);
      else
        All(j,i)=0;%kanonika den iparxei to di(m), alla gia na ftia3oume ton pinaka bazoume 0
      end
    end
  end
end

%tiponei ton pinaka pou exei oles tis plirofories pou 8eloume gia tin askisi 1
printf('\t');
for i=1:m,
  printf('S%d\t              ',i-1);
end
printf('\n');
for j=1:4,
  for i=1:m,
    if (i==1 && j==1)
      printf('ai\t');
    elseif (i==1 && j==2)
      printf('bi\t');
    elseif (i==1 && j==3)
      printf('ci\t');
    elseif (i==1 && j==4)
      printf('di\t');
    end
    printf('%d\t              ',All(j,i));
  end
  printf('\n');
end



printf('\n');
%2.
printf('EXERSICE_2\n');

Si = [];
xi = [];
x = 0;
c = 0;

%ftiaxnei enan pinaka toy typou [0,1,2,...,m]
for i=1:m,
  xi(i)=i-1;
end

%pernoume tin stili me tis hmerominies apo to arxeio excel
no=[];
days=[];
[no,days]=xlsread ('covid-data.xlsx','Sheet1','A2:A58');

%pernoume tin stili me ta sinolika krousmata apo to arxeio excel
f2=xlsread ('covid-data.xlsx','Sheet1','B2:B58');

for i=1:57,
  if (mod(i,7)==1)
    if (c!=8)
      c++;
    else
      c=c;
    end
    Si(i)=round(ai(c)+((bi(c))*(x-xi(c)))+((ci(c))*(x-xi(c))^2)+((di(c))*(x-xi(c))^3));
  else
    Si(i)=round(ai(c)+((bi(c))*(x-xi(c)))+((ci(c))*(x-xi(c))^2)+((di(c))*(x-xi(c))^3));
  end
  x=x+(1/7);
  if (i==1)
    printf('    глеяа  \t   сумокийа йяоуслата\n');
  end
  printf(days{i});
  printf('  \t%d\n',Si(i));
end



%3.
%o a3onas x'x. Einai metrimenos se meres, diladi (1[proti mera]  2[dyterh mera]  ...  56  57)
t=[];
for i=1:57,
  t(i)=i;
end

plot(t,Si,'*-',t,f2,'o-');
