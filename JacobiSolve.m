function [solutionVector, errorsVector, iterationVector] = JacobiSolve(A, b, tolerance)
%check whether the matrix is square, vector is of proper dimension and
%matrix is diagonally dominant

%creating temporary variables to store inputs size to check them
size1 = size(A);
size2 = size(b);

%checking if the matrix is square
if(size1(1) ~= size1(2))
    error("Given matrix is not square one.")
end

%checking if the vector has proper dimension
if (size2(2) ~= 1) 
    error("Given vector has wrong dimensions.")
end

%checking if the matrix is diagonally dominant
for i = 1 : size1(1)
    analyzedRow = abs(A(i,:));
    %summing up the values except diagonal
    d = sum(analyzedRow) - analyzedRow(i);
    if analyzedRow(i) < d
       error("Given matrix is not diagonally dominant."); 
    end
end

%-----------------------------------------
%input is correct, proceed to function
%-----------------------------------------

%create initial estimate (guess) solution vector
x = zeros(size1(1), 1);

%calculate diagonal matrix D from A
D = diag(diag(A));

%error initially set to infinity
err = inf;

iteration = 1;

%loop of iterations for solving
while err > tolerance
    %update initial guess vector x
    dx = D\(b - A*x);
    x = x + dx;
    
    %compute solution error
    err = norm(A * x-b);
    
    %update outputs
    errorsVector(iteration) = err;
    iterationVector(iteration) = iteration;
    
    iteration = iteration + 1;
end

%update solutions output
solutionVector = x;

end

