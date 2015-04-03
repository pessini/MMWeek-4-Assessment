//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"


@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;
@property NSManagedObjectContext *managedObjectContext;

@end

@implementation AddDogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;

    if (self.dog)
    {
        self.nameTextField.text = self.dog.name;
        self.breedTextField.text = self.dog.breed;
        self.colorTextField.text = self.dog.color;
    }
}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    if ([self.nameTextField.text isEqualToString:@""] ||
        [self.breedTextField.text isEqualToString:@""] ||
        [self.colorTextField.text isEqualToString:@""])
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Missing Something"
                                                          message:@"Please, all fields are required."
                                                         delegate:self
                                                cancelButtonTitle:@"Ok"
                                                otherButtonTitles:nil, nil];
        [message show];
    }
    else
    {
        if (!self.dog)
        {
            self.dog = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Dog class]) inManagedObjectContext:self.managedObjectContext];
            // add a new dog to a person
            [self.dogOwner addDogsObject:self.dog];

        }

        self.dog.name = self.nameTextField.text;
        self.dog.breed = self.breedTextField.text;
        self.dog.color = self.colorTextField.text;

        [self.managedObjectContext save:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
