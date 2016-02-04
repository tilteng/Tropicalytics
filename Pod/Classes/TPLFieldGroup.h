//
//  TPLFieldGroup.h
//  Pods
//
//  Created by Brett Bukowski on 1/21/16.
//
//

#import <Foundation/Foundation.h>

/**
 * Represents a grouping of key-value pairs that
 * are sent in tracking payloads.
 *
 * Subclasses' properties as well as values added via
 * the NSDictionary-like setters/adders are included
 * in results returned by the dictionaryRepresentation method.
 */
@interface TPLFieldGroup : NSObject

/**
 *  Override the key that is normally set from the IVAR for the TPLFieldGroup.
 */
@property (nonatomic, copy) NSString *dictionaryRepresentationKey;

/**
 *  Initializes with a set of key-value entries.
 *
 *  @param entries Initial set of entries
 *  @param key The key to be used when dictionaryRepresentation is called.
 *
 *  @return a field group instance with entries
 */
- (instancetype) initWithEntries:(NSDictionary *)entries forKey:(NSString *)key;

/**
 *  Initializes with a set of key-value entries.
 *
 *  @param entries entries Initial set of entries
 *
 *  @return a field group instance with entries
 */
- (instancetype) initWithEntries:(NSDictionary *)entries;

/**
 *  Initializes with a set of key-value entries.
 *
 *  @param key The key to be used when dictionaryRepresentation is called.
 *
 *  @return a field group instance with entries
 */
- (instancetype) initWithKey:(NSString *)key;

/**
 *  Adds a key and value to the entry set. Overrides any
 *  value previously set with key.
 *
 *  @param value object to set
 *  @param key   index to reference the object
 */
- (void) setValue:(id)value forKey:(NSString *)key;

/**
 *  Adds a group of key-value entries. The values
 *  specified override any previously-set values.
 *
 *  @param values group of key-value entries
 */
- (void) addValues:(NSDictionary *)values;

/**
 *  Add a TPLFieldGroup to the structure
 *
 *  @param fieldGroup a TPLFieldGroup to be added.
 */
- (void) addFieldGroup:(TPLFieldGroup *)fieldGroup;

/**
 *  Removes the entry for the desired key
 *
 *  @param key the key to be used to remove from the dictionary
 */
- (void) removeEntryForKey:(NSString *)key;

/**
 *  Removes the entry for a specific field group
 *
 *  @param fieldGroup
 */
- (void) removeEntryForFieldGroup:(TPLFieldGroup *)fieldGroup;

/**
 *  Returns a dictionary representation of the object that's
 *  suitable for serializing / JSON-encoding etc.
 *
 *  @return all keys of propery names and entry names are converted
 *  to underscore-case
 */
- (NSDictionary *) dictionaryRepresentation;

/**
 *  Returns a dictionary representation of the object that's
 *  suitable for serializing / JSON-encoding etc.
 *
 *  @return all keys of property names and entry names are left alone
 */
- (NSDictionary *) dictionaryRepresentationWithUnderscoreKeys;

@end
