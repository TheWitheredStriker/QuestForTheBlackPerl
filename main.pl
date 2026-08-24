use strict;
use warnings;

# Later install Perl::Struct
my %player = (
    HP => 30,
    ATK => 5,
    heals => 3
);

my %goblin = (
    HP => 30,
    ATK => 5
);

print(qq(
You are a SPLENDOROUS ADVENTURER in a LAND OF MAGIC. Your quest is to find the legendary BLACK PERL.
Legend has it that this DARK DUNGEON houses the BLACK PERL. Eternal glory awaits you.

You have $player{HP} HP and may heal yourself $player{heals} times.

You advance through the DARK DUNGEON. Before long, you find yourself face-to-face with a HIDEOUS GOBLIN.

=================
| BEGIN COMBAT! |
=================
));

my $gameRunning = 1; # Perl has no builtin true/false

while ($gameRunning == 1) {
    print(
        "Your HP: $player{HP}\n" .
        "Goblin HP: $goblin{HP}\n" .
        "\n" .
        "[1] Attack\n" .
        "[2] Defend\n" .
        "[3] Heal\n "
    );

    my $response = readline(STDIN);
    chomp($response);
    my $goblinWillAttack = 1;

    if ($response == 1) {
        print("You strike the HIDEOUS GOBLIN with your TRUSTY SWORD.\n");
        my $damage = 10;
        $goblin{HP} -= $damage;
        print("The HIDEOUS GOBLIN takes $damage damage!\nIt now has $goblin{HP} HP.\n\n");
    }

    elsif ($response == 2) {
        print("You BRACE yourself for the HIDEOUS GOBLIN's attack, reducing its damage by 30%.\n");
        my $damage = 7;
        $player{HP} -= $damage;
        print("The HIDEOUS GOBLIN strikes you with its claw! You take $damage damage!\n");
        print("You now have $player{HP} HP.\n\n");
        $goblinWillAttack = 0;
    }

    elsif ($response == 3) {
        if ($player{HP} == 30) {
            print("Your HP is maxed out!\n\n");
        }

        else {
            print("Healing now! \n");
            $player{HP} += 5;
            print("Your now have $player{HP} HP.\n\n");
        }
    }

    unless ($goblinWillAttack == 0) {
        my $damage = 10;
        $player{HP} -= $damage;
        print("The HIDEOUS GOBLIN strikes you with its claw! You take $damage damage!\n");
        print("You now have $player{HP} HP.\n\n");
    }

}
