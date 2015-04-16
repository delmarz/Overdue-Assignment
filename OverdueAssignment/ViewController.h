//
//  ViewController.h
//  OverdueAssignment
//
//  Created by delmarz on 1/23/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"
#import "AddTaskViewController.h"
#import "DetailTaskViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AddTaskViewControllerDelegate, DetailTaskViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *taskObject;

- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender;

@end

