//
//  TaskObject.m
//  OverdueAssignment
//
//  Created by delmarz on 1/23/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "TaskObject.h"
#import "TaskObject.h"
#import "PrefixHeader.pch"

@implementation TaskObject



-(id)init
{
    self = [self initWithData:nil];
    return self;
}

-(id)initWithData:(NSDictionary *)data
{
    
    self = [super init];
    
    if (self) {
        
        self.task = data [TASK_TITLE];
        self.descrp = data [TASK_DESCRIPTION];
        self.date = data [TASK_DATE];
        self.completed = [data [TASK_COMPLETED] boolValue];
 
        
    }
    
    return self;
}





@end
