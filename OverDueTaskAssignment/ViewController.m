//
//  ViewController.m
//  OverDueTaskAssignment
//
//  Created by Arun Singh Chauhan on 6/8/17.
//  Copyright © 2017 Arun Singh Chauhan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"in Viw Did Load View Controller");
    // Do any additional setup after loading the view, typically from a nib.
    self.taskObjects = [[NSMutableArray alloc] init];
    NSMutableArray* taskObjectAsDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:TASKLIST] mutableCopy];
    NSLog(@"%@",taskObjectAsDictionary);
    for (id taskObject in taskObjectAsDictionary){
        NSLog(@"printing task object to be added %@",taskObject);
        NSLog(@"print in converted object %@",[self DictionaryToTaskObject:taskObject].title);
        [self.taskObjects addObject:[self DictionaryToTaskObject:taskObject]];
        NSLog(@"in taskObject add object loop %li",[self.taskObjects count]);
        
    }
        self.TableView.delegate = self;
        self.TableView.dataSource = self;
    NSLog(@"task objects count %li",[self.taskObjects count]);
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"in prepare for segue");
    if([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]){
        NSLog(@"in prepare for segue addTaskController");
        AddTaskViewController* addTask = segue.destinationViewController;
        addTask.delegate = self;
    }
    if([segue.destinationViewController isKindOfClass:[DeatilTaskViewController class]]){
        DeatilTaskViewController* detailController = segue.destinationViewController;
        detailController.taskobject = (TaskObject*)sender;
        detailController.delegate = self;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSDictionary *)taskObjectAsPropertyList:(TaskObject *)taskObject{
    NSDictionary* taskAsDictionary = @{TITLE : taskObject.title, DESCRIPTION : taskObject.descript, DATE : taskObject.date, COMPLETION : [NSNumber numberWithBool:taskObject.completion]};
    return taskAsDictionary;
}

-(TaskObject*)DictionaryToTaskObject:(NSDictionary*) dictionary{
    TaskObject* object = [[TaskObject alloc] init];
    object.title = [dictionary objectForKey:TITLE];
    object.descript = [dictionary objectForKey:DESCRIPTION];
    object.date = [dictionary objectForKey:DATE];
    object.completion = [(NSNumber*)([dictionary objectForKey:COMPLETION]) boolValue] ;
    return object;
}

#pragma - mark method for addTaskDelegate

-(void)didCancel{
    NSLog(@"in did cancel delegated method");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddTask:(TaskObject *)task{
    NSLog(@"in add task delegated method");
    [self.taskObjects addObject:task];
    NSMutableArray* taskObjectsAsDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:TASKLIST] mutableCopy];
    if(!taskObjectsAsDictionary) taskObjectsAsDictionary = [[NSMutableArray alloc] init];
    NSLog(@"in add task dictionary object %@",[self taskObjectAsPropertyList:task]);
    [taskObjectsAsDictionary addObject:[self taskObjectAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsDictionary forKey:TASKLIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.TableView reloadData];
}

#pragma marks - methods for table view delegate and dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.taskObjects count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"in cell for row at index path");
    static NSString* cellIdentifier = @"taskObjectCell";
    UITableViewCell* cell = [self.TableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSLog(@"this is task object %@",((TaskObject*)([self.taskObjects objectAtIndex:indexPath.row])));
    cell.textLabel.text = ((TaskObject*)([self.taskObjects objectAtIndex:indexPath.row])).title;
    cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:((TaskObject*)([self.taskObjects objectAtIndex:indexPath.row])).date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    
    if(((TaskObject*)([self.taskObjects objectAtIndex:indexPath.row])).completion){
        cell.backgroundColor = [UIColor greenColor];
    }else{
        if([self isDatePassedCurrentDate:((TaskObject*)([self.taskObjects objectAtIndex:indexPath.row])).date]){
            NSLog(@"in if");
            cell.backgroundColor = [UIColor yellowColor];
        }
        else{
            NSLog(@"in else");
         cell.backgroundColor = [UIColor redColor];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskObject* selectedTask = [self.taskObjects objectAtIndex:indexPath.row];
    [self updateCompletionOfTask:selectedTask forIndexPath:indexPath];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.taskObjects removeObjectAtIndex:indexPath.row];
    [self persistTaskObjects:self.taskObjects];
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if(((TaskObject*)[self.taskObjects objectAtIndex:indexPath.row]).completion){
        return YES;
    }else return NO;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    TaskObject* tempTaskObject;
    if(sourceIndexPath.row<destinationIndexPath.row){
        tempTaskObject = [self.taskObjects objectAtIndex:sourceIndexPath.row];
        for(long i = sourceIndexPath.row; i < destinationIndexPath.row; i++){
            [self.taskObjects replaceObjectAtIndex:i withObject:[self.taskObjects objectAtIndex:i+1]];
        }
    }else{
        tempTaskObject = [self.taskObjects objectAtIndex:sourceIndexPath.row];
        for (long i = sourceIndexPath.row; i > destinationIndexPath.row; i--) {
            [self.taskObjects replaceObjectAtIndex:i withObject:[self.taskObjects objectAtIndex:i-1]];
        }
    }
    [self.taskObjects replaceObjectAtIndex:destinationIndexPath.row withObject:tempTaskObject];
    [self persistTaskObjects:self.taskObjects];
}
-(void)didSaveFromDetail:(TaskObject *)taskObject{
    NSLog(@"in didSaveFromDetails delegate method from deatil view Controller");
    [self persistTaskObjects:self.taskObjects];
}

#pragma marks - helper Methods

-(BOOL)isDatePassedCurrentDate:(NSDate*)date{
    NSLog(@"time interval %f",[date timeIntervalSinceNow]);
    if([date timeIntervalSinceNow]>0 )
        return YES;
    else
        return NO;
}
-(void)updateCompletionOfTask:(TaskObject *)task forIndexPath:(NSIndexPath *)indexPath{
    task.completion = YES;
    NSMutableArray* taskAsDictionaryList = [[NSMutableArray alloc] init];
    [self.taskObjects replaceObjectAtIndex:indexPath.row withObject:task];
    for (TaskObject* task in self.taskObjects){
        [taskAsDictionaryList addObject:[self taskObjectAsPropertyList:task]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:taskAsDictionaryList forKey:TASKLIST];
    [self.TableView reloadData];
}
-(void)persistTaskObjects:(NSMutableArray*) taskObjects{
    NSMutableArray* taskAsDictionaryList = [[NSMutableArray alloc] init];
    for (TaskObject* task in self.taskObjects){
        [taskAsDictionaryList addObject:[self taskObjectAsPropertyList:task]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:taskAsDictionaryList forKey:TASKLIST];
    [self.TableView reloadData];
}


#pragma marks - button pressed methods

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"addTaskSegue" sender:nil];
}

- (IBAction)ReorderButtonPressed:(UIBarButtonItem *)sender {
    if(!self.TableView.isEditing){
        self.TableView.editing = YES;
    }else self.TableView.editing = NO;
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"DetailsTaskSegue" sender:[self.taskObjects objectAtIndex:indexPath.row]];
}

@end
