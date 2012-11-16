//
//  MenuScene.m
//  The purpose of the MenuScene is to control the music so that switching between 
//  the high score layer and the main menu layer doesn't restart the music
//
//  Created by David Henke on 12/2/10.
//  CS242 Final Project
//

#import "MenuScene.h"


@implementation MenuScene

/*
 *init initializes the new MenuScene object with the mainMenu layer and starts the theme music
 *@return the new MenuScene object
 */
-(id)init{
	if ((self = [super init])) {
		mainMenu = [[MainMenu alloc] init];
		[self addChild:mainMenu];
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"main.mp3"];
	}
	return self;
	
}

/*
 *dealloc frees the memory and cleans up the menu layer
 */
-(void)dealloc{
	[self removeChild:mainMenu cleanup:YES];
	[super dealloc];
}
@end
