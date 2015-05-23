//
//  Person.m
//  DragTable
//
//  Created by Dave Kennedy on 22/05/2015.
//  Copyright (c) 2015 Dave Kennedy. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize name, age;

+ (instancetype) createWithName:(NSString*)name andAge:(NSInteger)age
{
    Person* person = [[Person alloc] init];
    [person setName:name];
    [person setAge:age];
    return person;
}

- (id)copyWithZone:(NSZone *)zone
{
    Person* person = [[Person allocWithZone:zone] init];
    person.name = self.name;
    person.age = self.age;
    return person;
}
@end
