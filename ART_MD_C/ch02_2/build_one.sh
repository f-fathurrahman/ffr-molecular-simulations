BASNAM=`basename $1 .c`
echo $BASNAM
rm -v $BASNAM.x
gcc -Wall -O3 -funroll-all-loops $1 -o $BASNAM.x -lm
