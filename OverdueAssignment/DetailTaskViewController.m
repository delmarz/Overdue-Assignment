//
//  DetailTaskViewController.m
//  OverdueAssignment
//
//  Created by delmarz on 1/23/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "DetailTaskViewController.h"
#import "EditDetailTaskViewController.h"


@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    
    self.taskTitleLabel.text = self.taskObject.task;
    self.descrpTitleLabel.text = self.taskObject.descrp;
    self.dateTitleLabel.text = [self toString:self.taskObject.date];
    
    
    
}


#pragma mark - Helpers

-(NSString *)toString:(NSDate *)date
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.destinationViewController isKindOfClass:[EditDetailTaskViewController class]]) {
        EditDetailTaskViewController *editDetailTaskVC = segue.destinationViewController;
        editDetailTaskVC.taskObject = self.taskObject;
        editDetailTaskVC.delegate = self;
        
        
    }
    
}

#pragma mark - EditDetailTaskViewController Delegate

-(void)didUpdateTask
{
    
    self.taskTitleLabel.text = self.taskObject.task;
    self.descrpTitleLabel.text = self.taskObject.descrp;
    self.dateTitleLabel.text = [self toString:self.taskObject.date];
    [self.navigationController popViewControllerAnimated:true];
    [self.delegate updateTask];
}


- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"showEditDetailTask" sender:self];
}
@end
