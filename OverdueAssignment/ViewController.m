//
//  ViewController.m
//  OverdueAssignment
//
//  Created by delmarz on 1/23/15.
//  Copyright (c) 2015 delmarz. All rights reserved.
//

#import "ViewController.h"
#import "AddTaskViewController.h"
#import "PrefixHeader.pch"
#import "DetailTaskViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(NSMutableArray *)taskObject
{
    if (!_taskObject) {
        _taskObject = [[NSMutableArray alloc] init];
    }
    return _taskObject;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSArray *myTaskObjectAsPropertyList = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY];
    for (NSDictionary *dictionary in myTaskObjectAsPropertyList) {
        TaskObject *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObject addObject:taskObject];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"showAddTask" sender:self];
    
}

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender
{
    
    if (self.tableView.editing == YES) {
        [self.tableView setEditing:false animated:true];
    }
    else {
        [self.tableView setEditing:true animated:true];
    }
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        AddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    else if ([segue.destinationViewController isKindOfClass:[DetailTaskViewController class]]){
        DetailTaskViewController *detailTaskVC = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        TaskObject *selectedObject = [self.taskObject objectAtIndex:indexPath.row];
        detailTaskVC.taskObject = selectedObject;
        detailTaskVC.delegate = self;
        
    }
    
    
}

#pragma mark - AddTaskViewController Delegate

-(void)addTask:(TaskObject *)taskObject
{

    [self.taskObject addObject:taskObject];
    
    NSMutableArray *taskObjectAsPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY] mutableCopy];
    if (!taskObjectAsPropertyList) {
        taskObjectAsPropertyList = [[NSMutableArray alloc] init];
    }
    [taskObjectAsPropertyList addObject:[self taskObjectAsPropertyList:taskObject]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsPropertyList forKey:TASK_OBJECT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:true completion:nil];
    
}

-(void)didCancel
{
    
     [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - DetatilTaskViewController Delegate

-(void)updateTask
{
    [self saveTask];
    [self.tableView reloadData];
    
}

#pragma mark - Helper Methods

-(NSString *)toString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;

}

-(void)updateCompletionOfTask:(TaskObject *)taskObject forIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *taskObjectAsPropertyLits = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY] mutableCopy];
    if (!taskObjectAsPropertyLits) {
        taskObjectAsPropertyLits = [[NSMutableArray alloc] init];
    }
    [taskObjectAsPropertyLits removeObjectAtIndex:indexPath.row];
    
    if (taskObject.completed == YES) {
        taskObject.completed = NO;
    }else{
        taskObject.completed = YES;
    }
    [taskObjectAsPropertyLits insertObject:[self taskObjectAsPropertyList:taskObject] atIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsPropertyLits forKey:TASK_OBJECT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
    
}
         
         
-(NSDictionary *)taskObjectAsPropertyList:(TaskObject *)taskObject
{
    
    NSDictionary *dictionary = @{TASK_TITLE: taskObject.task,
                                 TASK_COMPLETED: @(taskObject.completed),
                                 TASK_DATE: taskObject.date,
                                 TASK_DESCRIPTION: taskObject.descrp };
    
    return dictionary;
}


-(TaskObject *)taskObjectForDictionary:(NSDictionary *)dictionary
{
    
    TaskObject *taskObject = [[TaskObject alloc] initWithData:dictionary];
    return taskObject;
    
}


-(void)saveTask
{
    
    NSMutableArray *taskObjectAsPropertyList = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.taskObject count]; x++) {
        [taskObjectAsPropertyList addObject:[self taskObjectAsPropertyList:self.taskObject[x]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsPropertyList forKey:TASK_OBJECT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if (dateInterval > toDateInterval) {
        return YES;
    }
    else {
        return NO;
    }
    
    
}


#pragma mark - UITableView Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.taskObject count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    TaskObject *task = self.taskObject[indexPath.row];
    
    cell.textLabel.text = task.task;
    cell.detailTextLabel.text = [self toString:task.date];
    
    BOOL isOverdue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
    
    if (task.completed == YES) {
        cell.backgroundColor = [UIColor greenColor];
    }
    
   else if (isOverdue == YES) {
        cell.backgroundColor = [UIColor redColor];
    }
    else {
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    
    return cell;
}


#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetailTask" sender:indexPath];
    
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    TaskObject *task = [self.taskObject objectAtIndex:sourceIndexPath.row];
    [self.taskObject removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObject insertObject:task atIndex:destinationIndexPath.row];
    [self saveTask];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskObject *taskObject = [self.taskObject objectAtIndex:indexPath.row];
    [self updateCompletionOfTask:taskObject forIndexPath:indexPath];
    
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.taskObject removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskObjectData = [[NSMutableArray alloc] init];
        for (TaskObject *task in self.taskObject) {
            [newTaskObjectData addObject:[self taskObjectAsPropertyList:task]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectData forKey:TASK_OBJECT_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
}


@end
