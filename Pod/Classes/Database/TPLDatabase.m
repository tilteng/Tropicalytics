//
//  TPLDatabase.m
//  Pods
//
//  Created by KattMing on 1/27/16.
//
//

#import "TPLDatabase.h"
#import "TPLEvent.h"
#import "TPLAPIClient.h"
#import "TPLConstants.h"
#import "TPLLogger.h"

static NSString *const SQLiteStoreURL            = @"Tropicalytics.sqlite";
static NSString *const ManagedObjectEntity       = @"Data";
static NSString *const ManagedObjectRemoteURLKey = @"remoteURL";

static NSUInteger const FetchBatchSize           = 50;

@interface TPLDatabase ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *backgroundManagedObjectContext;

@property (nonatomic, copy)   NSURL    *storeURL;
@property (nonatomic, copy)   NSString *apiClientUniqueIdentifier;

@end

@implementation TPLDatabase


- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Initalizer

- (instancetype) initWithAPIClientUniqueIdentifier:(NSString *)apiClientUniqueIdentifier {
    self = [super init];
    if (self) {
        self.apiClientUniqueIdentifier = apiClientUniqueIdentifier;
        self.storeURL = [[self applicationSupportDirectory] URLByAppendingPathComponent:SQLiteStoreURL];
        self.managedObjectContext = [self setupManagedObjectContextWithConcurrencyType:NSMainQueueConcurrencyType];
        self.backgroundManagedObjectContext = [self setupManagedObjectContextWithConcurrencyType:NSPrivateQueueConcurrencyType];

        // Be notified when to merge back to main object context and merge the changes.
        [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification object:nil queue:nil
                                                      usingBlock:^(NSNotification *notification) {
                                                          NSManagedObjectContext *moc = self.managedObjectContext;
                                                          if (notification.object != moc) {
                                                              [moc performBlock:^(){
                    [moc mergeChangesFromContextDidSaveNotification:notification];
                }];
                                                          }
                                                      }];
    }

    return self;
}

#pragma mark - Persistence Layer Writing

- (void) addEventToQueue:(NSDictionary *)eventData {
    NSManagedObjectContext *context = self.backgroundManagedObjectContext;

    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:ManagedObjectEntity inManagedObjectContext:context];

    [newManagedObject setValue:eventData forKey:ManagedObjectEventKey];
    [newManagedObject setValue:self.apiClientUniqueIdentifier forKey:ManagedObjectRemoteURLKey];

    [self saveContext];
}

- (void) removeEventFromQueue:(NSManagedObject *)eventObject {
    NSManagedObjectContext *context = self.backgroundManagedObjectContext;

    [context deleteObject:eventObject];
    [self saveContext];
}

- (void) removeEventsFromQueue:(NSArray *)arrayOfManagedObjectIDs {
    NSError *error;
    if(![arrayOfManagedObjectIDs count]) {
        [TPLLogger log:@"No objects to remove from queue"];
        return;
    }
    
    
    if([NSBatchDeleteRequest class]) {
        NSBatchDeleteRequest *request = [[NSBatchDeleteRequest alloc] initWithObjectIDs:arrayOfManagedObjectIDs];
        [self.backgroundManagedObjectContext executeRequest:request error:&error];
    } else {
        for (NSManagedObject *object in arrayOfManagedObjectIDs) {
            [self.backgroundManagedObjectContext deleteObject:object];
        }
    }
    
    if (error) {
        [TPLLogger log:@"Error removing events from queue"];
    } else {
        [self saveContext];
    }
}

#pragma mark - Persistence Layer Reading

- (NSArray *) getEventsArray {
    NSError *error = nil;
    NSArray *result = [self.backgroundManagedObjectContext executeFetchRequest:[self fetchRequest] error:&error];

    if (error) {
        [TPLLogger log:@"CoreData error %@, %@", error, [error userInfo]];
    }

    return result;
}

- (NSArray *) getEventsAsJSONFromArray:(NSArray *)managedContextArray {
    NSMutableArray *events = [[NSMutableArray alloc] init];
    NSArray *staticEvents = managedContextArray;

    for (id managedEventObject in staticEvents) {
        [events addObject:[TPLEvent objectWithManagedObject:managedEventObject]];
    }

    return events;
}

- (NSUInteger) getEventsArrayCount {
    NSUInteger count;
    NSError *error = nil;

    count = [self.backgroundManagedObjectContext countForFetchRequest:[self fetchRequest] error:&error];

    if (error) {
        [TPLLogger log:@"CoreData error %@, %@", error, [error userInfo]];
    }

    return count;
}

#pragma mark - Persistence Fetch Request

- (NSFetchRequest *) fetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ManagedObjectEntity inManagedObjectContext:self.backgroundManagedObjectContext];
    [fetchRequest setIncludesPropertyValues:NO];
    [fetchRequest setFetchBatchSize:FetchBatchSize];
    [fetchRequest setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(remoteURL == %@)",
                              self.apiClientUniqueIdentifier];
    [fetchRequest setPredicate:predicate];

    return fetchRequest;
}

#pragma mark - Persistence Layer Save

- (void) saveContext {
    NSError *error = nil;

    if (self.backgroundManagedObjectContext != nil) {
        if ([self.backgroundManagedObjectContext hasChanges] && ![self.backgroundManagedObjectContext save:&error]) {
            [TPLLogger log:@"CoreData error %@, %@", error, [error userInfo]];
        }
    }
}

#pragma mark - Persistence Layer Reset

- (void) resetDatabase {
    NSArray *staticEvents = [self getEventsArray];

    for (id managedEventObject in staticEvents) {
        [self.backgroundManagedObjectContext deleteObject:managedEventObject];
    }

    [self saveContext];
}

#pragma mark - NSManagedObject Setup

- (NSManagedObjectContext *) setupManagedObjectContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType {
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:concurrencyType];

    managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError *error;
    [managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                  configuration:nil
                                                                            URL:self.storeURL
                                                                        options:nil
                                                                          error:&error];
    if (error) {
        [TPLLogger log:@"error: %@", error.localizedDescription];
    }
    return managedObjectContext;
}

- (NSManagedObjectModel *) managedObjectModel {
    static NSManagedObjectModel *s_managedObjectModel;

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSURL *modelURL = [[NSBundle bundleForClass:[TPLDatabase class]] URLForResource:@"Tropicalytics" withExtension:@"momd"];

        if (modelURL == nil) {
            modelURL = [[NSBundle bundleForClass:[TPLDatabase class]] URLForResource:@"Tropicalytics" withExtension:@"mom"];
        }

        s_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    });

    return s_managedObjectModel;
}

- (NSURL *) applicationSupportDirectory {
    NSFileManager *fm = NSFileManager.defaultManager;
    NSURL *url = [[fm URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    NSError *error = nil;

    if (![fm fileExistsAtPath:[url absoluteString]]) {
        [fm createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            [TPLLogger log:@"Can not create Application Support directory: %@", error];
        }
    }

    return url;
}

@end
