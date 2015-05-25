//
//  Player.h
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Player : NSManagedObject

@property (nonatomic, retain) NSNumber * matchWon;
@property (nonatomic, retain) NSString * playerId;
@property (nonatomic, retain) NSString * playerName;
@property (nonatomic, retain) NSNumber * totalMatch;
@property (nonatomic, retain) NSNumber * rank;

@end
