//
//  Person.h
//  Assessment4
//
//  Created by Leandro Pessini on 4/3/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *dogs;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addDogsObject:(NSManagedObject *)value;
- (void)removeDogsObject:(NSManagedObject *)value;
- (void)addDogs:(NSSet *)values;
- (void)removeDogs:(NSSet *)values;

+ (NSArray *)retrieveDogOwnersFromAPI;



@end
