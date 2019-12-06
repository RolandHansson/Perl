#!/usr/bin/perl
use strict;
use warnings;
use File::Find;

### This script searches for given strings in first line of FASTAS in folder & subfolders.

print "reading FASTA files in current folder, \n";
print "Comparing to list of names: ";
my $in_reference = shift @ARGV // <STDIN>;
$in_reference =~ s/^\s+|\s+$//g;
print "$in_reference\n";

print "Outputting into file: ";
my $outfile = shift @ARGV // <STDIN>;
$outfile =~ s/^\s+|\s+$//g;
print "$outfile\n";

############################

open IN, '<', $in_reference or die ("Couldn't open file: '$in_reference'!");
open OUT, '>', $outfile or die ("Couldn't open file: '$outfile'\!");

my %species;
while (<IN>)
{
  next unless m/^>?([^>_ \(]+[_ ][^_ \)]+)/;
  my $entry = $1; 
  $entry =~ s/ /_/;
  if (defined($species{$entry}))
  {
      $species{$entry}++;
      next;
  }
  $species{$entry}=1;
  print("Added '$entry'\n");
}
close IN;

############################

my $query='<a class="prev"';
my $directory = '.';
our $iterate = 0;
find(\&find_file, ".");
close OUT;

sub find_file{
	return if -d;
	return unless m/(.*)\.(fa|fasta)/;	
	my $name = $_;
	open (my $file , '<', $name) or die("could not open '$name'");
	print('.') if ($iterate++ % 10) == 0;
	print("\n") if ($iterate % 100) == 0;
	#print("opened '$name'!\n");
	my $line = <$file>;
	$line =~ s/ /_/;
	$line =~ m/>([^_ ]+[_ ][^_ ]+)/;
	unless ( ($species{$1} // 0) > 0)
	{
	close($file);
	return;
	} 
	print OUT $line;
	while(<$file>){print OUT "$_";}
	print "\n$name - $line [$1]\n";		
	close($file);	
}