//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSManagedObjectContext *managedObjectContext;
@property NSMutableArray *dogsArray;
@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadDogs];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: UPDATE THIS ACCORDINGLY
    return self.dogsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    Dog *dog = self.dogsArray[indexPath.row];

    cell.textLabel.text = dog.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Breed: %@ - Color: %@", dog.breed, dog.color];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObject *dog = self.dogsArray[indexPath.row];
        [self.managedObjectContext deleteObject:dog];
        [self.managedObjectContext save:nil];
        [self loadDogs];
    }
}

#pragma mark -Helper Methods

-(void)loadDogs
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Dog class])];
    NSPredicate *dogsPredicate = [NSPredicate predicateWithFormat:@"ANY owner == %@",self.person.objectID];
    [request setPredicate:dogsPredicate];
    self.dogsArray = [[self.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    [self.dogsTableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    AddDogViewController *vc = segue.destinationViewController;

    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        vc.dogOwner = self.person;
        vc.dog = nil;
    }
    else if ([segue.identifier isEqualToString:@"ShowDogToEditSegue"])
    {
        UITableViewCell *cell = sender;
        Dog *selected = [self.dogsArray objectAtIndex:[self.dogsTableView indexPathForCell:cell].row];
        vc.dog = selected;
    }
}

@end
