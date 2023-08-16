#make A site bed file from ribosome footprint mapped file
#if the read length was short than 27 nt or longer than 32 nt, those reads will be discardd.
##reference
#High-Resolution Ribosome Profiling Defines Discrete Ribosome Elongation States and Translational Regulation during Cellular Stress

#######This is for yeast use only.


use warnings;
use strict;

my %hash = ();
$hash{'27'} = '16';
$hash{'28'} = '16';
$hash{'29'} = '17';
$hash{'30'} = '17';
$hash{'31'} = '17';
$hash{'32'} = '17';

#input of bed file
foreach(<STDIN>){
    chomp;
    my @l = split(/\t/,);
    my $length = $l[2] - $l[1];
    if($length < 27 or $length > 32){
	next;
    }

    my $e;
    my $s;

    if ($l[5] eq "+"){
	$e = $l[1] + $hash{$length};
	$s = $e - 1;
    }else{
	$s = $l[2] - $hash{$length};
	$e = $s + 1;
    }

    print "$l[0]\t$s\t$e\t$l[3]\t$l[4]\t$l[5]\n";
}

exit;


    
