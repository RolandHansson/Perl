#! usr/bin/perl
use warnings; 
use strict; 

### Get filenames.

print "sorting file : ";
my $filename1 = shift @ARGV // <STDIN>;
$filename1 =~ s/^\s+|\s+$//g;
print "$filename1\n";

print "outputting to file : ";
my $outfile = shift @ARGV // <STDIN>;
$outfile =~ s/^\s+|\s+$//g;
print "$outfile\n";


### Open file and search through it.

open IN, '<', $filename1 or die ("Couldn't open file: '$filename1'!");
open OUT, '>', $outfile or die ("Couldn't open file: '$outfile'!");

my $high_score=0;
my $current_name="";
while(1)
{
	while(1)
	{
		my $title = <IN> // last;
		$title =~ s/^\s+|\s+$//g;
		my $sequence = <IN> // last;
		my $masked = ($sequence =~ tr/N//g);
		my $score = length($sequence) - $masked;
		print OUT "$title [$score]";
		print OUT $sequence;
	}	

