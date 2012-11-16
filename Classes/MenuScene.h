//
//  MenuScene.h
//  The purpose of the MenuScene is to control the music so that switching between 
//  the high score layer and the main menu layer doesn't restart the music
//
//  Created by David Henke on 12/2/10.
//  CS242 Final Project
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
@class MainMenu;
@interface MenuScene : CCScene {
	MainMenu* mainMenu;
}

/*
 *init initializes the new MenuScene object with the mainMenu layer and starts the theme music
 *@return the new MenuScene object
 */
-(id)init;
/*
 *dealloc frees the memory and cleans up the menu layer
 */
-(void)dealloc;
@end
