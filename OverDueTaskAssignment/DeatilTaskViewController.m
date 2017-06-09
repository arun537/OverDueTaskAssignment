//
//  DeatilTaskViewController.m
//  OverDueTaskAssignment
//
//  Created by Arun Singh Chauhan on 6/8/17.
//  Copyright © 2017 Arun Singh Chauhan. All rights reserved.
//

#import "DeatilTaskViewController.h"

@interface DeatilTaskViewController ()

@end

@implementation DeatilTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.taskNameLabel.text = self.taskobject.title;
    self.TaskDiscriptionLabel.text = self.taskobject.descript;
    self.taskDatelabel.text = [NSDateFormatter localizedStringFromDate:self.taskobject.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
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
    if([segue.destinationViewController isKindOfClass:[EditTaskViewController class]]){
        EditTaskViewController* editViewController = segue.destinationViewController;
        editViewController.taskObject = (TaskObject*)sender;
        editViewController.delegate = self;
    }
    
}

#pragma mark - delegate methods

-(void)didSave:(TaskObject *)taskObject{
    self.taskobject = taskObject;
    NSLog(@"in didsave Method delegate method of editTaskViewController");
    self.taskNameLabel.text = self.taskobject.title;
    self.TaskDiscriptionLabel.text = self.taskobject.descript;
    self.taskDatelabel.text = [NSDateFormatter localizedStringFromDate:self.taskobject.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    [self.delegate didSaveFromDetail:self.taskobject];
    [self.navigationController popViewControllerAnimated:YES];
    [self.view setNeedsDisplay];
}



#pragma marks - Button Pressed Methods

- (IBAction)EditButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"detailsToEditSegue" sender:self.taskobject];
}
@end
