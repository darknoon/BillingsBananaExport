//
//  DNBBEDailyCSVFileExporter.m
//  BillingsBananaExport
//
//  Created by Andrew Pouliot on 2/16/12.
//  Copyright (c) 2012 Darknoon. All rights reserved.
//

#import "DNBBEDailyCSVFileExporter.h"

#import "DNBBESlip.h"
#import "DNBBETimeEntry.h"

@implementation DNBBEDailyCSVFileExporter {
	DNBBESlip *_slip;
	NSArray *_entries;
}

+ (NSString *)fileType;
{
	return @"csv";
}

- (id)initWithSlip:(DNBBESlip *)slip entries:(NSArray *)entries;
{
	self = [super init];
	if (!self) return nil;
	
	_slip = slip;
	_entries = [entries copy];
	
	return self;
}

- (NSData *)exportedData;
{
	//Make a map of day string (yyyy-mm-dd to the total time recorded for that day
	NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
	
	//Iterate, incrementing each day's time
	for (DNBBETimeEntry *entry in _entries) {
		
		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		df.dateFormat = @"yyyy-MM-dd";
		
		NSString *key = [df stringFromDate:entry.startDate];
		
		NSNumber *n = [map objectForKey:key];
		
		double newTotal = n.doubleValue + entry.duration;
		
		[map setObject:[NSNumber numberWithDouble:newTotal] forKey:key];
	}
	
	//Export spreadsheet sorted by key
	
	NSArray *sortedKeys = [map.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj1 compare:obj2 options:0];
	}];

	NSMutableString *str = [[NSMutableString alloc] init];
	
	for (NSString *key in sortedKeys) {
		NSNumber *total = [map objectForKey:key];
		
		double hours = total.doubleValue / 60.0 / 60.0;
		
		[str appendFormat:@"%@,%.1lf\n", key, hours];
	}
	
	return [str dataUsingEncoding:NSUTF8StringEncoding];
}

@end
