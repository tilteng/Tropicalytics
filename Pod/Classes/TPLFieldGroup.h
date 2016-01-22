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
@interface TPLFieldGroup : NSObject <NSCoding>

- (instancetype)initWithEntries:(NSDictionary *)entries;
- (void)setValue:(id)value forKey:(NSString *)key;
- (void)addValues:(NSDictionary *)values;
- (NSDictionary *)dictionaryRepresentation;
- (NSDictionary *)dictionaryRepresentationWithUnderscoreKeys;

@end
