//
//  ScoreTests.h
//  Final-Project-Refactored
//
//  Created by David Henke on 11/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scores.h"
#define NUM_SCORE_TESTS 4

@interface ScoreTests : NSObject{
	Scores* testScores;
	NSString* filename;
}

/*
 *setUp sets up the scores object before each test and specifies the filename
 */
-(void)setUp;

/*
 *tearDown frees the memory after every test
 */
-(void)tearDown;

/*
 *testSaveAndLoadScore tests the file saving by saving a new score array and then
 *loading it again to get the value.
 */
-(void)testSaveAndLoadScore;

/*
 *testOrganizeScores adds scores in an arbitrary order and then tests to see if
 *they were organized in descending order
 */
-(void)testOrganizeScores;

/*
 *testOverwriteScores adds 10 scores to the array and then one more score. The scores class should put that new
 *score at the top and remove the 11th entry
 */
-(void)testOverwriteScores;

/*
 *testComprehensive tests difference calls to the Score class. It adds default scores in ascending order, then
 *adds scores that should be sorted between the current values. It also checks the entire ordering for descending order
 */
-(void)testComprehensive;

-(id)init;
-(void)dealloc;
-(void)runTest:(int)n;

@end
