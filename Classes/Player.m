//
//  Player.m
//  Final-Project
//
// 
//  Created by David Henke on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player



/*
 *init initializes an empty player object
 *@return the new player object
 */
-(id)init{
	if ((self = [super init])) { // make sure the memory allocation didn't go awry
		// give me all the health, all the ammo, and none of the shields
		// you have to earn those as you go
		[self setHealth:MAX_HEALTH];
		[self setSpeed:MIN_SPEED];
		[self setAmmo:MAX_AMMO];
		[self setShield:MIN_SHIELD];
		score = 0l;
		// set up the highest score so far for the hasHighestScore function
		if ([self class] == [Player class]) {
			// load the current high scores
			Scores *oldScores = [[Scores alloc] init];
			NSArray* scoreList = [oldScores loadScores:@"scores.plist"];
			// if there are scores
			if (scoreList != nil && ([scoreList count] > 0)) {
				scoreToBeat = [[scoreList objectAtIndex:0] longValue];
			}
			// otherwise the score to beat is 0
			else {
				scoreToBeat = 0;
			}
			[oldScores release]; // free mem
		}
		
		
	}
	return self;
}

/*
 *dealloc is used to deallocate the Player object. Never call dealloc directly.
 *[playerObject release] calls dealloc if retain count reduces to 0
 */
-(void)dealloc{
	[super dealloc]; 
}


/*
 *hasHighestScore checks if the player has beaten the current highest score
 *and flags as YES
 *@return YES if the player beat the highest score, NO otherwise
 */
-(BOOL)hasHighestScore{
	// the player's current score is the best
	if (score > scoreToBeat) {
		return YES;
	}
	return NO;
}

/*
 *health is a getter for the health value. ObjC standard naming
 *@return the player's current health
 */
-(int)health{
	return health;
}

/*
 *shield is a getter for the current shield value. ObjC standard naming
 *@return the player's current shield value
 */
-(float)shield{
	return shield;
}

/*
 *ammo is a getter for the player's current ammunition count. ObjC standard naming
 *@return the player's current ammunition count
 */
-(int)ammo{
	return ammo;
}

/*
 *speed is a getter for the current speed of the player. ObjC standard naming
 *@return the player's current ship speed
 */
-(float)speed{
	return speed;
}

/*
 *score is a getter for the player's score attribute. Objc standard naming
 *@return the player's current score
 */
-(long)score{
	return score;
}

-(void)addScore:(long)n{
	// adjust the score based on how much health the
	// player has. 
	if(n > 0) score+=(n-(MAX_HEALTH - health));
}

/*
 *setHealth is a setter for the player's health attribute.
 *@param health the value to change the health to. must be non-negative and < MAX_HEALTH
 */
-(void)setHealth:(int)_health{
	// make sure we're not in negative health or over max health
	if (_health >= MIN_HEALTH && _health <= MAX_HEALTH) {
		health = _health;
	}
}

/*
 *setShield is a setter for the player's shield attribute.
 *@param shield the value to change the shield to. must be non-negative and < MAX_SHIELD
 */
-(void)setShield:(float)_shield{
	// sanity checks
	if (_shield >= MIN_SHIELD && _shield <= MAX_SHIELD) {
		shield = _shield;
	}
}

/*
 *setSpeed is a setter for the player's current ship speed
 *@param spped the new speed value. must be non-negative and < MAX_SPEED
 */
-(void)setSpeed:(float)_speed{
	// sanity checks
	if(_speed >= MIN_SPEED && _speed <= MAX_SPEED){
		speed = _speed;
	}
}

/*
 *setAmmo is a setter for the player's current ammunition count.
 *@param ammo the new ammunition value. must be non-negative and < MAX_AMMO
 */
-(void)setAmmo:(int)_ammo{
	// sanity check
	if(_ammo >= MIN_AMMO && _ammo <= MAX_AMMO){
		ammo = _ammo;
	}
}

/*
 *isDead calculates the player's current state with respect to the health value and
 *determines if the player has lost (is dead).
 *@return YES if dead, NO otherwise
 */
-(bool)isDead{
	// if none is left, player is dead
	if(health <= MIN_HEALTH) return YES;
	else return NO; 
}

/*
 *hasAmmo determines if the player has run out of ammunition or not based on the ammo count value
 *@return YES if player still has bullets, NO otherwise
 */
-(bool)hasAmmo{
	if(ammo < MIN_AMMO) return NO;
	else return YES; 
}

