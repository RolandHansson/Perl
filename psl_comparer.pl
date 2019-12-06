#!/usr/bin/perl
use warnings; 
use strict; 

### Get filenames.

print "Comparing file : ";
my $filename1 = $ARGV[0] // <STDIN>;
$filename1 =~ s/^\s+|\s+$//g;
print "$filename1\n";

print "to file : ";
my $filename2 = $ARGV[0] // <STDIN>;
$filename2 =~ s/^\s+|\s+$//g;
print "$filename2\n";

print "outputting to file : ";
my $outfile = $ARGV[0] // <STDIN>;
$outfile =~ s/^\s+|\s+$//g;
print "$outfile\n";


### Open file and search through it.

open IN1, '<', $filename1 or die ("Couldn't open file: '$filename1'!");
open IN2, '<', $filename2 or die ("Couldn't open file: '$filename2'!");
open OUT, '>', $outfile or die ("Couldn't open file: '$outfile'!");

my $high_score=0;
my $current_name="";
while(1)
{
	while(<IN1>)
	{
		($name, $score) = m/()()/;
		$high_score = $score if $score>$high_score;
		last unless $name eq current_name; 
	}	

}

