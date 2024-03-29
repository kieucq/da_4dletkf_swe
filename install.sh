#!/bin/sh
#module load pgi
#module load openmpi/pgi/4.0.4
MAIN_DIR=/N/u/ckieu/Karst/model/da_4dletkf_swe
FC="pgf90"
MFC="mpif90"
FCFLAG="-traceback"
INC="$MAIN_DIR/registry"
#
# compiling diagnostic directory
#
echo "Compiling in dir: dig"
cd $MAIN_DIR/dig
rm -rf *.exe *.o *.mod
$FC $FCFLAG -o ./ana.exe ./ana.f90
#
# compiling letkf directory
#
echo "Compiling in dir: letkf"
cd $MAIN_DIR/letkf
rm -rf *.exe *.o *.mod
$FC $FCFLAG -c mt19937ar.f90
$FC $FCFLAG -c common.f90
$FC $FCFLAG -c netlib.f
$FC $FCFLAG -c matrix_inv.f90 
$FC $FCFLAG -c common_mtx.f90
$MFC $FCFLAG -c common_mpi.f90
$MFC $FCFLAG -c module_interface.f90
$MFC $FCFLAG -c module_4dletkf.f90
$MFC $FCFLAG -c module_utils.f90
$MFC $FCFLAG -o 4dletkf_mpi.exe 4dletkf.f90 common_mtx.f90 common.f90 mt19937ar.f90 netlib.f matrix_inv.f90 common_mpi.f90 module_interface.f90 module_4dletkf.f90 module_utils.f90
#
# compiling ctl directory
#
echo "Compiling in dir: ctl"
cd $MAIN_DIR/ctl
$FC $FCFLAG -o ctl.exe swe.f
#
# compiling obs directory
#
echo "Compiling in dir: obs"
cd $MAIN_DIR/obs
rm -rf *.exe *.o *.mod
$FC $FCFLAG -c mt19937ar.f90
$FC $FCFLAG -o obs.exe obs.f90 mt19937ar.f90
#
# compiling truth directory
#
echo "Compiling in dir: truth"
cd $MAIN_DIR/truth
rm -rf *.exe *.o *.mod
$FC $FCFLAG -o truth.exe swe.f 
$FC $FCFLAG -o bvortex.exe bvortex.f90
#
# compiling model directory
#
echo "Compiling in dir: model"
cd $MAIN_DIR/model
rm -rf *.exe *.o *.mod
$FC $FCFLAG -o swe.exe swe.f
#
# compiling ultility directory
#
echo "Compiling in dir: utils"
cd $MAIN_DIR/utils
rm -rf *.exe *.o *.mod
$FC $FCFLAG -o  mean.exe mean.f90
#
# compiling ini directory
#
echo "Compiling in dir: ini"
cd $MAIN_DIR/ini
rm -rf *.exe *.o *.mod
$FC $FCFLAG -c mt19937ar.f90
$FC $FCFLAG -o ini.exe ini.f90 mt19937ar.f90
$FC $FCFLAG -o bgd.exe bgd.f
cd ../
ls -la */*.exe
echo "DONE INSTALLING"
