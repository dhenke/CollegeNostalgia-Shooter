//
//  ScoreTests.m
//  Final-Project-Refactored
//
//  Created by David Henke on 11/30/10.
//

#import "ScoreTests.h"


@implementation ScoreTests

/*
 *setUp sets up the scores object before each test and specifies the filename
 */
-(void)setUp{
	testScores = [[Scores alloc] init];
	filename = [[NSString alloc] initWithString:@"testfile.plist"];
}

/*
 *tearDown frees the memory after every test
 */
-(void)tearDown{
	[testScores release];
	[[NSFileManager defaultManager] removeItemAtPath:[testScores dataFilePath:filename] error:nil];
	[filename release];
}

/*
 *testSaveAndLoadScore tests the file saving by saving a new score array and then
 *loading it again to get the value.
 */
-(void)testSaveAndLoadScore{
	// add a score and save it
	NSNumber* scoreToAdd = [NSNumber numberWithInt:100];
	[testScores addScore:scoreToAdd];
	[testScores saveScores:filename];
	//load it back up
	NSArray *scores = [testScores loadScores:filename];
	if ([[scores objectAtIndex:0] intValue] == [scoreToAdd intValue]) {
		NSLog(@"testSaveScore - PASS");
	} else {
		NSLog(@"testSaveScore - FAIL");
	}
	
}

/*
 *testOrganizeScores adds scores in an arbitrary order and then tests to see if
 *they were organized in descending order
 */
-(void)testOrganizeScores{
	[testScores addScore:[NSNumber numberWithInt: 100]];
	[testScores addScore:[NSNumber numberWithInt: 400]];
	[testScores addScore:[NSNumber numberWithInt: 200]];
	[testScores addScore:[NSNumber numberWithInt: 1000]];
	[testScores saveScores:filename];
	
	NSArray *scores = [testScores loadScores:filename];
	// check the array spots
	if (([[scores objectAtIndex:0] intValue] == 1000) && ([[scores objectAtIndex:1] intValue] == 400) 
		&& ([[scores objectAtIndex:2] intValue] ==  200) && ([[scores objectAtIndex:3] intValue] ==100)) {
		NSLog(@"testOrganizeScores - PASS");
	} else {
		NSLog(@"testOrganizeScores - FAIL");
	}
	
}

/*
 *testOverwriteScores adds 10 scores to the array and then one more score. The scores class should put that new
 *score at the top and remove the 11th entry
 */
-(void)testOverwriteScores{
	for (int i = 1; i < 11; i++) {
		[testScores addScore:[NSNumber numberWithInt: i*100]];
	}
	[testScores addScore:[NSNumber numberWithInt:9000]];
	[testScores saveScores:filename];
	NSArray* scores = [testScores loadScores:filename];
	int highest = [[scores objectAtIndex:0] intValue];
	int lowest = [[scores objectAtIndex:9] intValue];
	// should have 9000 in the first position, 200 in the last, and have 10 elements
	if ((highest == 9000) && (lowest == 200) && ([scores count] == 10)) {
		NSLog(@"testOverwriteScores - PASS");
	} else {
		NSLog(@"testOverwriteScores - FAIL");
	}
	
}

/*
 *testComprehensive tests difference calls to the Score class. It adds default scores in ascending order, then
 *adds scores that should be sorted between the current values. It also checks the entire ordering for descending order
 */
-(void)testComprehensive{
	// put in values in ascending order
	for (int i = 1; i < 11; i++) {
		[testScores addScore:[NSNumber numberWithInt:i*100]];
	}
	[testScores saveScores:filename];
	NSArray *scores = [testScores loadScores:filename];
	BOOL pass = YES;
	//load them back, make sure they're in descending order now
	for (int i = 0; i < 10; i++) {
		if([[scores objectAtIndex:i] intValue] != (10-i)*100){
			pass = NO;
		}
	}
	// put in a new high score
	// and also a score that would go in between
	[testScores addScore:[NSNumber numberWithInt:5000]];
	[testScores addScore:[NSNumber numberWithInt:950]];
	[testScores saveScores:filename];
	scores = [testScores loadScores:filename];
	// are the scores organized properly?
	if (([[scores objectAtIndex:0] intValue] != 5000) && ([[scores objectAtIndex:2] intValue] != 950)){
		pass = NO;
	}
	if (pass) {
		NSLog(@"testComprehensive - PASS");
	} else {
		NSLog(@"testComprehensive - FAIL");
	}
	
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
			[self testSaveAndLoadScore];
			break;
		case 1:
			[self testOrganizeScores];
			break;
		case 2:
			[self testOverwriteScores];
			break;
		case 3:
			[self testComprehensive];
			break;
			
		default:
			break;
	}
	[self tearDown];
}



@end
