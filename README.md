This is a simple and barebones Perl text RPG made for fun and learning. It's also very unfinished so don't expect too much polish.

You're an adventurer crawling a dungeon so you can collect the legendary Black Perl. Monsters (currently just a hideous goblin) stand in your way. What will you do?

# Todo
## Short-term
- [ ] Find way to call `RPG::UI::status` after every action (instead of once at the beginning)
- [ ] Replace hardcoded values with actual formulas
- [ ] Add 30% chance for goblin to miss attack

## Long-term
- [ ] Add more battles or events
- [ ] Items?

# Known bugs
- [x] Exiting program with Ctrl-C still evaluates code, producing errors. _(Fixed with die statement)_