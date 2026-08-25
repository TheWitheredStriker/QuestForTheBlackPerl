use strict;
use warnings;
use lib '.'; # Makes Perl look for directories within containing folder
use RPG::Game;

my $game = RPG::Game -> new;
$game -> run;
