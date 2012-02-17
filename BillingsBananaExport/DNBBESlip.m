//
//  DNBBESlip.m
//  BillingsBananaExport
//
//  Created by Andrew Pouliot on 2/16/12.
//  Copyright (c) 2012 Darknoon. All rights reserved.
//

#import "DNBBESlip.h"

@implementation DNBBESlip
@synthesize name = _name;
@synthesize identifier = _identifier;

- (BOOL)isEqual:(id)object;
{
	if ([object isKindOfClass:[DNBBESlip class]]) {
		return [((DNBBESlip *)object).identifier isEqualToNumber:self.identifier]; 
	}
	return NO;
}

@end
