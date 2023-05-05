#!/usr/bin/perl
#

require './gates.pl';
require './multi-way.pl';

open (FH, "<", "Mux.cmp") || die "Could not open .cmp file\n";

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


	print "Running test for _mux ... \n";
	print "a: $a_test[0]\n";
	print "b: $b_test[0]\n";
	print "sel: $sel_test[0]\n";
	print "out: Should be $out_test[0] ... ";

	$mux_out = _mux($a_test[0], $b_test[0], $sel_test[0]);
	if ($mux_out eq $out_test[0]) {print " passed! \n";}
	else {print " failed, got $mux_out instead.\n";}
}
