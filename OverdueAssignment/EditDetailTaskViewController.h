//
//  EditDetailTaskViewController.h
//  OverdueAssignment
//
//  Created by delmarz on 1/23/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"


@protocol EditDetailTaskViewControllerDelegate <NSObject>

@required
-(void)didUpdateTask;

@end


@interface EditDetailTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) id <EditDetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *taskTextField;
@property (strong, nonatomic) IBOutlet UITextView *descpTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) TaskObject *taskObject;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;



@end
