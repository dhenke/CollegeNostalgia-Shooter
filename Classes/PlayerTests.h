//
//  PlayerTests.h
//  Final-Project
//
//  Created by David Henke on 11/12/10.
//  CS242 Final Project
//

#import <UIKit/UIKit.h>
#import "Player.h"

#define NUM_PLAYER_TESTS 10

@interface PlayerTests : NSObject {
	Player *testPlayer;
}


/*
 *init initializes the memory for the test
 *@return the test object
 */
-(id)init;

/*
 *dealloc clears the memory
 */
-(void)dealloc;

/*
 *setUp is called before each test to set the player back to 
 *default values
 */
-(void)setUp;

/*
 *testAddHealth tests the addHealth function to make sure
 *that the value cannot exceed fullHealth
 */
-(void)testAddHealth;

/*
 *testAddShield tests the addShield function to make sure
 *that the value cannot exceed fullShield
 */
-(void)testAddShield;

/*
 *testAddAmmo tests the addAmmo function to make sure
 *that the value cannot exceed fullAmmo
 */
-(void)testAddAmmo;

/*
 *testKillPlayer removes the players health and makes sure isDead returns YES
 */
-(void)testKillPlayer;

/*
 *testNegativeHealth attempts to call addHealth with a negative value
 */
-(void)testNegativeHealth;

/*
 *testNegativeSpeed attempts to call addSpeed with a negative value
 */
-(void)testNegativeSpeed;

/*
 *testNegativeShield attempts to call addShield with a negative value
 */
-(void)testNegativeShield;

/*
 *tearDown clears the memory after every test
 */
-(void)tearDown;

/*
 *runTest runs the test based on the parameter. sets up and tears down before each test
 *@param n the number of the test to run
 */
-(void)runTest:(int)n;

/*
 *testSubHealth tests the subHealth function to make sure health doesn't go below
 *MIN_HEALTH
 */
-(void)testSubHealth;

/*
 *testSubShield tests the subShield function to make sure shield doesn't go below
 *MIN_SHIELD
 */
-(void)testSubShield;

/*
 *testSubAmmo tests the subAmmo function to make sure ammo doesn't go below
 *MIN_AMMO
 */
-(void)testSubAmmo;


@end

