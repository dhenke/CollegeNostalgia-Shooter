//
//  Sprite.m
//  Final-Project-Refactored
//
//  Sprite class for touch management adapted from. Subclass of CCSprite
//  http://lethain.com/entry/2008/oct/20/touch-detection-in-cocos2d-iphone/
//

#import "Sprite.h"


@implementation Sprite

static NSMutableArray * sprites = nil;

/*
 *sprites returns the synchronized array of sprites. a synchronized variable 
 *is connected among all objects. sprites is a class function
 *@return array of sprites tracked
 */
+(NSMutableArray *)sprites {
	// synchronize the sprites array accross all class instances
    @synchronized(sprites) {
		// returns the array of sprites
        if (sprites == nil)
            sprites = [[NSMutableArray alloc] init];
        return sprites;
    }
	return nil;
}

/*
 *track puts the member sprite into the sprites array
 *@return aSprite the sprite to track
 */
+(void)track: (Sprite *)aSprite {
    @synchronized(sprites) {
        [[Sprite sprites] addObject:aSprite];
    }
}

/*
 *untrack removes the sprite from the sprites array
 *@param aSprite is the sprite to remove from the array
 */
+(void)untrack: (Sprite *)aSprite {
    @synchronized(sprites) {
        [[Sprite sprites] removeObject:aSprite];
    }
}

/*
 *init initializes the sprite and tracks it
 *@return the sprite object
 */
-(id)init {
    self = [super init];
    if (self) [Sprite track:self];
    return self;
}

/*
 *dealloc deallocates the memory and untracks the sprite
 *used for release calls
 */
-(void)dealloc {
    [Sprite untrack:self];
    [super dealloc];
}

/*
 *rect generates the bounding box for the sprite to use for collision
 *@return returns the bounding box of the sprite
 */
-(CGRect)rect{
	// generate the rectangle
	return CGRectMake(
					  self.position.x - (self.contentSize.width/2), 
					  self.position.y - (self.contentSize.height/2), 
					  self.contentSize.width, 
					  self.contentSize.height);
}
@end
