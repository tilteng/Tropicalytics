//
//  TPLRequestStructure.m
//  Pods
//
//  Created by KattMing on 2/1/16.
//
//

#import "TPLRequestStructure.h"
#import "TPLBatchDetails.h"

@implementation TPLRequestStructure

- (instancetype) initWithDefaultBatchInfo {
    return [self initWithDefaultBatchInfoForKey:@"batch_info"];
}

- (instancetype) initWithDefaultBatchInfoForKey:(NSString *)key {
    self = [self init];
    
    if (self) {
        _batchDetails = [[TPLBatchDetails alloc] initWithKey:key];
    }
    
    return self;
}

- (void) setEvents:(NSArray<TPLEvent *> *)eventsArray {
    [super setValue:eventsArray forKey:@"events"];
}

@end