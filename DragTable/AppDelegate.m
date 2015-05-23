//
//  AppDelegate.m
//  DragTable
//
//  Created by Dave Kennedy on 22/05/2015.
//  Copyright (c) 2015 Dave Kennedy. All rights reserved.
//

#import "AppDelegate.h"
#import "Person.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

- (void) displayPerson:(Person*)person;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.people = [[NSMutableArray alloc] init];
    
    [self.people addObject:[Person createWithName:@"Dave" andAge:39]];
    [self.people addObject:[Person createWithName:@"Danny" andAge:6]];
    [self.people addObject:[Person createWithName:@"Ollie" andAge:4]];
    
    [self.tableView registerForDraggedTypes: [NSArray arrayWithObject: @"public.text"]];
    [self.tableView reloadData];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.people count];
}

- (id) tableView:(NSTableView *)tableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
             row:(NSInteger)row
{
    return [[self.people objectAtIndex:row] name];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger row = [self.tableView selectedRow];
    [self displayPerson:[self.people objectAtIndex:row]];
}

#pragma mark - Drag & Drop

- (id <NSPasteboardWriting>)tableView:(NSTableView *)tableView pasteboardWriterForRow:(NSInteger)row
{
    Person *person = (Person *)[self.people objectAtIndex:row];
    NSString *identifier = person.name;
    
    NSPasteboardItem *pboardItem = [[NSPasteboardItem alloc] init];
    [pboardItem setString:identifier forType: @"public.text"];
    
    return pboardItem;
}

- (NSDragOperation) tableView:(NSTableView *)tableView
                 validateDrop:(id<NSDraggingInfo>)info
                  proposedRow:(NSInteger)row
        proposedDropOperation:(NSTableViewDropOperation)dropOperation
{
    return NSDragOperationMove;
}

- (BOOL)tableView:(NSTableView *)tableView
       acceptDrop:(id<NSDraggingInfo>)info
              row:(NSInteger)row
    dropOperation:(NSTableViewDropOperation)dropOperation
{
    
    NSPasteboard *p = [info draggingPasteboard];
    NSString *title = [p stringForType:@"public.text"];
    
    Person* person;
    NSInteger srcIndex;
    
    for (srcIndex = 0; srcIndex < [self.people count]; srcIndex++)
    {
        person = [self.people objectAtIndex:srcIndex];
        if ([person.name isEqualToString:title]) {
            break;
        }
        person = nil;
    }
    
    if(!person){
        // Not found
        return NO;
    }
    
    [self.people removeObjectAtIndex:srcIndex];
    if (row < [self.people count]) {
        [self.people insertObject:person atIndex:row];
    } else {
        [self.people addObject:person];
    }
    [self displayPerson:person];
    
    return YES;
}

- (void) displayPerson:(Person*)person
{
    [self.name setStringValue:person.name];
    [self.age setIntegerValue:person.age];
}


@end
