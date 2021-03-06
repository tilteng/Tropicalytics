
//  Tropicalytics.m
//  Pods
//
//  Created by KattMing on 1/19/16.
//
//

#import "Tropicalytics.h"
#import "TPLConfiguration.h"
#import "TPLLogger.h"
#import "TPLRequestManager.h"
#import "TPLRequestStructure.h"
#import "TPLFieldGroup.h"

static Tropicalytics *_sharedInstance = nil;
static dispatch_once_t predicate = 0;


@interface Tropicalytics ()

@property (nonatomic, strong)   TPLRequestManager *requestManager;

@end

@implementation Tropicalytics

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Initializers

- (instancetype)init NS_UNAVAILABLE {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Tropicalytics init is unavailable." userInfo:nil];
    return nil;
}

#pragma mark - Singleton Initializer

- (instancetype) initWithConfiguration:(TPLConfiguration *)configuration {
    self = [super init];
    if (self) {

        if (!configuration) {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"TPLConfiguration object cannot be nil." userInfo:nil];
        }

        // Add observes so we know what's going on with the application so we can send analytics at appropriate times despite
        // the current batch status.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didEnterBackgroundCallBack:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willEnterForegroundCallBack:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willTerminateCallBack:)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];


        self.requestManager = [[TPLRequestManager alloc] initWithConfiguration:configuration];

        [TPLLogger setEnabled:[TPLConfiguration debug]];
    }

    return self;
}

- (instancetype) initDefaultRequestStructureWithConfiguration:(TPLConfiguration *)configuration appId:(NSString *)appId {
    self = [self initWithConfiguration:configuration];
    
    if (self) {
        [self setRequestStructure:[[TPLRequestStructure alloc] initWithDefaultsForAppId:appId]];
    }
    
    return self;
}

+ (void) sharedInstanceWithConfiguration:(TPLConfiguration *)configuration {
    dispatch_once(&predicate, ^() {
        _sharedInstance = [[self alloc] initWithConfiguration:configuration];
    });
}

+ (void) defaultSharedInstanceWithConfiguration:(TPLConfiguration *)configuration appId:(NSString *)appId {
    dispatch_once(&predicate, ^() {
        _sharedInstance = [[self alloc] initDefaultRequestStructureWithConfiguration:configuration appId:appId];
    });
}

+ (instancetype) sharedInstance {
    if (!_sharedInstance) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Tropicalytics singleton hasn't been initialized and therefore cannot be accessed. Initialize with sharedInstanceWithConfiguration:" userInfo:nil];
    }

    return _sharedInstance;
}

#pragma mark - Functions

- (void) recordEvent:(NSDictionary *)eventDictionary {
    [self.requestManager recordEvent:eventDictionary];
}

- (void) recordEventWithLabel:(NSString *)label category:(NSString *)category {
    [self.requestManager recordEvent:@{@"label" : label, @"category" : category}];
}

- (void) recordEventWithLabel:(NSString *)label category:(NSString *)category context:(NSDictionary *)context {
    [self.requestManager recordEvent:@{@"label" : label, @"category" : category, @"ctx" : context}];
}

- (void) recordEventWithFieldGroup:(TPLFieldGroup *)fieldGroup {
    [self.requestManager recordEventWithFieldGroup:fieldGroup];
}

- (void) resetDatabase {
    [self.requestManager resetDatabase];
}

- (void) setEntry:(NSDictionary *)entryDictionary forKey:(NSString *)key {
    [self.requestManager addEntry:entryDictionary forKey:key];
}

- (void) removeEntryForKey:(NSString *)key {
    [self.requestManager removeEntryForKey:key];
}

- (void) addEntryForFieldGroup:(TPLFieldGroup *)fieldGroup {
    [self.requestManager addEntryForFieldGroup:fieldGroup];
}

- (void) removeEntryForFieldGroup:(TPLFieldGroup *)fieldGroup {
    [self.requestManager removeEntryForFieldGroup:fieldGroup];
}

- (void) setRequestStructure:(TPLRequestStructure *)requestStructure {
    [self.requestManager replaceRequestStructure:requestStructure];
}

// Important note: These selectors will NOT be called on the main thread.
#pragma mark - Selectors

- (void) didEnterBackgroundCallBack:(NSNotification *)notification {
    [TPLLogger log:@"App didEnterBackground"];

    // Start or finish sending the current batch. Then pause everything since are in the background.
    // We we can get more fancy and add some "didReceiveRemoteNotification" to send analytics for notifications outside of the batching
}

- (void) willEnterForegroundCallBack:(NSNotification *)notification {
    [TPLLogger log:@"App willEnterForeground"];

    [self.requestManager flushQueue];
}

- (void) willTerminateCallBack:(NSNotification *)notification {
    [TPLLogger log:@"App willTerminate"];
    // We probably won't have enough time to kick off a network call so lets store
    // everything and then on the next open send everything off.
}

@end
