//
//  GameScene.m
//  Final-Project-Refactored
//
//  Created by David Henke on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameController.h"


@implementation GameController

/*
 *init initializes the memory for the GameController and sets the
 *different layers for the first level. It initializes the score and
 *starts the music. It also initializes the player model.
 *@return the GameController object
 */
-(id)init{
	if ((self = [super init])) {
		BackgroundLayer *backgroundLayer = [BackgroundLayer node];
		[backgroundLayer setupLevel:0];
		ControlsLayer *controlsLayer = [ControlsLayer node];
		// add layers as a children of the scene
		// use tags so that other layers can look up the children
		[self addChild:backgroundLayer z:0 tag:1];
		[self addChild:controlsLayer z:1 tag:2];
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"level1.mp3"];
		player = [[Player alloc] init];
		// create score label for updating 
		score = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %d",[player score]] fontName:@"Marker Felt" fontSize:36];
		windowSize = [[CCDirector sharedDirector] winSize];
		score.position = ccp(windowSize.width-150,windowSize.height-score.contentSize.height);
		[self addChild:score z:3 tag:3];
	}
	return self;
} 

/*
 *updateScore updates the score sprite with the proper score
 *based on the player's new score.
 */
-(void)updateScore{
	[score setString:[NSString stringWithFormat:@"Score: %d",[player score]]];
}

/*
 *getPlayer gets the current player object
 *@return pointer to the current player
 */
-(Player*)getPlayer{
	return player;
}

/*
 *saveScore saves the current score to the score file
 */
-(void)saveScore{
	[player saveScore];
}


@end