/*
 *hasFullAmmo determines if the player has the maximum amount of ammunition based on the MAX_AMMO value
 *and the ammo parameter.
 *@return YES if player has maximum ammo, NO otherwise
 */
-(bool)hasFullAmmo{
	if(ammo == MAX_AMMO) return YES; 
	else return NO;
}

/*
 *hasShield determines if the player still has any shields up based on the shield attribute.
 *@return YES if player has shields left, NO otherwise
 */
-(bool)hasShield{
	if(shield < MIN_SHIELD) return NO; 
	else return YES; 
}

/*
 *hasFullShield determines if the player has the maximum amount of shield based on the MAX_SHIELD value
 *and the shield attribute.
 *@return YES if player has maximum shields, NO otherwise
 */
-(bool)hasFullShield{
	if(shield == MAX_SHIELD) return YES; 
	else return NO;
}

/*
 *hasFullHealth determines if the player has the maxmimum amount of health based on the MAX_HEALTH value
 *and the health attribute.
 *@return YES player has full health, NO otherwise
 */
-(bool)hasFullHealth{
	if(health == MAX_HEALTH) return YES;
	else return NO;
}

/*
 *addHealth adds a health value to the current health attribute. If the new value exceeds MAX_HEALTH then
 *the new health value is MAX_HEALTH.
 *@param n the amount of health to add. must be non-negative
 */
-(void)addHealth:(int)n{
	// cant be negative
	if (n <= 0 || [self isDead]) {
		return;
	} else {
		health+=n;
	}
	if (health > MAX_HEALTH) {
		health = MAX_HEALTH; // gone past max, so default
	}
}

/*
 *addShield adds a shield value to the current shield attribute. If the new value exceeds MAX_SHIELD then
 *the new shield value is MAX_SHIELD.
 *@param n the amount of shield to add. must be non-negative
 */
-(void)addShield:(float)n{
	// cant be negative
	if (n <= 0 || [self isDead]) {
		return;
	} else {
		shield+=n;
	}
	if (shield > MAX_SHIELD) {
		shield = MAX_SHIELD; // gone past max, so default
	}
}

/*
 *addAmmo adds ammunition to the current ammo attribute. If the new value exceeds MAX_AMMO then the new
 *ammo value is MAX_AMMO.
 *@param n the amount of ammo to add. must be non-negative
 */
-(void)addAmmo:(int)n{
	// cant be negative
	if (n <= 0 || [self isDead]) {
		return;
	} else {
		ammo+=n;
	}
	if (ammo > MAX_AMMO) {
		ammo = MAX_AMMO; // gone past max, so default
	}
}

/*
 *subAmmo removes an amount of ammunition, usually a value of 1, from the ammo attribute when a shot is fired.
 *If the new value is smaller than MIN_AMMO (usually 0), we're out of options and ammo = MIN_AMMO.
 *@param n the value to subtracted by. must be non-negative.
 */
-(void)subAmmo:(int)n{
	// cant be negative
	if(n <=0){
		return;
	} else {
		ammo -=n;
	}
	if (ammo < MIN_AMMO) {
		ammo = MIN_AMMO; // out of ammunition
	}
}

/*
 *subHealth removes an amount of health from the current health value based on the health attribute. If the new value
 *is smaller than MIN_HEALTH, we're dead. MIN_HEALTH is the new health value.
 *@param n the amount of health to subtract. must be non-negative
 */
-(void)subHealth:(int)n{
	if (n <= 0) {
		return;
	} else {
		health -= n;
	} 
	if (health < MIN_HEALTH) {
		health = MIN_HEALTH; // calling isDead should return a YES now
	}
}

/*
 *subShield removes an amount of shield from the current shield value attribute. If the new value is smaller than
 *MIN_SHIELD, then the shield new shield value is MIN_SHIELD.
 *@param n the value to subtract by. must be non-negative
 */
-(void)subShield:(int)n{
	if (n <= 0) {
		return;
	} else {
		shield -= n;
	}
	if (shield < MIN_SHIELD) {
		shield = MIN_SHIELD; //shield past minimum, so default
	}
}

/*
 *saveScore loads the persistant high scores and saves the current one
 *the Scores class takes care of if the score will be a high score.
 */
-(void)saveScore{
	// load the scores
	Scores* scores = [[Scores alloc] init];
	[scores loadScores:@"scores.plist"];
	// Scores class will take care of organization
	[scores addScore:[NSNumber numberWithLong:score]]; 
	// save to file
	[scores saveScores:@"scores.plist"];
	[scores release];
}


@end
