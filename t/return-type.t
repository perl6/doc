use v6;
use Test;
use lib 'lib';

my @files;

# Every .pod6 file in the Type directory.
@files = qx<git ls-files>.lines.grep(* ~~ /'.pod6'/).grep(* ~~ /Type/);

plan +@files;

for @files -> $file {
    my @lines;
    my Int $line-no = 1;
    for $file.IO.lines -> $line {
        if so $line ~~ /(multi|method|sub) .+? ')' ' '+? 'returns' ' '+? (<alnum>|':')+? $/ {
	    @lines.push($line-no);
	}
	$line-no++;
    }
    if @lines {
        flunk "$file has bad return type: {@lines}";
    } else {
        pass "$file return types are ok";
    }
}
