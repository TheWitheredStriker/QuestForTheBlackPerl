package RPG::Character;

use strict;
use warnings;
use feature 'signatures';

# Constructor
sub new($class, %args) {
    return bless {
        name   => $args{name},
        hp     => $args{hp},
        maxHp  => $args{maxHp},
        attack => $args{attack},
        heals  => $args{heals}
    }, $class;
}

# Getters
sub name($self) {
    return $self -> {name};
}

sub hp($self) {
    return $self -> {hp};
}

sub maxHp($self) {
    return $self -> {maxHp};
}

sub attackPower($self) {
    return $self -> {attack};
}

sub remainingHeals($self) {
    return $self -> {heals};
}

sub isAlive($self) {
    return $self -> {hp} > 0;
}

# Setters
sub takeDamage($self, $amount) {
    $self -> {hp} -= $amount;

    # Prevent negative HP
    $self -> {hp} = 0 if $self -> {hp} < 0;
}

sub heal($self, $amount) {
    # Don't heal if we're at max HP or have no heals left
    if ($self -> {heals} <= 0 or $self -> {hp} >= $self -> {maxHp}) {
        return 0;
    }

    $self -> {heals}--;
    $self -> {hp} += $amount;

    # Prevent overheal
    if ($self -> {hp} > $self -> {maxHp}) {
        $self -> {hp} = $self -> {maxHp};
    }

    return 1;
}

1;
