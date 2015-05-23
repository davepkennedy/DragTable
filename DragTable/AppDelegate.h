//
//  AppDelegate.h
//  DragTable
//
//  Created by Dave Kennedy on 22/05/2015.
//  Copyright (c) 2015 Dave Kennedy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate>

@property NSMutableArray* people;
@property IBOutlet NSArrayController* arrayController;
@property IBOutlet NSTableView* tableView;
@property IBOutlet NSTextField* name;
@property IBOutlet NSTextField* age;

@end

