#!/usr/bin/perl
#


require './gates.pl';
require './multi-way.pl';

sub _alu {

	my ($xref, $yref, $zx, $nx, $zy, $ny, $f, $no) = @_;

	@x = @$xref;
	@y = @$yref;



	# zero x / negate

	my @zdx      = _mux16(\@x, \(0) x 16, $zx);
	my @notx     = _not16(@zdx);
	my @ndx      = _mux16(\@zdx, \@notx, $nx);

	my @zdy      = _mux16(\@y, \(0) x 16, $zy);
	my @noty     = _not16(@zdy);
	my @ndy      = _mux16(\@zdy, \@noty, $ny);

	# x + y OR x & y
	my @xplusy   = _add16(\@ndx, \@ndy);
	my @xandy    = _and16(\@ndx, \@ndy);
	my @fxy      = _mux16(\@xandy, \@xplusy, $f);

	# Negate the result?
	my @nfxy     = _not16(@fxy);
	my @no_sel_f = _mux16(\@fxy, \@nfxy, $no);

	@finalLeft   = @no_sel_f[0..7];
	@finalRight  = @no_sel_f[8..15];
	$first_out   = $no_sel_f[0]; #HDL code uses [15] for first. It's reverse. 
	
	# output == 0 (zr)
	
	my $zr1 = _or8way(@finalLeft);
	my $zrr = _or8way(@finalRight);

	my $nzr = _or($zr1, $zrr);
	my $zr  = _not($nzr);

	# output < 0 (ng)
	my $ng = _and($first_out, 1);


	return (\@no_sel_f, $zr,$ng);
}

1;

