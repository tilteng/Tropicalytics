//
//  TPLBatchDetails.m
//  Pods
//
//  Created by KattMing on 1/27/16.
//
//

#import "TPLBatchDetails.h"
#import "TPLUniqueIdentifier.h"

@interface TPLBatchDetails ()

@property (nonatomic, readwrite) NSString *batchId;

@end

@implementation TPLBatchDetails

- (instancetype)init {
    self = [super init];
    if(self) {
        _batchId = [TPLUniqueIdentifier createUUID];
    }
    
    return self;
}

@end