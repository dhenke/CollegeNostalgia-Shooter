//
//  BackgroundLayer.m
//  Final-Project-Refactored
//
//  Created by David Henke on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"


@implementation BackgroundLayer

/*
 *init initializes a new BackgroundLayer object and initializes member arrays
 *@return the new BackgroundLayer object
 */
-(id)init{
	if ((self = [super init])) {
		enemies = [[NSMutableArray alloc] init];
		enemySprites = [[NSMutableArray alloc] init];
		enemyBullets = [[NSMutableArray alloc] init];
		windowSize = [[CCDirector sharedDirector] winSize];
		[self schedule:@selector(mapLoop:)];
	}
	return self;
}

/*
 *dealloc frees the memory and member array
 */
-(void)dealloc{
	[enemies release];
	[enemySprites release];
	[enemyBullets release];
	[super dealloc];
}

/*
 *enemies getter for the array of enemy objects
 *@return array of enemy objects on the screen
 */
-(NSMutableArray*)enemies{
	return enemies;
}

/*
 *enemySprites returns the array of enemy sprites
 *on the screen.
 *@return enemy sprites array
 */
-(NSMutableArray*)enemySprites{
	return enemySprites;
}

/*
 *setupLevel takes a levelNumber and switches based on which level is being loaded
 *@param _levelNumber which level is being loaded
 */
-(void)setupLevel:(int)_levelNumber{
	// TEMPORARY!!!!!
	tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"TileMap.tmx"];
	mapOrigin = tileMap.position;
	
	[self addChild:tileMap];
	[self spawnEnemies:8 withDifficulty:1];
}
/*
 *spawnEnemies spawns n enemies with a specific difficulty
 *@param n how many to spawn
 *@param difficulty the enemies' difficulty level
 */
-(void)spawnEnemies:(int)n withDifficulty:(int)difficulty{
	for (int i = 0; i < n; i++) {
		[self spawnEnemy:difficulty];
	}
}
/*
 *mapLoop is a callback function that the SharedDirector calls on a loop
 *on every dt interval. It runs the background animation and checks collisions
 *@param dt time since last callback
 */
-(void)mapLoop:(ccTime)dt{	
	tileMap.position = ccp(tileMap.position.x, (tileMap.position.y)-(dt*400));
	if(tileMap.position.y < -1275){ 
		tileMap.position = mapOrigin;
	}
	[self checkCollisionWithPlayer];
}

/*
 *startSpinning is a callback function that spins the
 *enemy and fires a bullet. it then calls fly randomly. they call 
 *eachother to create the random movement
 *@param sender the caller of the function
 */
-(void)startSpinning:(id)sender{
	Sprite* enemySprite = (Sprite*)sender;
	int randomWise = rand()%2;
	if(randomWise) randomWise = -1;
	else randomWise = 1;
	//1 in 3 chance to start spinning
//	if (arc4random()%3) {
//		[enemySprite runAction:[CCSequence actions:[CCRotateBy actionWithDuration:0.25f angle:randomWise*180],[CCCallFuncN actionWithTarget:self selector:@selector(flyRandomly:)],nil]];
//	} else {
//		[enemySprite runAction:[CCSequence actions:[CCRotateBy actionWithDuration:0.25f angle:randomWise*180],[CCCallFuncN actionWithTarget:self selector:@selector(startSpinning:)],nil]];
//	}	
	
	Sprite* bullet = [Sprite spriteWithFile:@"bullet2.png"];
	bullet.position = enemySprite.position; // start it from the ship
	[self addChild:bullet]; // show it
	// fire it from the ship towards the Y upper bounds
	CGPoint newPosition = ccp(bullet.position.x, bullet.position.y - windowSize.height); // move it all the way down the screen
	float duration = 1; //second // how fast are we firing?
	//[[SimpleAudioEngine sharedEngine] playEffect:@"fire.mp3"]; // cool laser sound
	// call the action and flag a selector callback function for when the bullet is out of range
	[bullet runAction:[CCSequence actions:
					   [CCMoveTo actionWithDuration:duration position:newPosition],
					   [CCCallFuncN actionWithTarget:self selector:@selector(spriteDone:)],
					   nil]];
	[enemyBullets addObject:bullet];
	
	// fun randomized motion


}
/*
 *spriteDone is a callback function for when a sprite finishes it's movement action in a
 *sequence. The sprite cleans itself up from memory
 */
-(void)spriteDone:(id)sender {
	// the sender said he's done
	Sprite *sprite = (Sprite *)sender;
	// let's free his memory
	[enemyBullets removeObject:sprite];
	[self removeChild:sprite cleanup:YES];	
}


/*
 *flyRandomly is a callback function that calls startspinning and creates
 *and animation for the sender (sprite) based on a random location
 *within bounds and moves it there while shooting a bullet
 *@param sender the Sprite moving
 */
