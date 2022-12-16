function errs = readtxt(fileName)

FID = fopen(fileName);
data = textscan(FID,'%s');
fclose(FID);
data = string(data{:});

for i = 1:length(data)
    if data(i) == "files"
        break;
    end
end
errs = zeros(1,4);
for j = 3:6
    errs(j-2) = str2double(data(i+j));
end




