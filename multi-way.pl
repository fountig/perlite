#!/usr/bin/perl


require './gates.pl';



sub _dmux4way {

	my ($in, $selref) = @_;

	@sel = @$selref;
        my ($ao, $bo) = _dmux($in, $sel[0]);
 	my ($a, $b)   = _dmux($ao, $sel[1]);
	my ($c, $d)   = _dmux($bo, $sel[1]);
        return ($a, $b, $c, $d);






}


sub _dmux8way {


	# its $sel[0] for the dmux, and sel[1..2] for the rest. 
	# No idea why its backwards, but I'm in no mood to find out why.
	# Let's finish the ALU and go home.
	# 13/10/22.
	

	my ($in, $selref) = @_;
	@sel = @$selref;
	$sel12[0] = $sel[1];
	$sel12[1] = $sel[2];

	my ($dIn0, $dIn1) = _dmux($in, $sel[0]);
        my ($a, $b, $c, $d) = _dmux4way($dIn0,\@sel12);
	my ($e, $f, $g, $h) = _dmux4way($dIn1, \@sel12);

	return ($a, $b, $c, $d, $e, $f, $g, $h);
}
sub _or8way {
	my @in = @_;
	my $out;


#    IN in[8];
#    OUT out;


	my $a = _or($in[0], $in[1]);
	my $b = _or($a, $in[2]);
	my $c = _or($b, $in[3]);
	my $d = _or($c, $in[4]);
	my $e = _or($d, $in[5]);
	my $f = _or($e, $in[6]);

	$out = _or($f, $in[7]);

	return $out;
}

sub _or16 {
	my ($aref, $bref) = @_;
	
	@a = @$aref;
	@b = @$bref;
	my @out;

	$out[0] = _or($a[0], $b[0]);
	$out[1] = _or($a[1], $b[1]);
	$out[2] = _or($a[2], $b[2]);
	$out[3] = _or($a[3], $b[3]);
	$out[4] = _or($a[4], $b[4]);
	$out[5] = _or($a[5], $b[5]);
	$out[6] = _or($a[6], $b[6]);
	$out[7] = _or($a[7], $b[7]);
	$out[8] = _or($a[8], $b[8]);
	$out[9] = _or($a[9], $b[9]);
	$out[10] = _or($a[10], $b[10]);
	$out[11] = _or($a[11], $b[11]);
	$out[12] = _or($a[12], $b[12]);
	$out[13] = _or($a[13], $b[13]);
	$out[14] = _or($a[14], $b[14]);
	$out[15] = _or($a[15], $b[15]);

	return @out;
} 


sub _mux4way16 {

	my ($aref, $bref, $cref, $dref, $selref) = @_;

	# dereference
	
	@a = @$aref;
	@b = @$bref;
	@c = @$cref;
	@d = @$dref;
	@sel = @$selref;

	# testing showed that $sel[0] needs to be $sel[1] 
	# and sel[1] be sel[0].
	my @q 	= _mux16(\@a, \@b, $sel[1]);
	my @r 	= _mux16(\@c, \@d, $sel[1]);

	my ($mux0, $mux1, $mux2, $mux3, $mux4, $mux5, $mux6, $mux7, $mux8, $mux9, $mux10, $mux11, $mux12, $mux13, $mux14, $mux15)  = _mux16(\@q, \@r, $sel[0]);
 

}
sub _mux8way16 {


	my ($aref, $bref, $cref, $dref, $eref, $fref, $gref, $href, $selref) = @_;

	# dereference
	
	@a = @$aref;
	@b = @$bref;
	@c = @$cref;
	@d = @$dref;
	@e = @$eref;
	@f = @$fref;
	@g = @$gref;
	@h = @$href;
	@sel =reverse( @$selref ); #this works, but better fix the array indexes. 

	my @q = _mux16(\@a, \@b, $sel[0]);
	my @r = _mux16(\@c, \@d, $sel[0]);
	my @s = _mux16(\@e, \@f, $sel[0]);
	my @t = _mux16(\@g, \@h, $sel[0]);
	my @y = _mux16(\@q, \@r, $sel[1]);
	my @z = _mux16(\@s, \@t, $sel[1]);	
	my ($out0, $out1, $out2, $out3, $out4, $out5, $out6, $out7, $out8, $out9, $out10, $out11, $out12, $out13, $out14, $out15) = _mux16(\@y, \@z, $sel[2]);

	return ($out0, $out1, $out2, $out3, $out4, $out5, $out6, $out7, $out8, $out9, $out10, $out11, $out12, $out13, $out14, $out15);

}
sub _not16 {

        my @ports = @_;

        my @out = map { _not($_) } @ports;
        return @out;
}
sub _and16 {

        my ($aref, $bref) = @_;

	# dereference
	
	@a = @$aref;
	@b = @$bref;
	
	$out0  = _and($a[0], $b[0]);
	$out1  = _and($a[1], $b[1]);
	$out2  = _and($a[2], $b[2]);
	$out3  = _and($a[3], $b[3]);
	$out4  = _and($a[4], $b[4]);
	$out5  = _and($a[5], $b[5]);
	$out6  = _and($a[6], $b[6]);
	$out7  = _and($a[7], $b[7]);
	$out8  = _and($a[8], $b[8]);
	$out9  = _and($a[9], $b[9]);
	$out10 = _and($a[10], $b[10]);
	$out11 = _and($a[11], $b[11]);
	$out12 = _and($a[12], $b[12]);
	$out13 = _and($a[13], $b[13]);
	$out14 = _and($a[14], $b[14]);
	$out15 = _and($a[15], $b[15]);

        return ($out0, $out1, $out2, $out3, $out4, $out5, $out6, $out7, $out8, $out9, $out10, $out11, $out12, $out13, $out14, $out15);
 
}


