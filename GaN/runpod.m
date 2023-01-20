
c = [0 1 2 3 4];
f = [0.01 0.05 0.25 0.5 0.75 1];
N = length(c); 
M = length(f);
etest = zeros(4,10,M,N);
etrain = zeros(4,10,M,N);

for n = 1:N
  fitpod = "fitpod pod1" + num2str(c(n)) + ".txt data.pod";
  fid = fopen('fit.pod','wt');
  fprintf(fid, fitpod);
  fclose(fid); 
  for m = 1:M 
    text = fileread("data.txt");    
    text = strrep(text,"fraction_training_data_set 0.01", "fraction_training_data_set " + num2str(f(m)));
    text = strrep(text,"fraction_test_data_set 0.99", "fraction_test_data_set " + num2str(1-f(m)));
    fid = fopen('data.pod','wt');
    fprintf(fid, text);
    fclose(fid); 

    for i = 1:10        
      %!mpirun -n 4 /Users/ngoccuongnguyen/lammps/build/lmp -in fit.pod
      !/Users/ngoccuongnguyen/lammps/build/lmp -in fit.pod
       etest(:,i,m,n) = readtxt("pod_test_errors.pod");
       etrain(:,i,m,n) = readtxt("pod_training_errors.pod");
    end
  end
end

