/// @description 
//Properties
moveSpeed = 1;
moveCD = 0;
moveDelay = 2;

runSpeed = 32; //Debugging

moveDir = 3;

kbSpeed = 6;

//Variables
moveX = 0;
moveY = 0;

boostX = 0;
boostY = 0;

whiteAlpha = 0;

//Hurt cooldown
hurtCD = 0;
hurtCooldown = 20;

//For HUD
stopTime = 0;
moveTime = 0;

//Stats
stats_init();

//Inventory
inventory_init();

//Level
levels_init();

state = st.idle;

//Outline
outline_set(1, O_NORMAL);