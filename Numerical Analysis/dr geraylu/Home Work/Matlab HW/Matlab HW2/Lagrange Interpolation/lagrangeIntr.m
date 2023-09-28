function y = lagrangeIntr(x, xPoint, yPoint)
n = size(xPoint, 2);
L = ones(n, size(x, 2));
if (size(xPoint, 2) ~= size(yPoint, 2))
   fprintf(1, '\nERROR!\nXpoint and yPoint must have the same number of elements\n');
   y = NaN;
else
   for i=1:n
      for j=1:n
         if (i~=j)
            L(i,:) = L(i,:).*(x-xPoint(j))/(xPoint(i)-xPoint(j));
         end
      end
   end
   y = 0;
   for i=1:n
      y = y+yPoint(i)*L(i,:);
   end
end