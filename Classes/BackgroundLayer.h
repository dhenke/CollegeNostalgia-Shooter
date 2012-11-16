//
//  BackgroundLayer.h
//  Final-Project-Refactored
//
//  Created by David Henke on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Sprite.h"
#import "Enemy.h"
#import "Player.h"
#import "ControlsLayer.h"
#import "MainMenu.h"
#import "GameController.h"

@interface BackgroundLayer : CCLayer {
	CCTMXTiledMap *tileMap;
	CGPoint mapOrigin;
	NSMutableArray* enemies;
	NSMutableArray* enemySprites;
	NSMutableArray* enemyBullets;
	CGSize windowSize;
}

/*
 *init initializes a new BackgroundLayer object and initializes member arrays
 *@return the new BackgroundLayer object
 */
-(id)init;
/*
 *dealloc frees the memory and member array
 */
-(void)dealloc;
/*
 *setupLevel takes a levelNumber and switches based on which level is being loaded
 *@param _levelNumber which level is being loaded
 */
-(void)setupLevel:(int)_levelNumber;
/*
 *mapLoop is a callback function that the SharedDirector calls on a loop
 *on every dt interval. It runs the background animation.
 *@param dt time since last callback
 */
-(void)mapLoop: (ccTime) dt;
/*
 *spawnEnemy spawns a new Enemy sprite, creates an associated Enemy object, 
 *initializes an initial fly in, and then calls
 *a callback to get the animation started
 *@difficulty the difficulty of the enemy
 */
-(void)spawnEnemy:(int)difficulty;
/*
 *enemySpawned is a callback function toggles the enemy's spawning flag and begins the randomized flight
 *@param sender the sprite calling the function
 *@param data the associated enemy object for toggling spawning boolean
 */
-(void)enemySpawned:(id)sender withReference:(void*)data;
/*
 *spawnEnemies spawns n enemies with a specific difficulty
 *@param n how many to spawn
 *@param difficulty the enemies' difficulty level
 */
-(void)spawnEnemies:(int)n withDifficulty:(int)difficulty;
/*
 *flyRandomly is a callback function that calls startspinning and creates
 *and animation for the sender (sprite) based on a random location
 *within bounds and moves it there while shooting a bullet
 *@param sender the Sprite moving
 */
-(void)flyRandomly:(id)sender;
/*
 *spriteDone is a callback function for when a sprite finishes it's movement action in a
 *sequence. The sprite cleans itself up from memory
 */
-(void)spriteDone:(id)sender;

/*
 *startSpinning is a callback function that spins the
 *enemy and fires a bullet. it then calls fly randomly. they call 
 *eachother to create the random movement
 *@param sender the caller of the function
 */
-(void)startSpinning:(id)sender;

/*
 *enemies getter for the array of enemy objects
 *@return array of enemy objects on the screen
 */
-(NSMutableArray*)enemies;

/*
 *enemySprites returns the array of enemy sprites
 *on the screen.
 *@return enemy sprites array
 */
-(NSMutableArray*)enemySprites;

/*
 *removeEnemy remove enemy removes an enemy from the screen
 *and frees its memory
 *@param enemy the enemy to remove
 */
-(void)removeEnemy:(Sprite*)enemy;

/*
 *checkCollisionWithPlayer is called in the map loop and
 *checks to see if an enemy bullet has hit the player. It updates the
 *health accordingly and will game over if necessary
 */
-(void)checkCollisionWithPlayer;
@end
