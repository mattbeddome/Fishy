# Fishy
 
Fishy is a bot I wrote in order to catch fish for profit in Final Fantasy XI, an online RPG.
The game provides clues to the player as to what fish may be on the line using text in the message log, and a minigame is played to catch the fish.

Depending on whether the player has a large fish, a small fish, an item, or a monster (that will attack the player) on the line, a different message is displayed.
To catch a fish, arrows appear on screen (either left or right side of the screen) and the player must press an arrow key pertaining to that direction.

In order to avoid any kind of packet sniffing that could be detected by anti-cheat measures, my method of determining what type of fish was on the line was to scan areas of the screen for pixel colours.

In order to avoid repetitive-input detection systems, I allow for the player to configure the bots accuracy to simulate player mistakes, as well as randomized delays.
The players mouse X and Y coordinates can also influence the length of delays and accuracy, to force "breaks" and streaks of bad accuracy.
