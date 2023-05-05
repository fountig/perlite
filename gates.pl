#!/usr/bin/perl
#



sub _nand {

	my ($a, $b) = @_;
	
	if ($a == 1 && $b == 1) {return 0;}
	else 			{return 1;}

}

sub _not {

	my $a = $_[0];
	my $out = _nand($a, $a);
	return $out; 
}


sub _and {
	
	my ($a, $b) = @_;
	my $j1 = _nand($a, $b);
	my $out = _not($j1);
	return $out;
}

sub _or {

	my ($a, $b) = @_;
	my $nota = _not($a);
	my $notb = _not($b);
	my $j1 = _and($nota,$notb );
	my $out = _not($j1);
	return $out;
}


sub _xor {

# IN a, b;
	my ($a, $b) = @_;
	my $nota = _not($a);
	my $notb = _not($b);
	my $j1 = _and($nota, $b);
	my $j2 = _and($a, $notb);
	my $out = _or($j1, $j2);
	return $out;

}

sub _mux {
	
	my ($a, $b, $sel) = @_;
	my $notsel = _not($sel);
	my $j1 = _and($a, $notsel);
	my $j2 = _and($b, $sel);
	my $out = _or($j1, $j2);
	return $out;

}

sub _dmux {

	my ($in, $sel) = @_;
	$out1 = _not($sel);	
	$out2 = _and($in, $out1);
	$out3 = _and($in, $sel);
	return ($out2, $out3);
}

1;
