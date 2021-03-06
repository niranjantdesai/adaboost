function [i_opt,p_opt,theta_opt,error_min,h_opt ] = choose_learner( X,y,w )
%choose_learner Picks the best classifier from the following family of weak
%classifiers: h(x;i,p,theta) = sign(p(x_i-theta))
%   p -> -1/+1
%   theta -> real-valued threshold parameter
%   x_i -> ith element of d-dimensional input vector x
%   X -> dataset
%   y -> training labels
%   w -> column vector containing the weights of all points


% getting the range for theta
minVal = min(min(X));
maxVal = max(max(X));
theta = linspace(minVal,maxVal,100);   % search range for theta
p = [-1;1];     % search range for p
error_min = 1.1;

h_opt = -1*ones(size(X,1),1);   % vector of labels assigned by the best classifier

for i=1:size(X,2)
   for j=1:size(theta,2)
      for k=1:size(p) 
          % vector of labels assigned by the weak classifier
          h = -1*ones(size(X,1),1);
          h(p(k)*(X(:,i)-theta(j))>0) = 1;
          
          
          idx = y~=h;
          idx = +idx;
          
          error_curr = sum(w.*idx);
          
          if error_curr<error_min
             error_min = error_curr;
             i_opt = i;
             p_opt = p(k);
             theta_opt = theta(j);
             h_opt = h;
          end
      end
   end
end


end

