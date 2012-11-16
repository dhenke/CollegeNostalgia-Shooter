//
//  Player.h
//  Final-Project
//
//	Interface for the Model for Player
//  CS242 henke2

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Scores.h"

#define MAX_HEALTH 100
#define MAX_SHIELD 100
#define MIN_HEALTH 0
#define MIN_SHIELD 0
#define MIN_SPEED 0
#define MAX_SPEED 1000
#define MIN_AMMO 0
#define MAX_AMMO 500

@interface Player : NSObject {
	// member variables for player attributes
	float shield, speed;
	long score;
	long scoreToBeat;
	int ammo,health;
}


/*
 *init initializes an empty player object
 *@return the new player object
 */
-(id)init;

/*
 *dealloc is used to deallocate the Player object. Never call dealloc directly.
 *[playerObject release] calls dealloc if retain count reduces to 0
 */
-(void)dealloc;

/*
 *health is a getter for the health value. ObjC standard naming
 *@return the player's current health
 */
-(int) health;

/*
 *shield is a getter for the current shield value. ObjC standard naming
 *@return the player's current shield value
 */
-(float) shield;

/*
 *speed is a getter for the current speed of the player. ObjC standard naming
 *@return the player's current ship speed
 */
-(float) speed;

/*
 *ammo is a getter for the player's current ammunition count. ObjC standard naming
 *@return the player's current ammunition count
 */
-(int) ammo;

/*
 *score is a getter for the player's score attribute. Objc standard naming
 *@return the player's current score
 */
-(long)score;


/*
 *setHealth is a setter for the player's health attribute.
 *@param health the value to change the health to. must be non-negative and < MAX_HEALTH
 */
-(void)setHealth: (int) health;

/*
 *setShield is a setter for the player's shield attribute.
 *@param shield the value to change the shield to. must be non-negative and < MAX_SHIELD
 */
-(void)setShield: (float) shield;

/*
 *setSpeed is a setter for the player's current ship speed
 *@param spped the new speed value. must be non-negative and < MAX_SPEED
 */
-(void)setSpeed: (float) speed;

/*
 *setAmmo is a setter for the player's current ammunition count.
 *@param ammo the new ammunition value. must be non-negative and < MAX_AMMO
 */
-(void)setAmmo: (int) ammo;

/*
 *isDead calculates the player's current state with respect to the health value and
 *determines if the player has lost (is dead).
 *@return YES if I'm dead, NO if I'm still kicking.
 */
-(bool)isDead;

/*
 *hasAmmo determines if the player has run out of ammunition or not based on the ammo count value
 *@return YES if I've still got bullets, NO if it's looking bleak
 */
-(bool)hasAmmo;

/*
 *hasFullAmmo determines if the player has the maximum amount of ammunition based on the MAX_AMMO value
 *and the ammo parameter.
 *@return YES if I'm maxed out, NO if there's still rounds to be filled
 */
-(bool)hasFullAmmo;

/*
 *hasShield determines if the player still has any shields up based on the shield attribute.
 *@return YES if I'm protected, NO if trouble's afoot
 */
-(bool)hasShield;

/*
 *hasFullShield determines if the player has the maximum amount of shield based on the MAX_SHIELD value
 *and the shield attribute.
 *@return YES if I'm maxed out with protection, NO if I could use some more
 */
-(bool)hasFullShield;

/*
 *hasFullHealth determines if the player has the maxmimum amount of health based ont he MAX_HEALTH value
 *and the health attribute.
 *@return YES if I'm as healthy as can be, NO if more good times could be used
 */
-(bool)hasFullHealth;

/*
 *addHealth adds a health value to the current health attribute. If the new value exceeds MAX_HEALTH then
 *the new health value is MAX_HEALTH.
 *@param n the amount of health to add. must be non-negative
 */
-(void)addHealth:(int) n;

/*
 *addShield adds a shield value to the current shield attribute. If the new value exceeds MAX_SHIELD then
 *the new shield value is MAX_SHIELD.
 *@param n the amount of shield to add. must be non-negative
 */
-(void)addShield:(float) n;

/*
 *addAmmo adds ammunition to the current ammo attribute. If the new value exceeds MAX_AMMO then the new
 *ammo value is MAX_AMMO.
 *@param n the amount of ammo to add. must be non-negative
 */
-(void)addAmmo:(int) n;

/*
 *subHealth removes an amount of health from the current health value based on the health attribute. If the new value
 *is smaller than MIN_HEALTH, we're dead. MIN_HEALTH is the new health value.
 *@param n the amount of health to subtract. must be non-negative
 */
-(void)subHealth:(int) n;

/*
 *subShield removes an amount of shield from the current shield value attribute. If the new value is smaller than
 *MIN_SHIELD, then the shield new shield value is MIN_SHIELD.
 *@param n the value to subtract by. must be non-negative
 */
-(void)subShield:(int) n;

/*
 *subAmmo removes an amount of ammunition, usually a value of 1, from the ammo attribute when a shot is fired.
 *If the new value is smaller than MIN_AMMO (usually 0), we're out of options and ammo = MIN_AMMO.
 *@param n the value to subtracy by. must be non-negative. usually 1 per shot but who knows! multishot?
 */
-(void)subAmmo:(int) n;

/*
 *addScore adds the score n to the player's current score
 *@param n the value to add to the score
 */
-(void)addScore:(long) n;

/*
 *saveScore loads the persistant high scores and saves the current one
 *the Scores class takes care of if the score will be a high score.
 */
-(void)saveScore;

/*
 *hasHighestScore checks if the player has beaten the current highest score
 *and flags as YES
 *@return YES if the player beat the highest score, NO otherwise
 */
-(BOOL)hasHighestScore;

@end