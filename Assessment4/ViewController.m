//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "DogsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;

    [self loadColorDefault];
    [self loadDogOwners];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogOwners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    Person *person = self.dogOwners[indexPath.row];
    cell.textLabel.text = person.name;
    return cell;
}

#pragma mark -Helper Methods

-(void)loadDogOwners
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Person class])];
    self.dogOwners = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self.myTableView reloadData];
}

-(void)loadColorDefault
{
    NSData *buttonColor = [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultColor"];
    if (buttonColor)
    {
        self.navigationController.navigationBar.tintColor = [NSKeyedUnarchiver unarchiveObjectWithData:buttonColor];
    }
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    UIColor *defaultColor;

    if (buttonIndex == 0)
    {
        defaultColor = [UIColor purpleColor];
    }
    else if (buttonIndex == 1)
    {
        defaultColor = [UIColor blueColor];
    }
    else if (buttonIndex == 2)
    {
        defaultColor = [UIColor orangeColor];
    }
    else if (buttonIndex == 3)
    {
        defaultColor = [UIColor greenColor];
    }

    self.navigationController.navigationBar.tintColor = defaultColor;

    NSData *buttonColor = [NSKeyedArchiver archivedDataWithRootObject:defaultColor];
    [[NSUserDefaults standardUserDefaults] setObject:buttonColor forKey:@"defaultColor"];

}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell
{
    if ([segue.identifier isEqualToString:@"ShowDogListSegue"])
    {
        DogsViewController *vc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
        Person *person = [self.dogOwners objectAtIndex:indexPath.row];
        vc.person = person;
    }
}

@end
