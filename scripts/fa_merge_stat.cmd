@perl -Sx %0 %*
@goto :eof
#!perl

sub usage {

print <<EOM;

Usage: fa_merge_stat [OPTIONS] < input.txt > output.txt

This program merges counts in format: DATA\\tCOUNT\\n. Where DATA is 
an arbitrary string.

EOM

}

while (0 < 1 + $#ARGV) {

    if("--help" eq $ARGV [0]) {

        usage ();
        exit (0);

    } else {

        last;
    }
    shift @ARGV;
}


open INPUT, " fa_sortbytes -m | " ;

$prev = "";
$pf = 0;

while (<INPUT>) {

  chomp;

  $i = rindex($_, "\t");

  if(-1 != $i) {

    $s1 = substr($_, 0, $i);
    $s2 = 0 + substr($_, $i + 1);

    if($s1 ne $prev) {

      if("" ne $prev) {
        print "$prev\t$pf\n";
      }

      $prev = $s1;
      $pf = $s2;

    } else {

      $pf += $s2;
    }
  }
}

if($prev ne "") {
  print "$prev\t$pf\n";
}


close INPUT;
