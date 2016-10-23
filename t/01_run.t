use strict;

use Test::More;
use WebService::GlotIO;
use DDP;

my $glotIO = WebService::GlotIO->new();
my $glotio_languages = $glotIO->runner->list_languages;

is( ref($glotio_languages), 'ARRAY', 'Got a Languages array');

done_testing;
