
%  3.Create two matrices by taking user input and perform add, sub, multiplication,division operations.


disp('Enter Matrix of A:');
row_a=input('enter row:');
col_a=input('enter column :');
A=zeros(row_a,col_a);
for i=1:row_a
    for j=1:col_a
        A(i,j)=input(sprintf('A(%d,%d)=',i,j));
    end
end


disp('Enter Matrix of B:');
row_b=input('enter row:');
col_b=input('enter column :');
B=zeros(row_b,col_b);
for i=1:row_b
    for j=1:col_b
        B(i,j)=input(sprintf('B(%d,%d)=',i,j));
    end
end

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



addittion=zeros(row_a,col_a);
subtraction=zeros(row_a,col_a);
multiplication=zeros(row_a,col_a);
division=zeros(row_a,col_a);

for i = 1:row_a
    for j = 1:col_a
        addittion(i,j) = A(i,j)+B(i,j);
        subtraction(i,j) = A(i,j)-B(i,j);
        division(i,j) = A(i,j)/B(i,j);

    end
end


for i = 1:row_a%row of A
    for j = 1:col_b %col of B
        sum_val = 0;
        for k = 1:col_a %col of A
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




