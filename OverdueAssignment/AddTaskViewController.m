//
//  AddTaskViewController.m
//  OverdueAssignment
//
//  Created by delmarz on 1/23/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

- (IBAction)addButtonPressed:(UIButton *)sender {
    
    [self.delegate addTask:[self returnNewTaskObject]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
    
    [self.delegate didCancel];
}




-(TaskObject *)returnNewTaskObject
{
    
    TaskObject *newTask = [[TaskObject alloc] init];
    
    newTask.task = self.taskTextField.text;
    newTask.descrp = self.descpTextView.text;
    newTask.date = self.datePicker.date;
    newTask.completed = NO;
    
    return newTask;
    
}



#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskTextField resignFirstResponder];
    return YES;
    
}




#pragma mark - UITextView Delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.descpTextView resignFirstResponder];
        return NO;
    }
    else{
        return YES;
    }
    
    
}



@end
