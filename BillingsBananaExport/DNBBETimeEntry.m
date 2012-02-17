//
//  DNBBETimeEntry.m
//  BillingsBananaExport
//
//  Created by Andrew Pouliot on 2/16/12.
//  Copyright (c) 2012 Darknoon. All rights reserved.
//

#import "DNBBETimeEntry.h"

@implementation DNBBETimeEntry

@synthesize startDate = _startDate;
@synthesize endDate = _endDate;

- (NSTimeInterval)duration {
	return [self.endDate timeIntervalSinceDate:self.startDate];
}

- (NSString *)description;
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateStyle:NSDateFormatterFullStyle];
	
	return [NSString stringWithFormat:@"<%@ %p %.2lf hours on %@>", self.class, self, self.duration / 60.0 / 60.0, [df stringFromDate:_startDate]];

}

@end
