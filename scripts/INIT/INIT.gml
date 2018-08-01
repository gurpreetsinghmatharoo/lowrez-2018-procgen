gml_pragma("global", "INIT()");

#region Main
//Functions
#macro log show_debug_message
#endregion


#region Proc Gen
//Array contents
enum pr{
	grid, x, y
}

/// Proc Gen
//Properties
#macro AREA 2048
#macro DIVISION 512
#macro SIZE 16

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

PS[P.TREE, MIN_X] = 2;
PS[P.TREE, MAX_X] = 2;
PS[P.TREE, MIN_Y] = 2;
PS[P.TREE, MAX_Y] = 2;

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
#endregion