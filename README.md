 _______  ___   _______  _______  __   __  ___   _______      ___  _______  ___   __    _  _______  ______   \
|  _    ||   | |       ||       ||  | |  ||   | |       |    |   ||       ||   | |  |  | ||       ||    _ |\  
| |_|   ||   | |  _____||       ||  | |  ||   | |_     _|    |   ||   _   ||   | |   |_| ||    ___||   | || \ 
|       ||   | | |_____ |       ||  |_|  ||   |   |   |      |   ||  | |  ||   | |       ||   |___ |   |_||_ \
|  _   | |   | |_____  ||      _||       ||   |   |   |   ___|   ||  |_|  ||   | |  _    ||    ___||    __  |\
| |_|   ||   |  _____| ||     |_ |       ||   |   |   |  |       ||       ||   | | | |   ||   |___ |   |  | |\
|_______||___| |_______||_______||_______||___|   |___|  |_______||_______||___| |_|  |__||_______||___|  |_|\


Ex Deo:

```
sub _nand {

	my ($a, $b) = @_;
	
	if ($a == 1 && $b == 1) {return 0;}
	else 			{return 1;}

}

```

Files need a bit of a cleanup, documentation is sorely missing right now, come back later.

Run ```alu-t.pl``` to perform all ALU tests. The .cmp files are from nand2tetris.\
This project has high aspirations, but for now it's just proof of concept.





