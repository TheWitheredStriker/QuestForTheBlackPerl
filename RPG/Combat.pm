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
        
        $self -> {ui} -> status($self -> {player}, $self -> {enemy});
    }
}

sub performAction($self, $action) {
    $self -> playerAttack if $action eq "attack";
    $self -> playerDefend if $action eq "defend";
    $self -> playerHeal   if $action eq "heal";
}

sub playerAttack($self) {
    my $damage = int(4 + rand(6)); # Between 4 and 10 damage
    $self -> {enemy} -> takeDamage($damage);
    $self -> {ui} -> playerAttack($self -> {enemy}, $damage);
}

sub playerDefend($self) {
    my $damage = int(rand(7));

    $self -> {player} -> takeDamage($damage);
    $self -> {ui} -> playerDefend($self -> {player}, $damage);
}

sub playerHeal($self) {
    my $hpHealed = int(5 + rand(5)); # Between 5 and 10
    my $success = $self -> {player} -> heal($hpHealed);
    $self -> {ui} -> heal($self -> {player}, $success);
}

sub enemyTurn($self) {
    my $damage = int(4 + rand(6));
    $self -> {player} -> takeDamage($damage);
    $self -> {ui} -> enemyAttack($self -> {player}, $damage);
}

1;