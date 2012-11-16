//
//  ControlsLayer.m
//  Final-Project-Refactored
//
//  Created by David Henke on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ControlsLayer.h"


@implementation ControlsLayer
	

/*
 *init initializes the new ControlsLayer object and adds all the control sprites
 *and the player's ship
 *@return the new ControlsLayer object
 */
-(id)init{
	if ((self = [super init])) {
		windowSize = [[CCDirector sharedDirector] winSize];
		[self initSlider];
		[self initPlayer];
		[self initWeapons];
		[self initPause];
		self.isTouchEnabled = YES;
		isMoving = NO;
		bullets = [[NSMutableArray alloc] init];
		[self schedule: @selector(gameLoop:)];
	}
	return self;
}

/*
 *dealloc frees up the control layer memor
 */
-(void)dealloc{
	[bullets release];
	[super dealloc];
}

/*
 *initPause creates the pause button sprite and positions it
 *and adds it to the layer
 */
-(void)initPause{
	pause = [Sprite spriteWithFile:@"pauseButton.png"];
	pause.position = ccp(pause.contentSize.width/2,windowSize.height-pause.contentSize.height/2);
	[self addChild:pause];
}

/*
 *initSlider creates the slider and the slider bounds background
 *and adds them to the layer
 */
-(void)initSlider{
	// initialize slider base
	sliderBack = [Sprite spriteWithFile:@"slider_base.png"]; //load the image from the resource file
	sliderBack.position = ccp(sliderBack.contentSize.width/2, sliderBack.contentSize.height/2); // set position
	[self addChild:sliderBack];// add it to the layer (renders)
	
	// initialize direction slider
	slider = [Sprite spriteWithFile:@"slider.png"];
	slider.position = ccp(sliderBack.contentSize.width/2, sliderBack.contentSize.height/2); // set it to the middle
	sliderPos = slider.position;
	[self addChild:slider];
}

/*
 *initWeapons creates the fire button and adds it to the layer
 */
-(void)initWeapons{
	// setup the fire button
	stdFire = [Sprite spriteWithFile:@"button.png"];
	stdFire.position = ccp(windowSize.width-stdFire.contentSize.width/2,stdFire.contentSize.height/2);
	stdFirePos = stdFire.position;
	[self addChild:stdFire];
}

/*
 *initPlayer creates the ship and adds it to the layer
 */
-(void)initPlayer{
	player = [Sprite spriteWithFile:@"player.png"]; //load the image from the resource file
	player.position = ccp(windowSize.width/2, player.contentSize.height*2); // set position
	[self addChild:player]; // add it to the layer(renders)
	//setup the health label
	NSString* scoreText = [NSString	stringWithFormat:@"Health: %d",100];
	hp = [CCLabelTTF labelWithString:scoreText fontName:@"Marker Felt" fontSize:36];
	hp.position = ccp(windowSize.width-300,windowSize.height-hp.contentSize.height);
	[self addChild:hp];
}

/*
 *toggleTouch toggles the layer's touch response
 */
-(void)toggleTouch{
	self.isTouchEnabled = !(self.isTouchEnabled);
}

/*
 *updateHealth updates the health label for the player
 *@param n new health display value
 */
-(void)updateHealth:(int)n{
	[hp setString:[NSString stringWithFormat:@"Health: %d",n]];
}

/*
 *ccTouchesBegan is an override function called when the user begins to touch the screen
 *this function checks which sprite is being touched and calls the appropriate
 *function and sets the appropriate flags
 *@param touches a set of the touches started
 *@param UIEvent is the event passed (what kind of touch)
 */
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
	touchStartPos = location;
	location = [[CCDirector sharedDirector] convertToGL:location];
	// now the touch position is in GL coordinates
	// get the array of sprites we track
    NSArray * sprites = [Sprite sprites];
    NSUInteger i, count = [sprites count];
	// for each sprite, check if it's being touched
    for (i = 0; i < count; i++) {
        Sprite * current = (Sprite *)[sprites objectAtIndex:i];
		CGRect currentBounds = [current rect];
        if (CGRectContainsPoint(currentBounds, location)) {
			// the user is touching the fire button
            if (CGRectContainsPoint(currentBounds, stdFirePos)) {
				[self fireBullet];
				// or the user is touching the slider
			} else if(CGRectContainsPoint(currentBounds, sliderPos)){
				isMoving = YES; //flag that we're moving the ship
			}
			
        }
    }
}

/*
 *ccTouchesMoved is and override function called when the user moves a finger that is touching the screen
 *this function checks if the slider is being moved and moves the ship and slider
 *based on bounds.
 *@param touches a set of the touches started
 *@param UIEvent is the event passed (what kind of touch)
 */
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	// if touches began started at the slider
	if (isMoving) {
		// we've moved off the slider
		if (location.y > slider.position.y + slider.contentSize.height/2){
			isMoving = NO;
		}
		// moving in the right bounds
		if (!(location.x > sliderBack.position.x + sliderBack.contentSize.width/2 - slider.contentSize.width/2) && !(location.x < slider.contentSize.width/2)) {
			// move the ship and the slider with the finger
			player.position = ccp(player.position.x+3.3*(location.x - slider.position.x),player.position.y);
			slider.position = ccp(location.x,slider.position.y);
			sliderPos = slider.position;
		}
		
	}
}

