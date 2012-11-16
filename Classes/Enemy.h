//
//  Enemy.h
//  Interface
//  The enemy class subclasses player and adds functions specific for enemies
//
//  Created by David Henke on 12/2/10.
//  CS242 Final Project
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"
#import "Sprite.h"

@interface Enemy : Player {
	int difficulty; //difficulty modifier
	Sprite *sprite; //sprite associated with enemy
	BOOL spawning; //tells whether the enemy is still spawning
}

/*
 *sprite is a getter for the sprite currently associated with the enemy instance
 *@return the pointer to the sprite object
 */
-(Sprite*)sprite;

/*
 *setSprite sets pointer for the sprite object associated with the enemy instance
 *@param the pointer to the new sprite object
 */
-(void)setSprite:(Sprite*)_sprite;

/*
 *setDifficulty sets the current difficulty modifier for the enemy
 *@param the new difficulty
 */
-(void)setDifficulty:(int)n;

/*
 *toggleSpawning toggles the value of the spawning attribute returned by spawning. Used to prevent initial movement
 *when enemies are spawned.
 */
-(void)toggleSpawning;

/*
 *spawning is a getter for the spawning boolean attribute
 *@return YES if the enemy is spawning, NO if they have spawned
 */
-(BOOL)spawning;

/*
 *hitScore calculates how many points hitting this enemy at any given moment will allot. Based on
 *the difficulty modifier.
 *@return the integer value of points earned
 */
-(int)hitScore;

/*
 *difficulty is a getter for the integer difficulty modifier.
 *@return the difficulty level as an integer starting at 1 with a max of 5
 */
-(int)difficulty;
@end
