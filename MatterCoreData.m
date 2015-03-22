//
//  MatterCoreData.m
//  TimeMaster
//
//  Created by GX on 15/2/4.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "MatterCoreData.h"
#import "AppDelegate.h"

@implementation MatterCoreData


+ (NSArray *)getAllMatter {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Matter"];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    for (NSManagedObject *oneObject in objects) {
        MatterModel *matter = [[MatterModel alloc] initWithName:[oneObject valueForKey:@"name"] andDate:[oneObject valueForKey:@"time"]];
        [array addObject:matter];
    }
    return array;
}

+ (BOOL)addToCoreData:(MatterModel *)matter {
    BOOL successNo = NO;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Matter"];
    NSError *error;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(%K = %@)",@"name",matter.name];
    [request setPredicate:pred];
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] > 0) {
        NSLog(@"已存在，时间已更新");
        NSManagedObject *oneObject = [objects objectAtIndex:0];
        [oneObject setValue:matter.name forKey:@"name"];
        [oneObject setValue:matter.date forKey:@"time"];
        successNo = YES;
    } else {
        NSManagedObject *oneObject = [NSEntityDescription insertNewObjectForEntityForName:@"Matter" inManagedObjectContext:context];
        [oneObject setValue:matter.name forKey:@"name"];
        [oneObject setValue:matter.date forKey:@"time"];
        successNo = YES;
    }
    [appDelegate saveContext];
    return successNo;
}

+ (BOOL)deleteFromCoreData:(MatterModel *)matter {
    BOOL successNo;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Matter"];
    
    NSError *error;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(%K = %@)",@"name",matter.name];
    [request setPredicate:pred];
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] > 0) {
        NSLog(@"删除成功");
        [context deleteObject:[objects objectAtIndex:0]];
        successNo = YES;
    } else {
        successNo = NO;
        NSLog(@"没有此项");
    }
    [appDelegate saveContext];
    return successNo;
}

+ (MatterModel *)getTitleMatter {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Matter"];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    MatterModel *matter = nil;
    if ([objects count]!=0) {
        NSManagedObject *oneObject = [objects objectAtIndex:([objects count] - 1)];
        matter = [[MatterModel alloc] initWithName:[oneObject valueForKey:@"name"] andDate:[oneObject valueForKey:@"time"]];
    }
    return matter;
}
@end
