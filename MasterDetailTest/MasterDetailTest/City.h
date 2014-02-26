//
//  City.h
//  MasterDetailTest
//
//  Created by Rocky Camacho on 2/25/14.
//  Copyright (c) 2014 Rocky Camacho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (strong) NSString *name;
@property (assign) double latitude;
@property (assign) double longtitude;
@property (strong) NSMutableArray *weatherData;

- (id) initWithName:(NSString *) name;

@end
