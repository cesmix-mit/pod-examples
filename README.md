### POD examples

These examples are meant to used with the `ML-POD` package from the following Git repo

      https://github.com/cesmix-mit/lammps/tree/fastpod

Please download the above source code and install LAMMPS by using the commandlines
 
    mkdir build
    cd build
    cmake -C ../cmake/presets/basic.cmake -D BUILD_SHARED_LIBS=on -D LAMMPS_EXCEPTIONS=on -D PKG_PYTHON=on -D PKG_ML-POD=on ../cmake
    cmake --build .

Alternatively, you can  copy the ML_POD source in the directory
https://github.com/cesmix-mit/lammps/tree/fastpod/src/ML-POD 
to your existing LAMMPS source code and compile your LAMMPS source code.

TrainingData contains training datasets for many different materials

TestData contains test datasets for some materials

FastPOD include many examples on fitting and running MD with ML-POD in LAMMPS. 

To fit FPOD potential, please go to a subfolder in FastPOD and do

    lmp -in fit.pod

To run a MD simulation with the trained FPOD potential, please do

    lmp -in mdrun.pod


