//
//  MappingProvider.m
//  FISiOSClass
//
//  Created by Basar Akyelli on 11/17/13.
//  Copyright (c) 2013 Basar Akyelli. All rights reserved.
//

#import "MappingProvider.h"
#import "Student.h"
\
@implementation MappingProvider

+ (RKMapping *) studentMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Student class]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                 @"Id": @"studentId",
                                                 @"FullName": @"fullName",
                                                 @"PictureFileName":@"pictureFileName"
                                                 }];
    
    return mapping;
    
}

@end
