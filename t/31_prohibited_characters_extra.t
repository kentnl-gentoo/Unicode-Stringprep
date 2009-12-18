use strict;
use utf8;
use diagnostics;

no warnings 'utf8';

use Test::More;
use Test::NoWarnings;

use Unicode::Stringprep;

our @map_data = (
    0xE0001, 0xE0001,
    0xE0020, 0xE007F,
    0xEFFFE, 0x10FFFF,
);

our @data = (
    0xE0002,
);

plan tests => ($#data+1) + 1;

my $prep = Unicode::Stringprep->new( 3.2, [ ], '', [ @map_data ], 0 );

foreach(@data) 
{
  my $in = $_;
  is(Unicode::Stringprep::_u8_qmeta(
eval {
$prep->(Unicode::Stringprep::_u8_chr($in))
}),
    Unicode::Stringprep::_u8_qmeta(Unicode::Stringprep::_u8_chr($in)),
    sprintf 'U+%04X', $in);
}