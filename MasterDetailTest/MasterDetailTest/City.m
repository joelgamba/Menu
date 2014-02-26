//
//  City.m
//  MasterDetailTest
//
//  Created by Rocky Camacho on 2/25/14.
//  Copyright (c) 2014 Rocky Camacho. All rights reserved.
//

#import "City.h"

@implementation City

- (id) initWithName:(NSString *) name {
    if(self = [super init]) {
        self.name = name;
    }
    return self;
}

@end
