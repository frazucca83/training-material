#!/bin/bash -l

module purge
source switch_to_2015a
module load intel/2015a
module load HDF5/1.8.14-intel-2015a-serial

FFLAGS="-O2 -g -openmp -I${MKLROOT}/include"
MATH_LIBS=" -L${MKLROOT}/lib/intel64 -lmkl_intel_ilp64 -lmkl_core -lmkl_sequential -lpthread -lm"

DISTR_MATH_LIBS=" -L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_core -lmkl_sequential -lmkl_blacs_intelmpi_lp64 -lpthread -lm"

HYBRID_MATH_LIBS="  -L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_core -lmkl_intel_thread -lmkl_blacs_intelmpi_lp64 -lpthread -lm"
make F90=ifort MPIF90=mpiifort FFLAGS="${FFLAGS}" HDF5_DIR="${EBROOTHDF5}" \
     MATH_LIBS="${MATH_LIBS}" DISTR_MATH_LIBS="${DISTR_MATH_LIBS}" \
     HYBRID_MATH_LIBS="${HYBRID_MATH_LIBS}" all
