//
//  ViewController.m
//  FISiOSClass
//
//  Created by Basar Akyelli on 11/17/13.
//  Copyright (c) 2013 Basar Akyelli. All rights reserved.
//

#import "ViewController.h"
#import <RestKit/RestKit.h>
#import "MappingProvider.h"
#import "Student.h"


@interface ViewController ()
@property (nonatomic) NSArray *students;
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Students of FIS iOS 000";
    [self loadStudents];
}

-(void) loadStudents
{
    NSIndexSet *statusCodeSet = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKMapping *mapping = [MappingProvider studentMapping];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor
                                                responseDescriptorWithMapping:mapping
                                                method:RKRequestMethodAny
                                                pathPattern:@"/api/students"
                                                keyPath:@""
                                                statusCodes:statusCodeSet];
    
    NSURL *url = [NSURL URLWithString:@"http://bawindows:49316/api/students"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc]initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"%@",mappingResult.array);
        self.students = mappingResult.array;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        
    }];
    
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.students count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Student *student = self.students[indexPath.row];
    
    cell.textLabel.text = student.fullName;
    cell.imageView.image = [UIImage imageNamed:student.pictureFileName];
    
    
    return cell;
    
    
}

@end
