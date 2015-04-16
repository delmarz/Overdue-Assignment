//
//  AddTaskViewController.h
//  OverdueAssignment
//
//  Created by delmarz on 1/23/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"

@protocol AddTaskViewControllerDelegate <NSObject>

@required
-(void)addTask:(TaskObject *)taskObject;
-(void)didCancel;

@end


@interface AddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) id <AddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *taskTextField;
@property (strong, nonatomic) IBOutlet UITextView *descpTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) TaskObject *taskObject;


- (IBAction)addButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;



@end
