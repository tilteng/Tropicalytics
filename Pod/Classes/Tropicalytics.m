//
//  Tropicalytics.m
//  Pods
//
//  Created by KattMing on 1/19/16.
//
//

#import "Tropicalytics.h"
#import "TPLAPIClient.h"
#import "TPLConfiguration.h"
#import "TPLUtilities.h"

static Tropicalytics *_sharedInstance = nil;

@interface Tropicalytics ()

//This is going to need to be an object, but since it's not let's keep it here.
@property (nonatomic, copy) NSString *sessionUUID;

@property (nonatomic, readonly) TPLConfiguration *configuration;
@property (nonatomic, strong)   TPLAPIClient     *apiClient;

@end

@implementation Tropicalytics

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Initializers

- (id)init {
    return [self initWithConfiguration:nil];
}

#pragma mark - Singleton Initializer

- (id)initWithConfiguration:(TPLConfiguration *)configuration {
    self = [super init];
    if(self) {
        
        if(!configuration) {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"TPLConfiguration object cannot be nil." userInfo:nil];
        }
        
        _configuration = configuration;
        
        //Add observes so we know what's going on with the application so we can send analytics at appropriate times despite
        //the current batch status.
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
        
        //This isn't necessarily the best place for us to define a session and we don't have a way of ending
        //a session yet, so I'm open to any suggestions around how we want to store this session object.
        if(!self.sessionUUID) {
            self.sessionUUID = [TPLUtilities getSessionUUID];
        }
        
        _apiClient = [[TPLAPIClient alloc] initWithBaseURL:_configuration.urlBasePath];
    }
    
    return self;
}

+ (void)sharedInstanceWithConfiguration:(TPLConfiguration *)configuration {
    static dispatch_once_t predicate = 0;
    
    dispatch_once(&predicate, ^() {
        _sharedInstance = [[self alloc] initWithConfiguration:configuration];
    });
}

+ (instancetype)sharedInstance {
    if(!_sharedInstance) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Tropicalytics singleton hasn't been initialized and therefore cannot be accessed. Initialize with sharedInstanceWithConfiguration:" userInfo:nil];
    }
    
    return _sharedInstance;
}

#pragma mark - Functions
/**
 *  This is just an initial sanity check to ensure that we are actually sending to a valid API endpoint when
 *  Tropicalyics is initalized.
 */
- (void)sendInitialPost {
    [self.apiClient postWithParameters:@{@"header" : @{@"session_id" : self.sessionUUID, @"device_id" : [TPLUtilities getDeviceUUID]}} completion:^(NSDictionary *response, NSError *error) {
        if(!error) {
            NSLog(@"Response: %@", response);
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
}

//Important note: These selectors will NOT be called on the main thread.
#pragma mark - Selectors

- (void)didEnterBackgroundCallBack:(NSNotification *)notification {
    NSLog(@"App didEnterBackground");
    
    //Start or finish sending the current batch. Then pause everything since are in the background.
    //We we can get more fancy and add some "didReceiveRemoteNotification" to send analytics for notifications outside of the batching
}

- (void)willEnterForegroundCallBack:(NSNotification *)notification {
    NSLog(@"App willEnterForeground");
    //Start the metrics again.
}

- (void)willTerminateCallBack:(NSNotification *)notification {
    NSLog(@"App willTerminate");
    //We probably won't have enough time to kick off a network call so lets store
    //everything and then on the next open send everything off.
}


@end
