//
//  MainMenu.m
//  Final-Project
//
//	Main Menu Layer for the Main Menu Scene

#import "MainMenu.h"


@implementation MainMenu 

/*
 *init initializes the MainMenu layer object and creates a default menu layer
 *@return the new MainMenu object
 */
-(id)init{
	self = [super init];
	if (self != nil){
		CGSize windowSize = [[CCDirector sharedDirector] winSize];
		// populate the menu items and initialize callback functions
		CCMenuItem *newGame = [CCMenuItemFont itemFromString:@"New Game" target:self selector:@selector(onPlay:)];
		CCMenuItem *settings = [CCMenuItemFont itemFromString:@"High Scores" target:self selector:@selector(onHighScore:)];
		// logos and such
		CCSprite *back = [CCSprite spriteWithFile:@"background_menu.png"];
		CCSprite *logo = [CCSprite spriteWithFile:@"logo.png"];
		// make the menu
		CCMenu *menu = [CCMenu menuWithItems:newGame, settings, nil];
		[menu alignItemsVertically];
		back.position = ccp(back.contentSize.width/2, back.contentSize.height/2);
		logo.position = ccp(windowSize.width/2, windowSize.height/2 + menu.contentSize.height/5);
		[self addChild:back];
		[self addChild:logo];
        [self addChild:menu];
		
	}
	return self;
}

/*
 *dealloc frees the main menu object from memory
 */
-(void)dealloc{
	[super dealloc];
}

/*
 *onPlay is a callback function called when the new game menu item is selected
 *@param sender is the object calling the function
 */
- (void)onPlay:(id)sender{
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	// move to the first level
    [[CCDirector sharedDirector] replaceScene:[GameController node]];
}

/*
 *onHighScore is a callback function called when the high score menu item is selected
 *@param sender is the object calling the function
 */
-(void)onHighScore:(id)sender{
	// move to the high score (none at the moment)
	[[CCDirector sharedDirector] replaceScene:[ScoreScreen node]];
}

@end

