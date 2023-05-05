# biscuitjoiner
Nisan &amp; Shocken's 16-bit Hack ALU chipset written in Perl5 arrays using only calls to _nand()

```
sub _nand {

	my ($a, $b) = @_;
	
	if ($a == 1 && $b == 1) {return 0;}
	else 			{return 1;}

}
```


