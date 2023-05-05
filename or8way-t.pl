#!/usr/bin/perl
#

require './gates.pl';
require './multi-way.pl';

open (FH, "<", "Or8Way.cmp") || die "Could not open .cmp file\n";

@TEST_LINES = <FH>;

for $test_line (@TEST_LINES) {

	next if $test_line =~/out/;

	$_      = $test_line; # we dont need the first line 
	s/ //g;

	@testbits = split(/\|/, $_);

	@in_test    = split(//, $testbits[1]);
	@out_test   = split(//, $testbits[2]);

	print "Running test for _o8way ... \n";
	print "in: @in_test\n";
	print "out: Should be $out_test[0] ... ";

	$or8way_out = _or8way(@in_test);
	if ($or8way_out eq $out_test[0]) {print " passed! \n";}
	else {print " failed, got $or8way_out instead.\n";}
}
