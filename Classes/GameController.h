	//
//  GameScene.h
//  Final-Project-Refactored
//
//  Created by David Henke on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ControlsLayer.h"
#import "BackgroundLayer.h"
#import "Sprite.h"
#import "SimpleAudioEngine.h"
#import "Player.h"

@interface GameController : CCScene {
	Player* player; //the player model for this game
	CCLabelTTF* score; // a label to keep the score throughout each level
	CGSize windowSize; // the size of the device window
}
/*
 *init initializes the memory for the GameController and sets the
 *different layers for the first level. It initializes the score and
 *starts the music. It also initializes the player model.
 *@return the GameController object
 */
-(id)init;
/*
 *updateScore updates the score sprite with the proper score
 *based on the player's new score.
 */
-(void)updateScore;
/*
 *getPlayer gets the current player object
 *@return pointer to the current player
 */
-(Player*)getPlayer;
/*
 *saveScore saves the current score to the score file
 */
-(void)saveScore;
@end
