//
//  Scores.m
//  Final-Project-Refactored
//
//  Created by David Henke on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ScoreScreen.h"
#import "MainMenu.h"

@implementation ScoreScreen

/*
 *init initializes the new ScoreScreen object and loads all the scores into labels
 *based on "scores.plist" from the document directory. Uses the Scores class to load scores
 *@return the new ScoreScreen layer object
 */
-(id)init{
	if ((self = [super init])) {
		// high score label
		CCLabelTTF* title = [CCLabelTTF labelWithString:@"High Scores" fontName:@"Marker Felt" fontSize:48];
		windowSize = [[CCDirector sharedDirector] winSize];
		title.position = ccp(windowSize.width/2,windowSize.height-100);
		// background picture
		CCSprite* background = [CCSprite spriteWithFile:@"space.jpg"];
		background.position = ccp(background.contentSize.width/2, background.contentSize.height/2);
		[self addChild:background];
		[self addChild:title];
		[self loadScores];
		// create a back button menu item and menu and set the callback function
		CCMenuItem* backButton = [CCMenuItemFont itemFromString:@"Back to Menu" target:self selector:@selector(onBack:)];
		CCMenu* backMenuLayer = [CCMenu menuWithItems:backButton, nil];
		[backMenuLayer alignItemsVertically];
		backMenuLayer.position = ccp(windowSize.width-windowSize.width/8,windowSize.height/10);
		[self addChild:backMenuLayer]; // add the menu for going back
	}
	return self;
}

/*
 *loadScores initializes the scores object and loads the score values into labels on the
 *layer and adds them individually
 */
-(void)loadScores{
	highScores = [[Scores alloc] init];
	NSArray* scores = [highScores loadScores:@"scores.plist"];
	for (int i = 0; i < [scores count]; i++) {
		// load each score value into a string
		NSNumber* scoreValue = [NSNumber numberWithLong:[[scores objectAtIndex:i] longValue]];
		// rank the scores and put in the value
		NSString* scoreString = [NSString stringWithFormat:@"%d. %d",i+1, [scoreValue longValue]];
		CCLabelTTF* scoreLabel = [CCLabelTTF labelWithString:scoreString fontName:@"Marker Felt" fontSize:28];
		// position based on i
		scoreLabel.position = ccp(windowSize.width/2, windowSize.height-150-50*(i+1));
		[self addChild:scoreLabel];
	}
}

/*
 *onBack is a callback function for the "back to menu" menu item. it replaces the score screen with
 *the Main Menu screen
 *@param sender is the caller of the function
 */
-(void)onBack:(id)sender{
	// move to the high score (none at the moment)
	[[CCDirector sharedDirector] replaceScene:[MainMenu node]];
}

@end
