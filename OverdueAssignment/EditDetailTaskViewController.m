//
//  EditDetailTaskViewController.m
//  OverdueAssignment
//
//  Created by delmarz on 1/23/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "EditDetailTaskViewController.h"

@interface EditDetailTaskViewController ()

@end

@implementation EditDetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskTextField.text = self.taskObject.task;
    self.descpTextView.text = self.taskObject.descrp;
    self.datePicker.date = self.taskObject.date;
    
    
    self.taskTextField.delegate = self;
    self.descpTextView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender
{
    
    [self newTaskObject];
    [self.delegate didUpdateTask];
}

-(void)newTaskObject
{
    
    self.taskObject.task = self.taskTextField.text;
    self.taskObject.descrp = self.descpTextView.text;
    self.taskObject.date = self.datePicker.date;
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskTextField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.descpTextView resignFirstResponder];
        return NO;
    }
    else {
        return YES;
    }
    
}




@end
