clc;
clear all; 
close all;

Design = [20e3, 10e3, 100e3, 200e3];
IC = [10, 30, 2, 1];
Assembly = [10, 10, 2, 1];
x = 1:1:100000;

figure(1);
hold on;
for i=1:1:4
  Total(i,:) = Design(i) .+ (IC(i).+Assembly(i)).*x;
  plot(x,Total(i,:),"linewidth",1);
endfor
hold off;

xlim([1,55000]);
ylim([1,2000000]);

grid on;

saveas(1,"ex4total.png");

figure(2);
hold on;
for i=1:1:4
  PerUnit(i,:) = Design(i)./x .+ (IC(i).+Assembly(i));
  plot(x,PerUnit(i,:),"linewidth",2); 
endfor
hold off;

grid on;
ylim([0,1000]);

saveas(1,"ex4perunit.png");
