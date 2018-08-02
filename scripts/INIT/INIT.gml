gml_pragma("global", "INIT()");

#region Main
//Functions
#macro log show_debug_message

//Camera
enum CAM{
	W = 64,
	H = 64,
	SCALE = 10
}
#endregion

#region Shaders
//Uniforms
global.uniHeight = shader_get_uniform(shDepth, "height");
outline_init();
#endregion

#region Particles
//System
global.pSys = part_system_create();

//Leaf
global.pLeaf = part_type_create();
#macro PLEAF global.pLeaf

part_type_sprite(PLEAF, sLeaf, 0, 0, 0);
part_type_life(PLEAF, 20, 30);
part_type_orientation(PLEAF, 0, 360, -1, 0, 0); //-1 means to be set beforecreating
part_type_direction(PLEAF, 0, 360, -1, 0);
part_type_speed(PLEAF, 0.5, 1, -0.05, 0);
#endregion

#region Graphics
//Outlines
#macro O_NORMAL c_black
#macro O_SWORD c_black
#macro O_ENEMY $b21030 //NES Red

//Player sword holding coordinates
enum SC{
	X,
	Y,
	ANGLE
}
#macro SCS global.swordCoords

/// [Direction, Frame]
//Right
SCS[0, 0] = [2, 2, 30];
SCS[0, 1] = [2, 3, 0];
SCS[0, 2] = [2, 3, -30];
SCS[0, 3] = [0, 4, -60];

//Up
SCS[1, 0] = [-2, -3, 135];
SCS[1, 1] = [4, -3, 90];
SCS[1, 2] = [5, 0, 45];
SCS[1, 3] = [6, 1, 0];

//Left
SCS[2, 0] = [-3, 2, 210];
SCS[2, 1] = [-3, 1, 180];
SCS[2, 2] = [-3, -1, 150];
SCS[2, 3] = [0, -2, 120];

//Down
SCS[3, 0] = [-1, 3, -45];
SCS[3, 1] = [-3, 3, -90];
SCS[3, 2] = [-4, 3, -135];
SCS[3, 3] = [-6, 2, 180];

/// Sword sprites
#macro swSpr global.swordSprites
swSpr[sword.basic] = sSwordBasic;
#endregion

#region Input
//Keyboard inputs
#macro A_KEY "E"
#macro B_KEY "N"
#macro X_KEY "M"
#macro R2_VKEY vk_shift

//Variables
global.APressed = 0;
global.BPressed = 0;
global.XPressed = 0;
global.downHoldTime = 0;
global.horHoldTime = 0;
global.axisDirOn = 0;
#endregion

#region Inventory
//Contents
#macro SWORD 0
#macro BOW 1

//Swords
enum sword{
	basic
}

//Sword states
enum swst{
	attack,
	speed
}

#macro swStats global.swordStats
swStats[sword.basic, swst.attack] = 1;
swStats[sword.basic, swst.speed] = 1;
#endregion

#region Proc Gen
//Array contents
enum pr{
	grid, x, y
}

/// Proc Gen
//Properties
#macro AREA 512
#macro DIVISION 256
#macro SIZE 12

//Area Types
enum A{
	EMPTY,
	
	LAND,
	VILLAGE,
	HOSTILE,
	
	COUNT
}

//Placement types (priority matters)
enum P{
	EMPTY,
	
	GRASS,
	TREE,
	HOUSE,
	FORT,
	
	COUNT
}

/// Placements for each
#macro PL global.placement

PL[A.LAND] = [P.GRASS, P.TREE];
PL[A.VILLAGE] = [P.GRASS, P.TREE, P.HOUSE];
PL[A.HOSTILE] = [P.GRASS, P.TREE, P.FORT];

/// Chances for each (% out of 100)
#macro AC global.chance
AC[A.EMPTY] = 0;
AC[A.LAND] = 20;
AC[A.VILLAGE] = 60;
AC[A.HOSTILE] = 30;

/// Chances for placeables
#macro PC global.placementChance

//Land
PC[A.LAND, P.GRASS] = 10;
PC[A.LAND, P.TREE] = 10;

//Village
PC[A.VILLAGE, P.GRASS] = 10;
PC[A.VILLAGE, P.TREE] = 10;
PC[A.VILLAGE, P.HOUSE] = 6;

//Hostile
PC[A.HOSTILE, P.GRASS] = 10;
PC[A.HOSTILE, P.TREE] = 10;
PC[A.HOSTILE, P.HOUSE] = 5;
PC[A.HOSTILE, P.FORT] = 1000;

// Counts for placeables
#macro PCN global.placementCount

PCN[P.GRASS] = -1;
PCN[P.TREE] = -1;
PCN[P.HOUSE] = 5;
PCN[P.FORT] = 1;

// Sizes for placeables
#macro PS global.placementSize
#macro MIN_X 0
#macro MAX_X 1
#macro MIN_Y 2
#macro MAX_Y 3

PS[P.GRASS, MIN_X] = 2;
PS[P.GRASS, MAX_X] = 8;
PS[P.GRASS, MIN_Y] = 2;
PS[P.GRASS, MAX_Y] = 8;

PS[P.TREE, MIN_X] = 3;
PS[P.TREE, MAX_X] = 3;
PS[P.TREE, MIN_Y] = 3;
PS[P.TREE, MAX_Y] = 3;

PS[P.HOUSE, MIN_X] = 4;
PS[P.HOUSE, MAX_X] = 4;
PS[P.HOUSE, MIN_Y] = 4;
PS[P.HOUSE, MAX_Y] = 4;

PS[P.FORT, MIN_X] = 8;
PS[P.FORT, MAX_X] = 20;
PS[P.FORT, MIN_Y] = 8;
PS[P.FORT, MAX_Y] = 20;

// Colors for placeables
#macro PCOL global.placementColor

PCOL[P.GRASS] = c_teal;
PCOL[P.TREE] = c_green;
PCOL[P.HOUSE] = c_yellow;
PCOL[P.FORT] = c_red;

// Margins for placeables
#macro PM global.placementMargin

PM[P.GRASS] = 0;
PM[P.TREE] = 0;
PM[P.HOUSE] = 1;
PM[P.FORT] = 0;

// Instances for placeables
#macro PO global.placementObject
// -1 Fort

PO[P.GRASS] = oGrass;
PO[P.TREE] = oTree;
PO[P.HOUSE] = oHouse;
PO[P.FORT] = -4;
#endregion