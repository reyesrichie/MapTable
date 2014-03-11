//
//  MapTablePlace.h
//  MapTable
//
//  Created by Laboratorio San Agustin on 8/03/14.
//  Copyright (c) 2014 Online Studio Productions LLC. All rights reserved.
//

@import UIKit;

#import <Foundation/Foundation.h>

@interface MapTablePlace : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithName:(NSString *)name address:(NSString *)address andImage:(UIImage *)image;

@end
