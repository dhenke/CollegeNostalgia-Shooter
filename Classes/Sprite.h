//
//  Sprite.h
//  Final-Project-Refactored
//
//  Created by David Henke on 11/29/10.
//  Sprite class for touch management adapted from. Subclass of CCSprite
//  http://lethain.com/entry/2008/oct/20/touch-detection-in-cocos2d-iphone/
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Sprite : CCSprite {
	
}

/*
 *init initializes the sprite and tracks it
 *@return the sprite object
 */
-(id)init;

/*
 *dealloc deallocates the memory and untracks the sprite
 *used for release calls
 */
-(void)dealloc;

/*
 *sprites returns the synchronized array of sprites. a synchronized variable 
 *is connected among all objects. sprites is a class function
 *@return array of sprites tracked
 */
+(NSMutableArray *)sprites;

/*
 *track puts the member sprite into the sprites array
 *@return aSprite the sprite to track
 */
+(void)track: (Sprite *)aSprite;

/*
 *untrack removes the sprite from the sprites array
 *@param aSprite is the sprite to remove from the array
 */
+(void)untrack: (Sprite *)aSprite;

/*
 *rect generates the bounding box for the sprite to use for collision
 *@return returns the bounding box of the sprite
 */
-(CGRect)rect;

@end
