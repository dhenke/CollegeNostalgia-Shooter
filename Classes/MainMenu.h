//
//  MainMenu.h
//  Final-Project
//
//	Main Menu Layer for the Main Menu Scene
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameController.h"
#import "SimpleAudioEngine.h"
#import "ScoreScreen.h"

@interface MainMenu : CCLayer{
	
}


-(id)init;

/*
 *dealloc frees the main menu object from memory
 */
-(void)dealloc;

/*
 *onPlay is a callback function called when the new game menu item is selected
 *@param sender is the object calling the function
 */
-(void)onPlay:(id)sender;

/*
 *onHighScore is a callback function called when the high score menu item is selected
 *@param sender is the object calling the function
 */
-(void)onHighScore:(id)sender;

@end

