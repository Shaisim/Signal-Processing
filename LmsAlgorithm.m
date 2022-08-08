 %We made a functoion that based on LMS algorithem.
 %The function get the "dirty" signal and the desired signal as a input and
 %return the filter coefficient-(h),error-(e) and the clean output
 %signal-(y).

function [y,e,h]=LmsAlgorithm(x,d)%The name of the function
N=250;%Filter order
h=zeros(1,N);%Initial zeros vector for filter coefficients
mu=0.0117;
for k=1:length(d)
   y(k)=h(k)'.*x(k);
   e(k) = d(k)-y(k);%חישוב השגיאה
   h(k+1)= h(k)+ mu*(e(k).*x(k));%עידכון מקדמי המסנן
end

return




