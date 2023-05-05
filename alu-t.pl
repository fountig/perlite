#!/usr/bin/perl
#


require './alu.pl';

open (FH, "<", "ALU.cmp") || die "Could not open .cmp file\n";

@TEST_LINES = <FH>;

for $test_line (@TEST_LINES) {

	next if $test_line =~/out/;

	$_      = $test_line; # we dont need the first line 
	s/ //g;

	@testbits = split(/\|/, $_);

	@x_test   = split(//, $testbits[1]);
	@y_test   = split(//, $testbits[2]);
	@zx_test 	  = split(//, $testbits[3]);
	@nx_test	  = split(//, $testbits[4]);
	@zy_test	= split(//, $testbits[5]);
	@ny_test	= split(//, $testbits[6]);
	@f_test	= split(//, $testbits[7]);
	@no_test	= split(//, $testbits[8]);



	print "Running test for alu  ... \n";
	print "x: @x_test\n";
	print "y: @y_test\n";
	print "zx: $zx_test[0]\n";
	print "nx: $nx_test[0]\n";
	print "zy: $zy_test[0]\n";
	print "ny: $ny_test[0]\n";
	print "f:  $f_test[0]\n";
	print "no: $no_test[0]\n";

	my ($outref, $zr, $ng) = _alu(\@x_test,\@y_test, $zx_test[0], $nx_test[0], $zy_test[0], $ny_test[0], $f_test[0], $no_test[0]);

	my @alu_out = @$outref;
	print "*" x 80 . "\n";
	print "OUT: @alu_out      ZR = $zr      NG = $ng\n";
	print "*" x 80 . "\n";

}
