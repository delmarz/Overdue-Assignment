//
//  DetailTaskViewController.h
//  OverdueAssignment
//
//  Created by delmarz on 1/23/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"
#import "EditDetailTaskViewController.h"

@protocol DetailTaskViewControllerDelegate <NSObject>

@required
-(void)updateTask;

@end


@interface DetailTaskViewController : UIViewController <EditDetailTaskViewControllerDelegate>
@property (weak, nonatomic) id <DetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descrpTitleLabel;
@property (strong, nonatomic) TaskObject *taskObject;

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender;



@end
