package RPG::Character;

use strict;
use warnings;

# Constructor
sub new {
    my ($class, %args) = @_;

    return bless {
        name   => $args{name},
        hp     => $args{hp},
        maxHp  => $args{maxHp},
        attack => $args{attack},
        heals  => $args{heals}
    }, $class;
}

# Getters
sub name {
    my ($self) = @_;
    return $self -> {name};
}

sub hp() {
    my ($self) = @_;
    return $self -> {hp};
}

sub maxHp {
    my ($self) = @_;
    return $self -> {maxHp};
}

sub attackPower {
    my ($self) = @_;
    return $self -> {attack};
}

sub remainingHeals {
    my ($self) = @_;
    return $self -> {heals};
}

sub isAlive {
    my ($self) = @_;
    return $self -> {hp} > 0;
}

# Setters
sub takeDamage {
    my ($self, $amount) = @_;

    $self -> {hp} -= $amount;
    # Prevent negative HP
    $self -> {hp} = 0 if $self -> {hp} < 0;
}

sub heal {
    my ($self, $amount) = @_;

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
