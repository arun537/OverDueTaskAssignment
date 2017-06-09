//
//  AddTaskViewController.m
//  OverDueTaskAssignment
//
//  Created by Arun Singh Chauhan on 6/8/17.
//  Copyright © 2017 Arun Singh Chauhan. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
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

- (IBAction)CancelButtonPressed:(UIButton *)sender {
    NSLog(@"cancel button pressed");
    [self.delegate didCancel];
}

- (IBAction)AddTaskButtonPressed:(UIButton *)sender {
    NSLog(@"add task button pressed");
    TaskObject* task = [self taskObjectFromFrontEnd];
    [self.delegate didAddTask:task];
}

#pragma mark - Helper Method

-(TaskObject*)taskObjectFromFrontEnd{
    TaskObject* task = [[TaskObject alloc] init];
    task.title = self.taskNameTextField.text;
    task.descript = self.TaskDescriptionTextView.text;
    task.date = self.TaskDatePicker.date;
    task.completion = NO;
    NSLog(@"%@",task.title);
    return task;
}

@end
