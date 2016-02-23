//
//  TPLDatabase.h
//  Pods
//
//  Created by KattMing on 1/27/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TPLAPIClient;

@interface TPLDatabase : NSObject


/**
 *  Initializer for our persistence layer. It is necessary to initialize this with an API Unique Identifier to ensure storage and retrieval is done accurately.
 *
 *  @param apiClientUniqueIdentifier A unique identifier provided by a property on TPLAPIClient.
 *
 *  @return an instance of the TPLDatabase.
 */
- (instancetype) initWithAPIClientUniqueIdentifier:(NSString *)apiClientUniqueIdentifier;

/**
 *  This is the full event to be sent. This will not include the batch header though since that should only
 *  go when the event is sent but we shouldn't be storing the batch header info incase the request fails otherwise
 *  we run the risk of the event showing incorrect information.
 *
 *  @param eventData The event to be stored.
 */
- (void) addEventToQueue:(NSDictionary *)eventData;

/**
 *  Gets the event array for the current API client.
 *
 *  @return A PFBatchFaultingArray of NSManagedObjects stored in core data for the APIClientUniqueIdentifier
 */
- (NSArray *) getEventsArray;

/**
 *  Gets the number of events in the core data array for the current API client
 *
 *  @return The number of events in the array as a NSUInteger.
 */
- (NSUInteger) getEventsArrayCount;

/**
 *  Gets the event array for the current batch to be sent to the API.
 *
 *  @param managedContextArray An array of NSManagedObjects to be converted into their subclass and then to JSON to send to the API.
 *
 *  @return An array of events in JSON
 */
- (NSArray *) getEventsAsJSONFromArray:(NSArray *)managedContextArray;

/**
 *  Remove a specific managed object from the queue.
 *
 *  @param eventObject A NSManagedObject to be removed
 */
- (void) removeEventFromQueue:(NSManagedObject *)eventObject;

/**
 *  Batch removes an array of NSManagedObjects by their Object ID.
 *
 *  @param arrayOfManagedObjectIDs The array of NSManagedObject object IDs to be removed from the persistence layer.
 */
- (void) removeEventsFromQueue:(NSArray *)arrayOfManagedObjectIDs;

/**
 *  Forces the database to merge the background thread with the main thread resulting in a save. It is important to note that this does not need to be
 *  called directly, but can. This will happen on the main thread.
 */
- (void) saveContext;

/**
 *  Removes all objects from the database.
 */
- (void) resetDatabase;

@end
