//
//  TaskObject.h
//  OverdueAssignment
//
//  Created by delmarz on 1/23/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskObject : NSObject

@property (strong, nonatomic) NSString *task;
@property (strong, nonatomic) NSString *descrp;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completed;

-(id)initWithData:(NSDictionary *)data;




@end
