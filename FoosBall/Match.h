//
//  Match.h
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player;

@interface Match : NSManagedObject

@property (nonatomic, retain) NSNumber * matchId;
@property (nonatomic, retain) NSString * player1Id;
@property (nonatomic, retain) NSString * player2Id;
@property (nonatomic, retain) NSDate * matchDate;
@property (nonatomic, retain) NSNumber * numberOfGames;
@property (nonatomic, retain) NSNumber * player1Points;
@property (nonatomic, retain) NSNumber * player2Points;
@property (nonatomic, retain) Player *relationship;

@end
