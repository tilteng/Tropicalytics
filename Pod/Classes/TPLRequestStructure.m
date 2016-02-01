//
//  TPLRequestStructure.m
//  Pods
//
//  Created by KattMing on 2/1/16.
//
//

#import "TPLRequestStructure.h"

@implementation TPLRequestStructure

- (void) setEvents:(NSArray<TPLEvent *> *)eventsArray {
    [super setValue:eventsArray forKey:@"events"];
}

@end