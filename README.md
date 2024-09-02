# Learning RPG
A simple and original RPG created using Godot for the purpose of learning to develop using the game engine. Available to play on web at https://arz-c.itch.io/learning-rpg.

<img src="https://github.com/user-attachments/assets/b4a600d1-b2da-4667-be43-cbec1343fbaa" width="250" height="250">
<img src="https://github.com/user-attachments/assets/0ebd4d60-17cf-41b0-af7a-7958a302f834" width="250" height="250">
<img src="https://github.com/user-attachments/assets/3a300919-0c9e-4b19-bdef-f0dc91705142" width="250" height="250">

## Some technical highlights:
- Used an object-oriented approach where each node is placed within a hierarchy. Followed the best practice: parent nodes call methods on child nodes, and child nodes emit signals which may be caught by parent nodes.
- Combined inheritence (e.g. when designing states for the enemy AI's state machine) and composition (e.g. when implementing health bars and hitboxes across several entities).
- Enemy slime AI follows a state machine which navigates between an idle wander, chasing the player, and attacking the player.
- Animated sprites and level layouts were implemented using sprite sheets and tile maps.
- Hitboxes were used for body collisions and attack ranges.
