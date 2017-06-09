//
//  EditTaskViewController.m
//  OverDueTaskAssignment
//
//  Created by Arun Singh Chauhan on 6/8/17.
//  Copyright © 2017 Arun Singh Chauhan. All rights reserved.
//

#import "EditTaskViewController.h"
#import "DeatilTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.editTaskTextField.placeholder = self.taskObject.title;
    self.editTaskTextField.text = self.taskObject.title;
    self.EditTaskTextView.text = self.taskObject.descript;
    self.editTaskDatePicker.date = self.taskObject.date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)SaveButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"in save Button Pressed in edit Details");
    self.taskObject.title = self.editTaskTextField.text;
    self.taskObject.descript = self.EditTaskTextView.text;
    self.taskObject.date = self.editTaskDatePicker.date;
    [self.delegate didSave:self.taskObject];
}
@end
