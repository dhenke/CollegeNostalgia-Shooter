//
//  PlayerTests.m
//  Final-Project
//
//  Created by David Henke on 11/12/10.
//  CS242 Final Project
//
#import <Foundation/Foundation.h>
#import "Player.h"
#import "PlayerTests.h"



@implementation PlayerTests

/*
 *setUp is called before each test to set the player back to 
 *default values
 */
-(void)setUp{
	testPlayer = [[Player alloc] init];
}

/*
 *testAddHealth tests the addHealth function to make sure
 *that the value cannot exceed fullHealth
 */
-(void)testAddHealth{
	[testPlayer setHealth:50];
	[testPlayer addHealth:900];
	if ([testPlayer hasFullHealth]) {
		NSLog(@"testAddHealth - PASS");
	} else {
		NSLog(@"testAddHealth - FAIL");
	}
}

/*
 *testAddShield tests the addShield function to make sure
 *that the value cannot exceed fullShield
 */
-(void)testAddShield{
	[testPlayer setShield:50];
	[testPlayer addShield:900];
	if ([testPlayer hasFullShield]) {
		NSLog(@"testAddShield - PASS");
	} else {
		NSLog(@"testAddShield - FAIL");
	}
}

/*
 *testAddAmmo tests the addAmmo function to make sure
 *that the value cannot exceed fullAmmo
 */
-(void)testAddAmmo{
	[testPlayer setAmmo:50];
	[testPlayer addAmmo:900];
	if ([testPlayer hasFullAmmo]) {
		NSLog(@"testAddAmmo - PASS");
	} else {
		NSLog(@"testAddAmmo - FAIL");
	}
}

/*
 *testKillPlayer removes the players health and makes sure isDead returns YES
 */
-(void)testKillPlayer{
	[testPlayer setHealth:0];
	if ([testPlayer isDead]) {
		NSLog(@"testKillPlayer - PASS");
	} else {
		NSLog(@"testKillPlayer - FAIL");
	}
	
}

/*
 *testNegativeHealth attempts to call addHealth with a negative value
 */
-(void)testNegativeHealth{
	float current = [testPlayer health];
	[testPlayer addHealth:-100];
	if ((current == [testPlayer health]) && (![testPlayer isDead])) {
		NSLog(@"testNegativeHealth - PASS");
	} else {
		NSLog(@"testNegativeHealth - FAIL");
	}
}

/*
 *testNegativeSpeed attempts to call addSpeed with a negative value
 */
-(void)testNegativeSpeed{
	float current = [testPlayer speed];
	[testPlayer setSpeed:-100];
	if ((current == [testPlayer speed])) {
		NSLog(@"testNegativeSpeed - PASS");
	} else {
		NSLog(@"testNegativeSpeed - FAIL");
	}
}

/*
 *testNegativeShield attempts to call addShield with a negative value
 */
-(void)testNegativeShield{
	float current = [testPlayer shield];
	[testPlayer setShield:-100];
	if ((current == [testPlayer shield])) {
		NSLog(@"testNegativeShield - PASS");
	} else {
		NSLog(@"testNegativeShield - FAIL");
	}
}

/*
 *testSubHealth tests the subHealth function to make sure health doesn't go below
 *MIN_HEALTH
 */
-(void)testSubHealth{
	[testPlayer subHealth:200];
	if ([testPlayer health] == MIN_HEALTH) {
		NSLog(@"testSubHealth - PASS");
	} else {
		NSLog(@"testSubHealth - FAIL");
	}
}

/*
 *testSubShield tests the subShield function to make sure shield doesn't go below
 *MIN_SHIELD
 */
-(void)testSubShield{
	[testPlayer subShield:200];
	float shield = [testPlayer shield];
	float minShield = MIN_SHIELD;
	if (shield == minShield){
		NSLog(@"testSubShield - PASS");
	} else {
		NSLog(@"testSubShield - FAIL");
	}
}

/*
 *testSubAmmo tests the subAmmo function to make sure ammo doesn't go below
 *MIN_AMMO
 */
-(void)testSubAmmo{
	[testPlayer subAmmo:5000];
	if ([testPlayer ammo] == MIN_AMMO) {
		NSLog(@"testSubAmmo - PASS");
	} else {
		NSLog(@"testSubAmmo - FAIL");
	}
}

/*
 *tearDown clears the memory after every test
 */
-(void)tearDown{
	[testPlayer release];
}

/*
 *init initializes the memory for the test
 *@return the test object
 */
-(id)init{
	self = [super init];
	return self;
}

/*
 *dealloc clears the memory
 */
-(void)dealloc{
	[super dealloc];
}

/*
 *runTest runs the test based on the parameter. sets up and tears down before each test
 *@param n the number of the test to run
 */
-(void)runTest:(int)n{
	[self setUp];
	switch (n) {
		case 0:
			[self testAddHealth];
			break;
		case 1:
			[self testAddShield];
			break;
		case 2:
			[self testKillPlayer];
			break;
		case 3:
			[self testAddAmmo];
			break;
		case 4:
			[self testNegativeHealth];
			break;
		case 5:
			[self testNegativeSpeed];
			break;
		case 6:
			[self testNegativeShield];
			break;
		case 7:
			[self testSubHealth];
			break;
		case 8:
			[self testSubShield];
			break;
		case 9:
			[self testSubAmmo];
			break;
		default:
			break;
	}
	[self tearDown];
}

@end
