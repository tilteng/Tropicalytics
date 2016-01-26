//
//  TPLFieldGroup.m
//  Pods
//
//  Created by Brett Bukowski on 1/21/16.
//
//

#import <MAObjCRuntime/RTIvar.h>
#import <MAObjCRuntime/MARTNSObject.h>
#import "TPLFieldGroup.h"

@interface TPLFieldGroup ()

@property (nonatomic, strong) NSMutableDictionary *data;

@end

@implementation TPLFieldGroup

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _data = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (instancetype)initWithEntries:(NSDictionary *)entries {
    self = [self init];
    
    if (self) {
        [self addValues:entries];
    }
    
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [_data setValue:value forKey:key];
}

- (void)addValues:(NSDictionary *)values {
    [_data addEntriesFromDictionary:values];
}

- (NSDictionary *)dictionaryRepresentationWithUnderscoreKeys {
    return [self dictionaryRepresentation:YES];
}

- (NSDictionary *)dictionaryRepresentation {
    return [self dictionaryRepresentation:NO];
}

- (NSDictionary *)dictionaryRepresentation:(BOOL)underscoreKeys {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    NSArray *ivars = [[self class] rt_ivars];
    for (RTIvar *ivar in ivars) {
        // data is a dict of arbitrary key-values that's merged with ivar key-values below.
        if (![ivar.name isEqual: @"_data"]) {
            // Remove leading underscore.
            NSString *propName = [ivar.name substringFromIndex:1];
            id value = [self valueForKey:propName];
            
            if (value) {
                if (underscoreKeys) {
                    propName = [self underscoreName:propName];
                }
                
                id convertedValue = [self convertValue:value underscoreKeys:underscoreKeys];
                
                if (convertedValue != nil) {
                    [dictionary setObject:convertedValue forKey:propName];
                }
            }
        }
    }
    
    [dictionary addEntriesFromDictionary:[self convertValue:_data underscoreKeys:underscoreKeys]];
    
    return dictionary;
}

- (id)convertValue:(id)value underscoreKeys:(BOOL)underscoreKeys {
    if ([value isKindOfClass:[self class]]) {
        return [value dictionaryRepresentation:underscoreKeys];
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[value count]];
        
        for (id subValue in value) {
            [array addObject:[self convertValue:subValue underscoreKeys:underscoreKeys]];
        }
        
        return array;
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:[value count]];
        
        for (NSString *key in [value allKeys]) {
            id convertedValue = [self convertValue:[value objectForKey:key] underscoreKeys:underscoreKeys];
            
            if (convertedValue != nil) {
                [dictionary setObject:convertedValue forKey:underscoreKeys ? [self underscoreName:key] : key];
            }
        }
        
        return dictionary;
    } else if ([value conformsToProtocol:@protocol(NSCoding)]) {
        return value;
    }
    
    NSLog(@"TPL Warning - skipping value since it is of an unknown type that does not conform to the NSCoding protocol");
        
    return nil;
}

/**
 *  Attempts to convert the given string from someCase into some_case.
 *  - Strips all non-alphanumeric characters.
 *  - Leaves all underscores in place.
 *  - Does not apply underscoring to the first part of the word if the first part is capitalized (e.g. SomeCase is left as somecase).
 *  - Does not support acronyms (e.g. someYOLOvalue is converted to some_yolovalue).
 *
 *  @param name camelCase string to convert to underscore
 *
 *  @return reasonably-converted camelCase → camel_case converted string
 */
- (NSString *)underscoreName:(NSString *)name {
    NSCharacterSet *underscore = [NSCharacterSet characterSetWithCharactersInString:@"_"];
    NSCharacterSet *uppercase = [NSCharacterSet uppercaseLetterCharacterSet];
    NSCharacterSet *lowercase = [NSCharacterSet lowercaseLetterCharacterSet];
    NSCharacterSet *digits = [NSCharacterSet decimalDigitCharacterSet];
    NSMutableCharacterSet *nonAlphaNumeric = [NSMutableCharacterSet alphanumericCharacterSet];
    [nonAlphaNumeric invert];
    [nonAlphaNumeric removeCharactersInString:@"_"];

    // Remove all non-alphanumeric characters except underscore (the scanner is configured to just
    // skip underscore).
    name = [[name componentsSeparatedByCharactersInSet:nonAlphaNumeric] componentsJoinedByString:@""];
    
    NSScanner *scanner = [NSScanner scannerWithString:name];
    scanner.caseSensitive = YES;
    scanner.charactersToBeSkipped = underscore;
    
    NSString *buffer = nil;
    NSMutableString *output = [NSMutableString string];
    
    while (!scanner.isAtEnd) {
        if ([scanner scanCharactersFromSet:uppercase intoString:&buffer] ||
            [scanner scanCharactersFromSet:digits intoString:&buffer]) {
            [output appendString:[buffer lowercaseString]];
        }
        
        if ([scanner scanCharactersFromSet:lowercase intoString:&buffer]) {
            [output appendString:buffer];
            
            if (!scanner.isAtEnd) {
                [output appendString:@"_"];
            }
        }
    }
    
    return [NSString stringWithString:output];
}

@end
