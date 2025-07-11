%  2. Create two matrices manually and perform operations: add, sub, multiplication, division.
A = [1,2;    3,4];

B = [5,6;    7,8];

row=2;
col=2;

%Find row and column .
%{
row=0;col=0;
for i=1:10000
    if row == 0
        try
            dummy = A(i, 1); % check value present or not
            %row = i;
        catch
            row=i-1; %previous row
        end
    end

    if col == 0
        try
            dummy = B(1, i);
            %col = i;
        catch
            col=i-1; %previous column
        end
    end
     if row > 0 && col > 0
        break;
    end
end
%}

% create zero matrix matrix 
%{
for i = 1:row
    for j = 1:col
        add(i,j)=0;
        multi(i,j) = 0;
        sub(i,j)=0;
        div(i,j) = 0;
    end
end
%}



addittion=zeros(row,col);
subtraction=zeros(row,col);
multiplication=zeros(row,col);
division=zeros(row,col);

for i = 1:row
    for j = 1:col
        addittion(i,j) = A(i,j)+B(i,j);
        subtraction(i,j) = A(i,j)+B(i,j);
        division(i,j) = A(i,j)+B(i,j);

    end
end


c=zeros(row,col);
for i = 1:row %row of A
    for j = 1:col %col of B
        sum_val = 0;
        for k = 1:col %col of A
            sum_val = sum_val + A(i, k) * B(k, j);
        end
        multiplication(i, j) = sum_val;
    end
end



disp('Addition :');
disp(addittion);

disp('Subtraction :');
disp(subtraction);

disp('Multiplication :');
disp(multiplication);

disp('Division :')
disp(division);




