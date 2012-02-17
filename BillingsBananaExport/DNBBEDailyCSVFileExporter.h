//
//  DNBBEDailyCSVFileExporter.h
//  BillingsBananaExport
//
//  Created by Andrew Pouliot on 2/16/12.
//  Copyright (c) 2012 Darknoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DNBBESlip;
@interface DNBBEDailyCSVFileExporter : NSObject

+ (NSString *)fileType;

- (id)initWithSlip:(DNBBESlip *)slip entries:(NSArray *)entries;

- (NSData *)exportedData;

@end