-(void)flyRandomly:(id)sender{
	Sprite* enemySprite = (Sprite*)sender;
	int newX = windowSize.width;
	int newY = windowSize.height;
	newY = (arc4random()%newY);
	// set up bounds for random spot
	if (newY < 400)
		newY = 400;
	if (newY > windowSize.height - enemySprite.contentSize.height)
		newY = windowSize.height - enemySprite.contentSize.height;
	if (newX < enemySprite.contentSize.width)
		newY = enemySprite.contentSize.width;
	if (newX > windowSize.width-enemySprite.contentSize.width)
		newX = windowSize.width-enemySprite.contentSize.width;
	newX = (arc4random()%newX);
	CGPoint newPos = ccp(newX,newY);
	CGPoint currentPos = enemySprite.position;
	// duration based on speed
	float speed = 700.0f;
	float distance = sqrt(pow((newY - currentPos.y), 2)+pow((newX - currentPos.x), 2));
	float duration = distance/speed;
	// now spin
	[enemySprite runAction:[CCSequence actions:[CCMoveTo actionWithDuration:duration position:newPos],[CCCallFuncN actionWithTarget:self selector:@selector(startSpinning:)],nil]];
}

/*
 *spawnEnemy spawns a new Enemy sprite, creates an associated Enemy object, 
 *initializes an initial fly in, and then calls
 *a callback to get the animation started
 *@difficulty the difficulty of the enemy
 */
-(void)spawnEnemy:(int)difficulty{
	// create the new Enemy object and sprite
	Enemy* newEnemy = [[Enemy alloc] init];
	Sprite* newEnemySprite = [Sprite spriteWithFile:@"ship.png"];
	[newEnemy setSprite:newEnemySprite];
	[newEnemy setDifficulty:difficulty];
	// choose the approriate side of the screen
	int posMod = [enemies count] % 2;
	int width = newEnemySprite.contentSize.width;
	if (posMod == 1) width*=-1; 
	// spawn them at the top based on which enemy it is
	width = width*([enemies count]%8+1);
	int enemyX = posMod*windowSize.width + width;
	newEnemySprite.position = ccp(enemyX,windowSize.height);
	[self addChild:newEnemySprite];
	// create the new position and move the enemy there
	CGPoint newPos = ccp(newEnemySprite.position.x,newEnemySprite.position.y-200);
	id enter = [CCMoveTo actionWithDuration:2 position:newPos];
	id easeOut = [CCEaseOut	actionWithAction:enter rate:1 ];
	// start the sequence
	id sequence = [CCSequence actions:easeOut,[CCCallFuncND actionWithTarget:self selector:@selector(enemySpawned:withReference:) data:(void*)newEnemy],nil];
	[newEnemySprite runAction:sequence];
	[enemies addObject:newEnemy];
	[enemySprites addObject:newEnemySprite];
}

/*
 *enemySpawned is a callback function toggles the enemy's spawning flag and begins the randomized flight
 *@param sender the sprite calling the function
 *@param data the associated enemy object for toggling spawning boolean
 */
-(void)enemySpawned:(id)sender withReference:(void*)data{
	Enemy* enemy = (Enemy*)data;
	[enemy toggleSpawning];
	Sprite* enemySprite = (Sprite*)sender;
	// enemy has been spawned. start the sequence
	[enemySprite runAction:[CCSequence actions:[CCRotateBy actionWithDuration:1 angle:720],[CCCallFuncN actionWithTarget:self selector:@selector(startSpinning:)],nil]];
}

/*
 *removeEnemy remove enemy removes an enemy from the screen
 *and frees its memory
 *@param enemy the enemy to remove
 */
-(void)removeEnemy:(Sprite*)enemy{
	[self removeChild:enemy cleanup:YES];
}

/*
 *checkCollisionWithPlayer is called in the map loop and
 *checks to see if an enemy bullet has hit the player. It updates the
 *health accordingly and will game over if necessary
 */
-(void)checkCollisionWithPlayer{
	NSMutableArray *bulletsToDelete = [[NSMutableArray alloc] init];
	// loop through all the bullets on the game map
	GameController* gameController = (GameController*)[self parent];
	ControlsLayer* controls = (ControlsLayer*)[gameController getChildByTag:2];
	Sprite* playerSprite = [controls player];
	Player* playerModel = [gameController getPlayer];
	for (Sprite *bullet in enemyBullets) {
		// set up bounding box
		CGRect bulletRect = [bullet rect];
		// enemy bounding boxes
		CGRect playerRect = [playerSprite rect];
		// did we hit? oh no!
		if (CGRectIntersectsRect(bulletRect, playerRect)) {
			//[playerModel subHealth:5.0];
			[controls updateHealth:[playerModel health]];
			if ([playerModel isDead]) {
				[gameController saveScore];
				[[CCDirector sharedDirector] replaceScene:[MainMenu node]];
			}
		}
		
	}
	// get all them bullets out!
	for (Sprite *bullet in bulletsToDelete) {
		[enemyBullets removeObject:bullet];
		[self removeChild:bullet cleanup:YES];
	}
	[bulletsToDelete release];
}


@end