sub _mux16 {

        my ($aref, $bref, $sel) = @_;
	# dereference 

	my @a = @$aref;
	my @b = @$bref;

	my $mux0  = _mux($a[0],$b[0], $sel);

        my $mux1  = _mux($a[1], $b[1], $sel);
        my $mux2  = _mux($a[2], $b[2], $sel);
        my $mux3  = _mux($a[3], $b[3], $sel);
        my $mux4  = _mux($a[4], $b[4], $sel);
        my $mux5  = _mux($a[5], $b[5], $sel);
        my $mux6  = _mux($a[6], $b[6], $sel);
        my $mux7  = _mux($a[7], $b[7], $sel);
        my $mux8  = _mux($a[8], $b[8], $sel);
        my $mux9  = _mux($a[9], $b[9], $sel);
        my $mux10 = _mux($a[10], $b[10], $sel);
        my $mux11 = _mux($a[11], $b[11], $sel);
        my $mux12 = _mux($a[12], $b[12], $sel);
        my $mux13 = _mux($a[13], $b[13], $sel);
        my $mux14 = _mux($a[14], $b[14], $sel);
        my $mux15 = _mux($a[15], $b[15], $sel);

        return ($mux0, $mux1, $mux2, $mux3, $mux4, $mux5, $mux6, $mux7, $mux8, $mux9, $mux10, $mux11, $mux12, $mux13, $mux14, $mux15);

}

sub _halfadder {
	
	my ($a, $b) = @_;
	
	my $sum   = _xor($a, $b);
	my $carry = _and($a, $b);

	return ($sum, $carry);
 

}

sub _fulladder {

	my ($a, $b, $c) = @_;
	my ($ab, $cab)  = _halfadder($a, $b);
	my ($sum, $s)   = _halfadder($c, $ab);
	my $carry       = _or($cab, $s);

	return ($sum, $carry);
	

}

sub _add16 {
	my ($aref, $bref) = @_;

	# dereference
	
	my @a = @$aref;
	my @b = @$bref;

	my ($out15, $carry15) = _halfadder($a[15], $b[15]);
        my ($out14, $carry14) = _fulladder($a[14], $b[14], $carry15);
        my ($out13, $carry13) = _fulladder($a[13], $b[13], $carry14);
        my ($out12, $carry12) = _fulladder($a[12], $b[12], $carry13);
        my ($out11, $carry11) = _fulladder($a[11], $b[11], $carry12);
        my ($out10, $carry10) = _fulladder($a[10], $b[10], $carry11);
        my ($out9, $carry9)   = _fulladder($a[9], $b[9], $carry10);
        my ($out8, $carry8)   = _fulladder($a[8], $b[8], $carry9);
        my ($out7, $carry7)   = _fulladder($a[7], $b[7], $carry8);
        my ($out6, $carry6)   = _fulladder($a[6], $b[6], $carry7);
        my ($out5, $carry5)   = _fulladder($a[5], $b[5], $carry6);
        my ($out4, $carry4)   = _fulladder($a[4], $b[4], $carry5);
        my ($out3, $carry3)   = _fulladder($a[3], $b[3], $carry4);
        my ($out2, $carry2)   = _fulladder($a[2], $b[2], $carry3);
        my ($out1, $carry1)   = _fulladder($a[1], $b[1], $carry2);
        my ($out0, $carry0)   = _fulladder($a[0], $b[0], $carry1);

	return ($out0, $out1, $out2, $out3, $out4, $out5, $out6, $out7, $out8, $out9, $out10, $out11, $out12, $out13, $out14, $out15);

}

sub _inc16 {

	my @in = @_;
	
	my @b = qw (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1);
	my @out = _add16(\@in,\@b);
	
	return @out;
}
1;

