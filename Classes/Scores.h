//
//  Score.h
//  Interface for scoring class. Persistant scoring data
//
//  Created by David Henke on 11/30/10.
//  CS242 Final Project
//

#import <Foundation/Foundation.h> 

@interface Scores : NSObject {
	NSMutableArray* scores; // array of NSNumbers filled with scores
}

/*
 *dataFilePath is a helper function to determine the file path for the
 *filename. The file paths on the iOS are based on the app directory and
 *documents folder
 *@return the string with the filepath
 */
-(NSString *)dataFilePath:(NSString*) filename;

/*
 *loadScores loads the array of NSNumbers into the member variable from filename
 *@param filename is the filename of the scores file. if it doesn't exist, a default set is arranged
 *@return the array of scores
 */
-(NSArray*)loadScores:(NSString*)filename;

/*
 *saveScores saves the scores array to the file specified
 *@param the filename to save to
 */
-(void)saveScores:(NSString*)filename;

/*
 *addScore adds a score to the scores array. The function appropriately
 *organizes the scores in decending order and limits scores to 10 entries
 *@param score is the score to be added
 */
-(void)addScore:(NSNumber*)score;

/*
 *init initializes the scores object with default values
 *@return the scores object
 */
-(id)init;

/*
 *dealloc cleans up the memory and the object when release is called 
 */
-(void)dealloc;

@end