/*
 *ccTouchesEnded is an override function called when the user lifts a finger that is touching the screen
 *this function checks if the pause button was the one pressed, otherwise if the
 *finger was lifted off the slider, the slider is unflagged for moving
 *@param touches a set of the touches started
 *@param UIEvent is the event passed (what kind of touch)
 */
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	CGRect pauseBounds = [pause rect];
	// pressed the pause button
	if (CGRectContainsPoint(pauseBounds, location)) {
		PauseMenu* pauseMenu = [PauseMenu node];
		[self addChild:pauseMenu];
		self.isTouchEnabled = NO;
		// took finger off of the slider
	} else if(!(location.x > sliderBack.position.x + sliderBack.contentSize.width/2 - slider.contentSize.width/2) && !(location.x < slider.contentSize.width/2)){
		isMoving = NO;
	}
	
}
/*
 *fireBullet creates a sprite starting at the ship's position and
 *fires a bullet sprite in the positive Y direction.
 */
-(void)fireBullet{
	// we need to fire many bullets, potentially
	// a new sprite for each fireBullet call
	Sprite* bullet = [Sprite spriteWithFile:@"bullet.png"];
	bullet.position = player.position; // start it from the ship
	[self addChild:bullet]; // show it
	[bullets addObject:bullet];
	// fire it from the ship towards the Y upper bounds
	CGPoint newPosition = ccp(bullet.position.x, bullet.position.y + windowSize.height); // move it all the way up the screen
	float duration = 1; //second // how fast are we firing?
	[[SimpleAudioEngine sharedEngine] playEffect:@"fire.mp3"]; // cool laser sound
	// call the action and flag a selector callback function for when the bullet is out of range
	[bullet runAction:[CCSequence actions:
					   [CCMoveTo actionWithDuration:duration position:newPosition],
					   [CCCallFuncN actionWithTarget:self selector:@selector(spriteDone:)],
					   nil]];
}

/*
 *player returns the player sprite
 */
-(Sprite*)player{
	return player;
}
/*
 *spriteDone is a callback function for when a sprite finishes it's movement action in a
 *sequence. The sprite cleans itself up from memory
 */
-(void)spriteDone:(id)sender {
	// the sender said he's done
	CCSprite *sprite = (CCSprite *)sender;
	// let's free his memory
	[bullets removeObject:sprite];
	[self removeChild:sprite cleanup:YES];
	
}
/*
 *checkCollusionWithEnemy is called in the game loop. it checks
 *collisions for the player's bullets with the enemies in the background
 *layer and handles them
 */
-(void)checkCollisionWithEnemy{
	NSMutableArray *bulletsToDelete = [[NSMutableArray alloc] init];
	// loop through all the bullets on the game map
	BackgroundLayer *background = (BackgroundLayer*)[[self parent] getChildByTag:1];
	GameController* gameController = (GameController*)[self parent];
	NSMutableArray* enemies = [background enemySprites];
	
	for (Sprite *bullet in bullets) {
		// set up bounding box
		CGRect bulletRect = [bullet rect];
		NSMutableArray *enemiesToDelete = [[NSMutableArray alloc] init];
		// enemy bounding boxes
		for (Sprite *enemy in enemies) {
			CGRect enemyRect = [enemy rect];
			// did we hit? oh no!
			if (CGRectIntersectsRect(bulletRect, enemyRect)) {
				[enemiesToDelete addObject:enemy];				
			}						
		}
		// delete the enemies we hit!
		for (Sprite *enemy in enemiesToDelete) {
			int i = [enemies indexOfObject:enemy];
			Enemy* currentModel = [[background enemies] objectAtIndex:i];
			[currentModel subHealth:10];
			Player* currentPlayer = [gameController getPlayer];
			// check if the enemy died
			if ([currentModel isDead]) {
				[enemies removeObject:enemy];
				[background removeEnemy:enemy];
			}
			// add the right amount of score
			[currentPlayer addScore:[currentModel hitScore]];
			//[gameController updateScore:[currentPlayer score]];
		}
		//dont forget bullets disappear when you hit someone
		if (enemiesToDelete.count > 0) {
			[bulletsToDelete addObject:bullet];
		}
		[enemiesToDelete release];
	}
	// get all them bullets out!
	for (Sprite *bullet in bulletsToDelete) {
		[bullets removeObject:bullet];
		[self removeChild:bullet cleanup:YES];
	}
	[bulletsToDelete release];
}

/*
 *gameLoop is a scheduled callback function that checks collisions
 *every dt
 *@param dt time since last call
 */
-(void)gameLoop:(ccTime)dt{
	[self checkCollisionWithEnemy];
}

@end
