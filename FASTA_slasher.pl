#!/usr/bin/perl
use warnings; 
use strict; 

### This script excludes useless sequences (no hits) from a FASTA files

print "reading FASTA file: ";
my $in_main = shift @ARGV // <STDIN>;
$in_main =~ s/^\s+|\s+$//g;
print "$in_main\n";

print "Comparing to list of hits: ";
my $in_reference = shift @ARGV // <STDIN>;
$in_reference =~ s/^\s+|\s+$//g;
print "$in_reference\n";

print "Outputting into file: ";
my $outfile = shift @ARGV // <STDIN>;
$outfile =~ s/^\s+|\s+$//g;
print "$outfile\n";

############################

open IN1, '<', $in_main or die ("Couldn't open file: '$in_main'!");
open IN2, '<', $in_reference or die ("Couldn't open file: '$in_reference'!");
open OUT, '>', $outfile or die ("Couldn't open file: '$out_reference'\!");

my %species;
my $cutoff=1;
while (<IN2>)
{
  next unless m/^>.*\(([^_ ]+[_ ][^_ ])/;	
  $species{$1}++  // $species{$1}=1;
}

while(<IN2>)
{
  print OUT $_ unless m/^>([^_ ]+[_ ][^_ ])/;
  until(<IN2> =~ m/^>([^_ ]+[_ ][^_ ]) and $species{$1}>$cutoff){last if eof IN2};
  print OUT $_;
}
