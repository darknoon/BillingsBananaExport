//
//  DNBBEDatabase.h
//  BillingsBananaExport
//
//  Created by Andrew Pouliot on 2/16/12.
//  Copyright (c) 2012 Darknoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DNBBESlip;
@interface DNBBEDatabase : NSObject

- (id)initWithFilePath:(NSString *)filePath;

- (NSArray *)allSlips;

- (NSArray *)timeEntriesForSlip:(DNBBESlip *)slipIdentifier;


@end
