//
//  Scores.h
//  Final-Project-Refactored
//
//  Created by David Henke on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Scores.h"


@interface ScoreScreen : CCLayer {
	CGSize windowSize;
	Scores *highScores;
}

/*
 *init initializes the new ScoreScreen object and loads all the scores into labels
 *based on "scores.plist" from the document directory. Uses the Scores class to load scores
 *@return the new ScoreScreen layer object
 */
-(id)init;

/*
 *loadScores initializes the scores object and loads the score values into labels on the
 *layer and adds them individually
 */
-(void)loadScores;
/*
 *onBack is a callback function for the "back to menu" menu item. it replaces the score screen with
 *the Main Menu screen
 *@param sender is the caller of the function
 */
-(void)onBack:(id)sender;


@end
