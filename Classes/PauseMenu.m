//
//  PauseMenu.m
//  Final-Project-Refactored
//
//  Created by David Henke on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PauseMenu.h"

@implementation PauseMenu
-(id)init{
	if ((self = [super init])) {
		CCSprite *paused = [CCSprite spriteWithFile:@"pauseMenu.png"];
		paused.position = ccp([[CCDirector sharedDirector] winSize].width/2,[[CCDirector sharedDirector] winSize].height/2);
		[self addChild:paused];
		[self initMenu];
		[[CCDirector sharedDirector] pause];
	}
	return self;
}

-(void)initMenu{
	CCMenuItem *resume = [CCMenuItemFont itemFromString:@"Resume..." target:self selector:@selector(onResume:)];
	CCMenuItem *quit = [CCMenuItemFont itemFromString:@"Quit Game" target:self selector:@selector(onQuit:)];
	CCMenu *pauseMenu = [CCMenu menuWithItems:resume,quit,nil];
	[pauseMenu alignItemsVertically];
	[self addChild:pauseMenu];
}

-(void)onResume:(id)sender{
	[[CCDirector sharedDirector] resume];
	ControlsLayer *parent = [self parent];
	[parent toggleTouch];
	[[self parent] removeChild:self cleanup:YES];
}

-(void)onQuit:(id)sender{
	[[CCDirector sharedDirector] resume];
	[[CCDirector sharedDirector] replaceScene:[MenuScene node]];
	ControlsLayer *parent = [self parent];
	[parent toggleTouch];
	GameController* currentGame = [parent parent];
	[[currentGame parent] removeChild:currentGame cleanup:YES];
	[[[self parent] parent]saveScore];
}

@end
