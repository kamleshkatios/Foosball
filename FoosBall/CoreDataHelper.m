//
//  CoreDataHelper.m
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "CoreDataHelper.h"
#import <CoreData/CoreData.h>
#import "Player.h"
#import "Match.h"

@interface CoreDataHelper ()
/**
 NSManagedObjectContext object
 */
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
/**
 NSManagedObjectModel object
 */
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
/**
 NSPersistentStoreCoordinator object
 */
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end


NSString *const PlayerIdKey = @"playerId";
NSString *const PlayerNameKey = @"playerName";
NSString *const MatchWonKey = @"matchWon";
NSString *const TotalMatchKey = @"totalMatch";

NSString *const MatchIdKey = @"matchId";
NSString *const Player1IdKey = @"player1Id";
NSString *const Player2IdKey = @"player2Id";
NSString *const MatchDateKey = @"matchDate";
NSString *const NumberOfGamesKey = @"numberOfGames";
NSString *const Player1PointsKey  = @"player1Points";
NSString *const Player2PointsKey  = @"player2Points";

@implementation CoreDataHelper

- (NSManagedObjectContext *) temporaryContext {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [context setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    [self addContextChangedObserver:context];
    return context;
}

- (NSArray *) matchList {
    @try {
        NSManagedObjectContext *context = [self temporaryContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Match" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSSortDescriptor *sdSortDate = [NSSortDescriptor sortDescriptorWithKey:@"matchDate" ascending:YES];
        request.sortDescriptors = @[sdSortDate];

        [request setEntity:entity];
        NSError * error = nil;
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        [self removeContextChangedObserver:context];
        
        if ([objects lastObject]) {
            [self saveContext:context];
            NSArray *playerObjects = [self setManagedObjects:(NSMutableArray *)objects managedObjectContext:self.managedObjectContext];
            return playerObjects;
        } else {
            return nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (NSArray *) playersList {
    @try {
        
        NSManagedObjectContext *context = [self temporaryContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:entity];
        NSError * error = nil;
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        [self removeContextChangedObserver:context];

        if ([objects lastObject]) {
            [self saveContext:context];
            NSArray *playerObjects = [self setManagedObjects:(NSMutableArray *)objects managedObjectContext:self.managedObjectContext];
            return playerObjects;
        } else {
            return nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (void) updateRanking {
    Player *highestPlayer = [[CoreDataHelper sharedCoreDataHelper] highestMatchPlayer];
    NSArray *playersList = [[CoreDataHelper sharedCoreDataHelper] playersList];
    
    playersList = [playersList sortedArrayUsingComparator:^NSComparisonResult(Player* obj1, Player* obj2) {
        return [@(obj1.matchWon.integerValue/highestPlayer.totalMatch.integerValue) compare:@(obj2.matchWon.integerValue/highestPlayer.totalMatch.integerValue)];
    }];
    
    [playersList enumerateObjectsUsingBlock:^(Player *playerChanged, NSUInteger idx, BOOL *stop) {
        NSError *error = nil;
        Player * player = nil;
        
        NSManagedObjectContext *context = [self temporaryContext];
        //Set up to get the thing you want to update
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Player" inManagedObjectContext:context]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"playerId=%@",playerChanged.playerId]];
        
        //Ask for it
        player = [[context executeFetchRequest:request error:&error] lastObject];
        
        if (error) {
            //Handle any errors
        }
        
        //Update the object
        player.rank = @(idx+1);
        
        //Save it
        error = nil;
        if (![context save:&error]) {
            //Handle any error with the saving of the context
        }

    }];
    
}
- (Player *) highestMatchPlayer {
    @try {
        
        NSManagedObjectContext *context = [self temporaryContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        request.predicate = [NSPredicate predicateWithFormat:@"totalMatch==max(totalMatch)"];
        request.sortDescriptors = [NSArray array];

        
        [request setEntity:entity];
        NSError * error = nil;
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        [self removeContextChangedObserver:context];
        
        if ([objects lastObject]) {
            [self saveContext:context];
            NSArray *playerObjects = [self setManagedObjects:(NSMutableArray *)objects managedObjectContext:self.managedObjectContext];
            return playerObjects.lastObject;
        } else {
            return nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
    
}
- (void) updatePlayerPoints:(Player *) playerChanged {

    NSError *error = nil;
    Player * player = nil;
    
    NSManagedObjectContext *context = [self temporaryContext];
    //Set up to get the thing you want to update
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Player" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"playerId=%@",playerChanged.playerId]];
    
    //Ask for it
    player = [[context executeFetchRequest:request error:&error] lastObject];
    
    if (error) {
        //Handle any errors
    }
    
    //Update the object
    player.matchWon = playerChanged.matchWon;
    player.totalMatch = playerChanged.totalMatch;
    
    //Save it
    error = nil;
    if (![context save:&error]) {
        //Handle any error with the saving of the context
    }
    
    [self updateRanking];
}

- (BOOL) createMatchObjectEntity:(NSDictionary *)matchDetails {
    @try {
        NSManagedObjectContext *context = [self temporaryContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Match" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:entity];
        NSError * error = nil;
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        Match *match = [[Match alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        match.matchId = @(objects.count + 1);
        match.player1Id = matchDetails[Player1IdKey];
        match.player2Id = matchDetails[Player2IdKey];
        match.player1Points = matchDetails[Player1PointsKey];
        match.player2Points = matchDetails[Player2PointsKey];
        match.matchDate = matchDetails[MatchDateKey];
        match.numberOfGames = matchDetails[NumberOfGamesKey];
        [self saveContext:context];
        [self removeContextChangedObserver:context];
        return YES;
    } @catch (NSException *exception) {
        return NO;
    }
}

- (BOOL)createPlayerObjectEntity :(NSDictionary *)playerDetails {
    @try {
        NSManagedObjectContext *context = [self temporaryContext];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:entity];
        NSError * error = nil;
        Player *player = nil;
        
        NSString *playerId = playerDetails[@"playerId"];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"playerId = %@",playerId];
        [request setPredicate:pred];
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if ([objects lastObject]) {
            [self removeContextChangedObserver:context];
            return NO;
        } else {
            player = [[Player alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            player.playerId = playerDetails[PlayerIdKey];
            player.playerName = playerDetails[PlayerNameKey];
            player.matchWon = @(0);
            player.totalMatch = @(0);
            
            [self saveContext:context];
            [self removeContextChangedObserver:context];
            return YES;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}

#pragma mark Utility
+ (instancetype)sharedCoreDataHelper {
    static dispatch_once_t once;
    static id globalCoreDataHelper;
    dispatch_once(&once, ^{
                      globalCoreDataHelper = [[self alloc] init];
                  });
    return globalCoreDataHelper;
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    NSPersistentStoreCoordinator *coordinator_ = [self persistentStoreCoordinator];

    static dispatch_once_t once;
    static NSManagedObjectContext* managedObjectContext;
    dispatch_once(&once, ^{
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator_];
    });
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    static dispatch_once_t once;
    static NSManagedObjectModel* managedObjectModel;
    dispatch_once(&once, ^{
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Foosball" withExtension:@"momd"];
        managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    });
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    static dispatch_once_t once;
    static NSPersistentStoreCoordinator* persistentStoreCoordinator;
    dispatch_once(&once, ^{
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Foosball.sqlite"];
        
        NSDictionary *optionsDict = nil;//[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        NSError *error = nil;
        persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:optionsDict error:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             
             Typical reasons for an error here include:
             * The persistent store is not accessible;
             * The schema for the persistent store is incompatible with current managed object model.
             Check the error message to determine what the actual problem was.
             
             
             If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
             
             If you encounter schema incompatibility errors during development, you can reduce their frequency by:
             * Simply deleting the existing store:
             [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
             
             * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
             [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
             
             Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
             
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    });
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveMainContext {
    /*
     Saves the main object context
     */
    [self saveContext:self.managedObjectContext];
}

#pragma mark
#pragma mark Handling managedObjectContext

- (NSArray *) setManagedObjects:(NSMutableArray *)_stories managedObjectContext:(NSManagedObjectContext *)context {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[_stories count]];
    for(NSManagedObject *tempStoryItem in _stories)
    {
        NSManagedObject *storyItem = [context objectWithID:[tempStoryItem objectID]];
        [array addObject:storyItem];
    }
    return array;
}

- (void) addContextChangedObserver:(NSManagedObjectContext *)_managedObjectContext {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextChanged:) name:NSManagedObjectContextDidSaveNotification object:_managedObjectContext];
}

- (void) removeContextChangedObserver:(NSManagedObjectContext *)_managedObjectContext {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:_managedObjectContext];
}

- (void)contextChanged:(NSNotification*)notification {
    if ([notification object] == self.managedObjectContext) return;
    
    if (![NSThread isMainThread]) {
        /*
         Performs the merging operation on main thread
         */
        [self performSelectorOnMainThread:@selector(contextChanged:) withObject:notification waitUntilDone:YES];
        return;
    }
    /*
     Merging temporary context to main context
     */
    [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
}

- (void)saveContext:(NSManagedObjectContext *)context {
    if (context != nil) {
        if ([context hasChanges]) {
            /*
             Saves if the context has changed
             */
            [context performBlock:^{
                NSError *error = nil;
                [context save:&error];
                NSLog(@"%@" , [error description]);
            }];            
        }
    }
}


@end
