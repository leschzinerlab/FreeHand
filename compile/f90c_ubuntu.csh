#!/bin/tcsh -x
###################################################################
# JLR
# compile fortran program as xxx.f90 into xxx.exe using image libraries
# link to fftw
# Based on a script for f77 from the LMB (from RH?)
#
###################################################################
#echo " starting compile procedure"

set prog=$1
set oput=$2
if ($prog == "" ) then
   echo " No input file given"
   echo " Must use : compile input_file"
   goto exit
endif
#
# if the input file (or with default extention .for)  exists?
#
set n=`find . -name "$prog" -print`
if ($#n == "0") then
   set prog1=$prog:t
   set prog2=$prog1:r
   set prog3=$prog2.f90
   set m=`find . -name "$prog3" -print`
   if ($#m == "0") then
      echo " xp: '$prog3' does not exsit"
      goto exit
   else
      set prog=$prog3
   endif
endif
#
# usage 2: naming output file with extention .exe
#
if ($oput == "") then
   set prog1=$prog:t
   set prog2=$prog1:r
   set oput=$prog2.exe
else
   set oput1=$oput:t
   set oput2=$oput1:r
   set oput=$oput2.com
endif

# execute named procedure in background

(time gfortran -O -w -o $oput $prog \
   /programs/x/mrc/05.05.2011/lib/imlib2010.a   \
   /programs/x/mrc/05.05.2011/lib/genlib.a    \
    -lfftw3 -lm)
#
# previously linked to
# /home/jlr/image2010/lib/ifftlib.a 
# /home/jlr/image2010/lib/plot2klib.a
# /home/jlr/image2010/lib/misclib.a 
#
#
#
exit:

