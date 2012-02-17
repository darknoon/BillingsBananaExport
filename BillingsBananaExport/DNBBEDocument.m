//
//  DNBBEDocument.m
//  BillingsBananaExport
//
//  Created by Andrew Pouliot on 2/16/12.
//  Copyright (c) 2012 Darknoon. All rights reserved.
//

#import "DNBBEDocument.h"
#import "DNBBEDatabase.h"
#import "DNBBESlip.h"

@interface DNBBEDocument ()

@property IBOutlet NSButton *exportButton;
@property IBOutlet NSPopUpButton *pickSlipButton;
@property IBOutlet NSTextField *statusLabel;

@end

@implementation DNBBEDocument {
	DNBBEDatabase *_database;
	NSArray *_slips;
	DNBBESlip *_pickedSlip;
}
@synthesize exportButton = _exportButton;
@synthesize pickSlipButton = _pickSlipButton;
@synthesize statusLabel = _statusLabel;

- (id)init
{
    self = [super init];
    if (self) {
		// Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"DNBBEDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
	[self refreshSlipsMenu];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (void)refreshSlipsMenu;
{
	[self.pickSlipButton removeAllItems];
	for (DNBBESlip *slip in _slips) {
		[self.pickSlipButton addItemWithTitle:slip.name];
	}
	//Choose first
	[self pickSlip:self.pickSlipButton];
}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError;
{
	_database = [[DNBBEDatabase alloc] initWithFilePath:url.path];
	if (!_database) return NO;
	
	_slips = [_database allSlips];
	
	return _database != nil;
}

- (IBAction)pickSlip:(NSPopUpButton *)sender {
	_pickedSlip = [_slips objectAtIndex:sender.indexOfSelectedItem + 1];
}

- (IBAction)export:(NSButton *)sender {
	NSLog(@"Entries for slip %@ : %@", _pickedSlip.name, [_database timeEntriesForSlip:_pickedSlip]);
}

@end
