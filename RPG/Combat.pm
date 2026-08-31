package RPG::Combat;

use strict;
use warnings;
use feature 'signatures';

# Constructor
sub new($class, %args) {
    return bless {
        player => $args{player},
        enemy  => $args{enemy},
        ui     => $args{ui}
    }, $class;
}

sub run($self) {
    $self -> {ui} -> startCombat(
        $self -> {player},
        $self -> {enemy}
    );

    while ($self -> {player} -> isAlive and $self -> {enemy} -> isAlive) {
        my $action = $self -> {ui} -> getAction;
        $self -> performAction($action);

        last unless $self -> {enemy} -> isAlive;
        $self -> enemyTurn;
    }
}

sub performAction($self, $action) {
    $self -> playerAttack if $action eq "attack";
    $self -> playerDefend if $action eq "defend";
    $self -> playerHeal   if $action eq "heal";
}

sub playerAttack($self) {
    my $damage = $self -> {player} -> attackPower;
    $self -> {enemy} -> takeDamage($damage);
    $self -> {ui} -> playerAttack($self -> {enemy}, $damage);
}

sub playerDefend($self) {
    my $damage = 7; # TODO: Un-hardcode later!

    $self -> {player} -> takeDamage($damage);
    $self -> {ui} -> playerDefend($self -> {player}, $damage);
}

sub playerHeal($self) {
    my $success = $self -> {player} -> heal(10);
    $self -> {ui} -> heal($self -> {player}, $success);
}

sub enemyTurn($self) {
    my $damage = $self -> {enemy} -> attackPower;
    $self -> {player} -> takeDamage($damage);
    $self -> {ui} -> enemyAttack($self -> {player}, $damage);
}

1;