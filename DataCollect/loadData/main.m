% read data
clear all
close all
clc
oriPath='G:\SNARC\数据\患者组';
nameList = dir(fullfile(oriPath));
for n = 1:length(nameList)-2
    DataA(n).name=nameList(n+2).name;
    sideList=dir(fullfile(oriPath,nameList(n+2).name));
    for i=1:length(sideList)-2
        if ~(isempty(findstr(sideList(i+2).name,'偏')) && isempty(findstr(sideList(i+2).name,'瘫')))
            DataA(n).affSide=sideList(i+2).name(1);
        end
        if strcmp(sideList(i+2).name(1),'左')==1
            side='L';
        elseif strcmp(sideList(i+2).name(1),'右')==1
            side='R';
        end
        typeList=dir(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name));
        for j=1:length(typeList)-2
            if strcmp(typeList(j+2).name,'运动')==1
                collTime=dir(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name));
                for k=1:length(collTime)-2
                    pathNameR=fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name,collTime(k+2).name,'Result.txt');
                    pathNameQ=fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name,collTime(k+2).name,'\');
                    [index,motion] = readRes(pathNameR);
                    if ~isempty(index)
                        if ((side=='L')&&(motion=='1')) 
                           DataA(n).L.flx.kin= loadQuat(pathNameQ,index);
                        elseif ((side=='L')&&(motion=='3')) 
                           DataA(n).L.abd.kin= loadQuat(pathNameQ,index);
                        elseif ((side=='R')&&(motion=='1')) 
                           DataA(n).R.flx.kin= loadQuat(pathNameQ,index);
                        elseif ((side=='R')&&(motion=='3')) 
                           DataA(n).R.abd.kin= loadQuat(pathNameQ,index);
                            
                        end 
                    end
                end
            end
            
            if strcmp(typeList(j+2).name,'肌电')==1
                t=zeros(1,8)+1;
                fileList=dir(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name));
                for l=1:length(fileList)-2
                    pathE=fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name,fileList(l+2).name);
                   
                    if ~isempty(strfind(fileList(l+2).name,'motionL1')) 
                           DataA(n).L.flx.sEMG{t(2)}= loadEmg(pathE);
                           t(2)=t(2)+1;
                        elseif ~isempty(strfind(fileList(l+2).name,'motionL2'))   
                           DataA(n).L.abd.sEMG{t(3)}= loadEmg(pathE);
                            t(3)=t(3)+1;
                        elseif ~isempty(strfind(fileList(l+2).name,'motionR1')) 
                           DataA(n).R.flx.sEMG{t(4)}= loadEmg(pathE);
                            t(4)=t(4)+1;
                        elseif ~isempty(strfind(fileList(l+2).name,'motionR2')) 
                           %DataA(n).R.abd.sEMG{t(5)}= loadEmg(pathE);
                            t(5)=t(5)+1;
                        elseif ~isempty(strfind(fileList(l+2).name,'mvcR1'))
                           DataA(n).R.flx.mvc{t(6)}= loadEmg(pathE);
                            t(6)=t(6)+1;
                        elseif ~isempty(strfind(fileList(l+2).name,'mvcR2'))
                           DataA(n).R.abd.mvc{t(7)}= loadEmg(pathE);
                            t(7)=t(7)+1;
                        elseif (strfind(fileList(l+2).name,'mvcL1'))
                           DataA(n).L.flx.mvc{t(8)}= loadEmg(pathE);
                            t(8)=t(8)+1;
                        elseif (strfind(fileList(l+2).name,'mvcL2'))
                           DataA(n).L.abd.mvc{t(1)}= loadEmg(pathE);
                            t(1)=t(1)+1;
                    end 
                end
            end
                
        end 
    end
end
