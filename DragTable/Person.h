//
//  Person.h
//  DragTable
//
//  Created by Dave Kennedy on 22/05/2015.
//  Copyright (c) 2015 Dave Kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCopying>

@property NSString* name;
@property NSInteger age;

+ (instancetype) createWithName:(NSString*)name andAge:(NSInteger)age;

@end
