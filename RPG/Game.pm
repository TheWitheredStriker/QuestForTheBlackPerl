package RPG::Game;

use strict;
use warnings;

use RPG::Character;
use RPG::Combat;
use RPG::UI;

sub new {
    my ($class) = @_;

    my $player = RPG::Character -> new(
        name   => "Adventurer",
        hp     => 30,
        maxHp  => 30,
        attack => 10,
        heals  => 3
    );

    my $goblin = RPG::Character -> new(
        name   => "Hideous Goblin",
        hp     => 30,
        maxHp  => 30,
        attack => 10,
    );

    return bless {
        player => $player,
        enemy  => $goblin,
        ui     => RPG::UI -> new
    }, $class;
}

sub run {
    my ($self) = @_;
    $self -> {ui} -> intro($self -> {player});

    my $combat = RPG::Combat -> new(
        player => $self -> {player},
        enemy  => $self -> {enemy},
        ui     => $self -> {ui}
    );

    $combat -> run;
}

1;