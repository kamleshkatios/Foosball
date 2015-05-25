//
//  CoreDataHelper.h
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const PlayerIdKey;
extern NSString *const PlayerNameKey;
extern NSString *const MatchWonKey;
extern NSString *const TotalMatchKey;
extern NSString *const MatchIdKey;
extern NSString *const Player1IdKey;
extern NSString *const Player2IdKey;
extern NSString *const MatchDateKey;
extern NSString *const NumberOfGamesKey;
extern NSString *const Player1PointsKey;
extern NSString *const Player2PointsKey;

@class Player;

@interface CoreDataHelper : NSObject
+ (instancetype)sharedCoreDataHelper;
- (NSArray *)playersList;
- (BOOL)createPlayerObjectEntity :(NSDictionary *)playerDetails;
- (void)updatePlayerPoints:(Player *) playerChanged;
- (BOOL) createMatchObjectEntity:(NSDictionary *)matchDetails;
- (Player *) highestMatchPlayer;
@end
