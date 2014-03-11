//
//  MapTablePlace.m
//  MapTable
//
//  Created by Laboratorio San Agustin on 8/03/14.
//  Copyright (c) 2014 Online Studio Productions LLC. All rights reserved.
//

#import "MapTablePlace.h"

@implementation MapTablePlace

- (instancetype)initWithName:(NSString *)name address:(NSString *)address andImage:(UIImage *)image
{
    self = [super init];
    
    if (self)
    {
        self.name = name;
        self.address = address;
        self.image = image;
    }
    return self;
}

@end
