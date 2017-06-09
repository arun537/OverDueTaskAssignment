//
//  ViewController.h
//  OverDueTaskAssignment
//
//  Created by Arun Singh Chauhan on 6/8/17.
//  Copyright © 2017 Arun Singh Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "DeatilTaskViewController.h"
#import "TaskObject.h"

@interface ViewController : UIViewController <AddTaskViewControllerDelegate, UITableViewDelegate, UITableViewDataSource,detailTaskViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) NSMutableArray* taskObjects;
- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)ReorderButtonPressed:(UIBarButtonItem *)sender;



@end

