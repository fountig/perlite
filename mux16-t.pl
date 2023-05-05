#!/usr/bin/perl
#

require './gates.pl';
require './multi-way.pl';

open (FH, "<", "Mux16.cmp") || die "Could not open .cmp file\n";

@TEST_LINES = <FH>;

for $test_line (@TEST_LINES) {

	next if $test_line =~/out/;

	$_      = $test_line; # we dont need the first line 
	s/ //g;

	@testbits = split(/\|/, $_);

	@a_test   = split(//, $testbits[1]);
	@b_test   = split(//, $testbits[2]);
	@sel_test = split(//, $testbits[3]);
	@out_test = split(//, $testbits[4]);


	print "Running test for _mux16 ... \n";
	print "a: @a_test\n";
	print "b: @b_test\n";
	print "sel: $sel_test[0]\n";
	print "out: Should be @out_test ... ";

	@mux16_out = _mux16(\@a_test, \@b_test, $sel_test[0]);
	if (@mux16_out ~~ @out_test) {print " passed! \n";}
	else {print " failed, got @mux16_out instead.\n";}
}
