
# Technical Details:

## Section 1: Description
Period: 4
Kiran Yesley, Estella Yee 
The Double YY Campaign (Might change later)

### Brief Project Description: 
PACMAN
link to the online game: https://freepacman.org/

We will be recreating the classic Pacman game! Pacman is a fortune teller shaped character whose goal is to nagivate a maze consuming dots (points) and avoiding ghosts. Pacman can eat power pellets, which temporarily make the ghosts vulnerable and allow Pac-Man to eat them for more points. Fruits also give Pac-man more points when consumed. 

### Expanded Description 
A description of your technical design. This should include: 
* How you will be using the topics covered in class in the project

### Features 
Critical Features: 
- ~Randomly Generated Maze that is different every time~
- (Added in) Custom Map 
    - wraparound feature 
- Controllable Pacman 
- Pathfinding ghosts 
    - Regular mode & Vulnerable mode 
    - (Added in) Scatter, Run, and Blue Modes that designate how the ghosts move at a specific point in time 
    - Basic version: choose tile based on distance
    - Better version: use BFS to find the best path 
    - 4 different ghosts that have different target algorithms
- Point system and display that continuously upates 
    - Three different point systems: fruit, pellet, superpellet 
    - Superpellet should activate Blue Mode 

Extra Features: 
- Start and End screen, and replay screen 
- High Score 
- Choose your avatar 
- Stacking of point values per ghosts/different fruits
- different speeds for vulnerable and regular mode for ghosts  
- make custom looking walls
- Animations: 
    - Pacman dying animation 
    - Ghosts being eaten and running back to the home base 
     
# Project Design

UML Diagrams and descriptions of key algorithms, classes, and how things fit together:
New Diagram:
![Alt text](UML.png?raw=true "Title" ) 
Old diagram:
![Alt text](UML.jpg?raw=true "Title" ) 

MAP diagram plan:

![Alt text](map-1.jpg?raw=true "Title" ) 
    
# Intended pacing:

How you are breaking down the project and who is responsible for which parts.

## JOBS 
Kiran's Responsibilities: 
- Game 
- Point classes and extra features

Estella's Responsibilities:
- Game 
- Character, Ghosts, and Pacman classes 

## TIMELINE 
A timeline with expected completion dates of parts of the project. 
- Wednesday, 05/21 Complete Protoype 
- Monday, 05/25 Complete basic versions of all classes except Game 
- Wednesday, 05/27 Complete any drawings and art needed, start all classes
- Friday, 05/30 Complete Game 
- Monday 06/02 add all extra features not added yet
- Friday 06/06 fix any bugs (hopefully none exist) and turn in

