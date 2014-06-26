//
//  Place.m
//  MapTable
//
//  Created by Ricardo Reyes on 6/20/14.
//  Copyright (c) 2014 iOS Coding Lab. All rights reserved.
//

#import "Place.h"

@implementation Place

- (instancetype)initWithName:(NSString *)name address:(NSString *)address
{
    self = [super init];
    
    if (self)
    {
        self.name = name;
        self.address = address;
    }
    
    return self;
}

@end
