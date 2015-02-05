close all;
clear;
clc;
%%
load('../DATA/34DataA');
load('../DATA/11DataU');
PART = 2;
for i=1:length(dataSetA.name)
    for j=1:4
        [A(i).angA{j} A(i).axisA{j}]=quatfac(dataSetA.quat(i).limb{j});
    end    
end

for i=1:length(dataSetU.name)
    for j=1:4
        [U(i).angU{j} U(i).axisU{j}]=quatfac(dataSetU.quat(i).limb{j});
    end
end

figure;
for i=1:length(dataSetA.name)
    subplot(7,5,i)
    plot(A(i).axisA{PART});
    ylim([-1 1]);
end

figure;
for i=1:length(dataSetU.name)
    subplot(4,3,i)
    plot(U(i).axisU{PART});
    ylim([-1 1]);
end
% Name={'��','���','С��','��'}
% for i=1:4
%     figure('Name', Name{i});
%     text(0,0,Name(i));
%     subplot(2,2,1)
%     plot(scaleA{i});
%     title('������ת��');
%     subplot(2,2,3)
%     plot(scaleU{i});
%     title('������ת��');
%     subplot(2,2,2)
%     plot(axisA{i});
%     title('������ת��');
%     subplot(2,2,4)
%     plot(axisU{i});
%     title('������ת��');
%     
% end
