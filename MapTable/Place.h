//
//  Place.h
//  MapTable
//
//  Created by Ricardo Reyes on 6/20/14.
//  Copyright (c) 2014 iOS Coding Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;

- (instancetype)initWithName:(NSString *)name address:(NSString *)address;

@end