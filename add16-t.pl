#!/usr/bin/perl
#

require './gates.pl';
require './multi-way.pl';

open (FH, "<", "Add16.cmp") || die "Could not open .cmp file\n";

@TEST_LINES = <FH>;

for $test_line (@TEST_LINES) {

	next if $test_line =~/out/;

	$_      = $test_line; # we dont need the first line 
	s/ //g;

	@testbits = split(/\|/, $_);

	@a_test   = split(//, $testbits[1]);
	@b_test   = split(//, $testbits[2]);
	@out_test = split(//, $testbits[3]);

	print "Running test for _add16 ... \n";
	print "a: @a_test\n";
	print "b: @b_test\n";
	print "out: Should be @out_test ... ";

	@add16_out = _add16(\@a_test, \@b_test);
	if (@add16_out ~~ @out_test) {print " passed! \n";}
	else {print " failed, got @add16_out instead.\n";}
}
