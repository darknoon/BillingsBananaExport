//
//  DNBBEDatabase.m
//  BillingsBananaExport
//
//  Created by Andrew Pouliot on 2/16/12.
//  Copyright (c) 2012 Darknoon. All rights reserved.
//

#import "DNBBEDatabase.h"

#import <sqlite3.h>

#import "DNBBESlip.h"
#import "DNBBETimeEntry.h"

@implementation DNBBEDatabase {
	sqlite3 *db;
}

- (id)initWithFilePath:(NSString *)filePath;
{
	self = [super init];
	if (!self) return nil;
	
	if (sqlite3_open_v2([filePath UTF8String], &db, SQLITE_OPEN_READWRITE, NULL) != SQLITE_OK) {
		sqlite3_close(db);
		return nil;
	}
	
	return self;
}

- (NSArray *)allSlips;
{
	NSString *sql = @"select name, _rowId from TimeSlip";

	sqlite3_stmt *statement = NULL;
	sqlite3_prepare_v2(db, sql.UTF8String, sql.length, &statement, NULL);
	
	if (statement) {
		
		NSMutableArray *a = [[NSMutableArray alloc] init];
		
		while (sqlite3_step(statement) == SQLITE_ROW) {
			@autoreleasepool {
				
				const void *textPtr = sqlite3_column_text(statement, 0);
				size_t length = sqlite3_column_bytes(statement, 0);
				NSString *text = [[NSString alloc] initWithBytes:textPtr length:length encoding:NSUTF8StringEncoding];

				NSInteger key = sqlite3_column_int64(statement, 1);
				
				DNBBESlip *slip = [[DNBBESlip alloc] init];
				slip.identifier = [NSNumber numberWithInteger:key];
				slip.name = text;
				
				[a addObject:slip];
			}
		}
		sqlite3_free(statement);
		return a;
	} else {
		NSLog(@"sqlite error :%s", sqlite3_errmsg(db));
	}
	return nil;
}

- (NSArray *)timeEntriesForSlip:(DNBBESlip *)slip;
{
	NSString *sql = @"select startDateTime, endDateTime from TimeEntry where timeSlipID = ?";
	
	sqlite3_stmt *statement = NULL;
	sqlite3_prepare_v2(db, sql.UTF8String, sql.length, &statement, NULL);
	
	sqlite3_bind_int64(statement, 1, slip.identifier.integerValue);
	
	if (statement) {
		
		NSMutableArray *a = [[NSMutableArray alloc] init];
		
		while (sqlite3_step(statement) == SQLITE_ROW) {
			@autoreleasepool {
				
				NSTimeInterval startDateTime = sqlite3_column_double(statement, 0);
				NSTimeInterval endDateTime = sqlite3_column_double(statement, 1);
				
				NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:startDateTime];
				NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endDateTime];
				
				DNBBETimeEntry *entry = [[DNBBETimeEntry alloc] init];
				entry.startDate = startDate;
				entry.endDate = endDate;
				[a addObject:entry];
				
			}
		}
		sqlite3_free(statement);
		return a;
	} else {
		NSLog(@"sqlite error :%s", sqlite3_errmsg(db));
	}
	return nil;
}

@end
