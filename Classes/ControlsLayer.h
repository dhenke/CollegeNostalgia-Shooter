//
//  ControlsLayer.h
//  Final-Project-Refactored
//
//  Created by David Henke on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Sprite.h"
#import "PauseMenu.h"
#import "GameController.h"
#import "Player.h"

@interface ControlsLayer : CCLayer {
	// sprites on this layer
	// controls for movement and weapons
	Sprite *slider, *sliderBack, *stdFire, *player, *pause;
	CGSize windowSize;
	CGPoint stdFirePos, sliderPos, touchStartPos;
	Boolean isMoving;
	NSMutableArray* bullets;
	CCLabelTTF* hp;
}

/*
 *init initializes the new ControlsLayer object and adds all the control sprites
 *and the player's ship
 *@return the new ControlsLayer object
 */
-(id)init;

/*
 *gameLoop is a scheduled callback function that checks collisions
 *every dt
 *@param dt time since last call
 */
-(void)gameLoop:(ccTime)dt;

/*
 *dealloc frees up the control layer memor
 */
-(void)dealloc;

/*
 *initSlider creates the slider and the slider bounds background
 *and adds them to the layer
 */
-(void)initSlider;
/*
 *initWeapons creates the fire button and adds it to the layer
 */
-(void)initWeapons;
/*
 *initPlayer creates the ship and adds it to the layer
 */
-(void)initPlayer;
/*
 *initPause creates the pause button sprite and positions it
 *and adds it to the layer
 */
-(void)initPause;
/*
 *toggleTouch toggles the layer's touch response
 */
-(void)toggleTouch;

/*
 *checkCollusionWithEnemy is called in the game loop. it checks
 *collisions for the player's bullets with the enemies in the background
 *layer and handles them
 */
-(void)checkCollisionWithEnemy;
/*
 *fireBullet creates a sprite starting at the ship's position and
 *fires a bullet sprite in the positive Y direction.
 */
-(void)fireBullet;

/*
 *spriteDone is a callback function for when a sprite finishes it's movement action in a
 *sequence. The sprite cleans itself up from memory
 */
-(void)spriteDone:(id)sender;

/*
 *player returns the player sprite
 */
-(Sprite*)player;

/*
 *updateHealth updates the health label for the player
 *@param n new health display value
 */
-(void)updateHealth:(int)n;
@end
