package RPG::UI;

use strict;
use warnings;
use feature qw(say signatures);

sub new($class) {
    return bless({}, $class);
}

sub intro($self, $player) {
    print <<END;

        You are a SPLENDOROUS ADVENTURER in a LAND OF MAGIC.
        Your quest is to find the legendary BLACK PERL.

        You have @{[$player -> hp]} HP and may heal yourself
        @{[$player -> remainingHeals]} times.

        You advance through the DARK DUNGEON.

        Before long, you find yourself face-to-face
        with a HIDEOUS GOBLIN.

        =================
        | BEGIN COMBAT! |
        =================

END
}

# In the functions below, declaring $self is necessary for the other arguments to work
sub startCombat($self, $player, $enemy) {
    $self -> status($player, $enemy);
}

sub status($self, $player, $enemy) {
    say("Your HP: " . $player -> {hp});
    say($enemy -> {name} . " HP: " . $enemy -> {hp});
    say("Remaining heals: " . $player -> {heals});
}

sub getAction($self) {
    print(
        "[1] Attack\n",
        "[2] Defend\n",
        "[3] Heal\n",
        "> "
    );

    my $input = readline(STDIN) or die("Program exited");
    chomp($input); # Trim whitespace

    return "attack" if $input eq "1";
    return "defend" if $input eq "2";
    return "heal"   if $input eq "3";

    # If none of the above were returned
    return "invalid";
}

sub playerAttack($self, $enemy, $damage) {
    print(
        "You strike the " . $enemy -> {name} . " with your TRUSTY SWORD.\n",
        "The " . $enemy -> {name} . " takes $damage damage!\n",
        "It now has " . $enemy -> {hp} . " HP.\n\n"
    );
}

# TODO: Interpolate enemy name
sub playerDefend($self, $player, $damage) {
    print(
        "You BRACE yourself for the goblin's attack, reducing its damage by 30%.\n",
        "You take $damage damage!\n"
    );
}

# TODO: Add amount of HP healed
sub heal($self, $player, $success) {
    if ($success) {
        print(
            "You call for the POWER OF THE GODS. They are amenable to your prayer.\n",
            "You now have " . $player -> {hp} . " HP.\n"
        );
    }

    else {
        say("You cannot heal right now!"); 
    }
}

sub enemyAttack($self, $player, $damage) {
    print(
        "The HIDEOUS GOBLIN strikes you with its claw!\n",
        "You take $damage damage!\n",
        "You now have " . $player -> {hp} . " HP.\n\n"
    );
}

sub endCombat($self, $player, $enemy) {
    if ($player -> {isAlive}) {
        say("You have SLAIN the " . $enemy -> {name} . "!");
    }

    else {
        say("You have been SLAIN!");
    }
}

1;