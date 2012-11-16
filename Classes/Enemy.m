//
//  Enemy.m
//  Implementation
//  The enemy class subclasses player and adds functions specific for enemies
//
//  Created by David Henke on 12/2/10.
//  CS242 Final Project
//

#import "Enemy.h"


@implementation Enemy

/*
 *init is default constructor for the enemy class. sets up default values
 */
-(id)init{
	if ((self = [super init])) {
		difficulty = 1;
		spawning = YES; //enemy is initially spawning
	}
	return self;
}

/*
 *setDifficulty sets the current difficulty modifier for the enemy
 *@param the new difficulty
 */
-(void)setDifficulty:(int)n{
	if (n > 0 && n <= 5) {
		difficulty = n;
	}
}

/*
 *spawning is a getter for the spawning boolean attribute
 *@return YES if the enemy is spawning, NO if they have spawned
 */
-(BOOL)spawning{
	return spawning;
}

/*
 *toggleSpawning toggles the value of the spawning attribute returned by spawning. Used to prevent initial movement
 *when enemies are spawned.
 */
-(void)toggleSpawning{
	spawning = !spawning;
}

/*
 *difficulty is a getter for the integer difficulty modifier.
 *@return the difficulty level as an integer starting at 1 with a max of 5
 */
-(int)difficulty{
	return difficulty;
}

/*
 *hitScore calculates how many points hitting this enemy at any given moment will allot. Based on
 *the difficulty modifier.
 *@return the integer value of points earned
 */
-(int)hitScore{
	return (difficulty*100);
}

//Override
-(void)saveScore{
	// don't want to be able to do this
	// I overrode this to avoid accidental calls
	return;
}

//Override
-(void)subHealth:(int)n{
	n = n / difficulty; //modify the health removed
	[super subHealth:n];
}

//Override
-(void)subShield:(int)n{
	n = n/ difficulty; //modify the shield removed
	[super subShield:n];
}

/*
 *sprite is a getter for the sprite currently associated with the enemy instance
 *@return the pointer to the sprite object
 */
-(Sprite*)sprite{
	return sprite;
}

/*
 *setSprite sets pointer for the sprite object associated with the enemy instance
 *@param the pointer to the new sprite object
 */
-(void)setSprite:(Sprite*)_sprite{
	sprite = _sprite;
}


@end

