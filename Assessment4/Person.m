//
//  Person.m
//  Assessment4
//
//  Created by Leandro Pessini on 4/3/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Person.h"


@implementation Person

@dynamic name;
@dynamic dogs;

+ (NSArray *)retrieveDogOwnersFromAPI
{
    NSString *urlString =[NSString stringWithFormat:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data)
    {
        NSArray *person = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        return person;
    }
    else
    {
        return nil;
    }
}

@end
