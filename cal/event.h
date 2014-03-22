//
//  event.h
//  cal
//
//  Created by Shreenidhi Bhat on 3/20/14.
//  Copyright (c) 2014 Shreenidhi Bhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface event : NSObject

@property NSString * summary;
@property NSString * location;
@property NSString * description;
@property NSString * categories;

@property NSString * dtStart;
@property NSString * dtEnd;
@property NSString * dtStamp;
@property NSString * classType;

@property NSString * uid;

@end
