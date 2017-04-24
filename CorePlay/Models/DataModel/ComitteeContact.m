//
//  ComitteeContact.m
//  AlKadi
//
//  Created by Ghafar Tanveer on 14/02/2017.
//  Copyright © 2017 Khurram Bilal Nawaz. All rights reserved.
//

#import "ComitteeContact.h"

@implementation ComitteeContact

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    
    return YES;
}
+(JSONKeyMapper*)keyMapper
{
    NSDictionary * dict = @{ @"Data"                        : @"contacts"
                             };
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:dict];
    //return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
@end
