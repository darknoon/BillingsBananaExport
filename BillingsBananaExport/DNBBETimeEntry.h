//
//  DNBBETimeEntry.h
//  BillingsBananaExport
//
//  Created by Andrew Pouliot on 2/16/12.
//  Copyright (c) 2012 Darknoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNBBETimeEntry : NSObject

@property NSDate *startDate;
@property NSDate *endDate;

@property (readonly) NSTimeInterval duration;

@end
