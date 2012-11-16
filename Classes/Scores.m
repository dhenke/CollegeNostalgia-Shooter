//
//  Score.m
//  Implementation for scoring class. Persistant scoring data
//
//  Created by David Henke on 11/30/10.
//  CS242 Final Project
//

#import "Scores.h"


@implementation Scores

/*
 *compareScores is a comparotor function for NSNumber score values
 *@param obj1 first number
 *@param obj2 second number
 *@return a macro comparison result for use by sorter
 */
static NSComparisonResult compareScores(id obj1, id obj2, void* context) {
	int value1 = [obj1 intValue], value2 = [obj2 intValue];
	// returns the correct macro based on the ordering
	if (value1 < value2) return NSOrderedDescending;
	if (value1 > value2) return NSOrderedAscending;
	return NSOrderedSame;
}

/*
 *dataFilePath is a helper function to determine the file path for the
 *filename. The file paths on the iOS are based on the app directory and
 *documents folder
 *@return the string with the filepath
 */
-(NSString *)dataFilePath:(NSString*) filename{
	// Objective C object for file directories
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	// usually a hack, but the first object will be the correct path
	NSString *documentsDirectory = [paths objectAtIndex:0];
	// append the filename and return
	return [documentsDirectory stringByAppendingPathComponent:filename];
}

/*
 *loadScores loads the array of NSNumbers into the member variable from filename
 *@param filename is the filename of the scores file. if it doesn't exist, a default set is arranged
 *@return the array of scores
 */
-(NSArray*)loadScores:(NSString*)filename{
	// loads the scores into the array member variable
	// from the filename plist file
	NSString *filePath = [self dataFilePath:filename];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		// load the file scores
		scores = [[NSArray alloc] initWithContentsOfFile:filePath];
	} else {
		// the file doesn't exist so fill it with some default values
		for (int i = 1; i < 11; i++) {
			[self addScore:[NSNumber numberWithLong:i*100l]];
		}
		// save the default scores for next time
		[self saveScores:filename];
	}
	return scores;
}


/*
 *saveScores saves the scores array to the file specified
 *@param the filename to save to
 */
-(void)saveScores:(NSString*)filename{
	[scores writeToFile:[self dataFilePath:filename] atomically:YES];
}

/*
 *addScore adds a score to the scores array. The function appropriately
 *organizes the scores in decending order and limits scores to 10 entries
 *@param score is the score to be added
 */
-(void)addScore:(NSNumber*)score{
	[scores addObject:score];
	// more than one score in the array, so organize it
	if ([scores count] > 1) {
		[scores sortUsingFunction:compareScores context:NULL];
	}
	// after the scores are organized, remove the last one
	// maximum of 10 scores
	if ([scores count] == 11) {
		[scores removeLastObject];
	}
}

/*
 *init initializes the scores object with default values
 *@return the scores object
 */
-(id)init{
	scores = [[NSMutableArray alloc] init]; 
	self = [super init];
	return self;
}

/*
 *dealloc cleans up the memory and the object when release is called 
 */
-(void)dealloc{
	[scores release];
	[super dealloc];
}

@end
