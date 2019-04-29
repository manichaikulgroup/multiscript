#!/usr/bin/perl
######################################################################
# create_multiscript.pl
#
# the aim is to create a set of script input files 
# for running a set of bsh files on the cluster
#
# Create a single bsh file containing the string SUB whereever you
# want to substitute a number.
#
# Go to the directory you want to run your bsh jobs, and type 
#     create_multiscript.pl input.bsh 0 25
# replacing input.bsh with your bsh input file, and 0 and 25 with the
# lower and upper numbers for your runs.
#
# This perl script will create a set of  input files, named similar to your input text in??.suffix,
######################################################################

use Cwd;

#(@AEGV > 2) or die("Give bsh input template and beginning and ending numbers\n");
$ifile = $ARGV[0];
$istart = substr($ifile, 0, index($ifile, '.'));
$iend = substr($ifile, index($ifile, '.'));
$first = $ARGV[1];
$last = $ARGV[2];

open(IN, $ifile) or die("Cannot read from $ifile");
while($line = <IN>) {
    chomp($line);
    push(@lines, $line);
}
close(IN);

$cwd = getcwd();

foreach $i ($first..$last) {
    $j = $i; #if($j < 10) { $j = "0$i"; }

    $ofile = $istart . $j . $iend;
    open(OUT, ">$ofile") or die("Cannot write to $ofile");
    @temp = @lines;
    foreach $line (@temp) {
	$line =~ s/SUB/$j/g;
	print OUT ("$line\n");
    }
    close(IN);

    $mydir = $cwd;
    $mydir =~s/h1\/a\/am/home/;
    close(OUT);
}

system("chmod u+x *$iend")
