//
//  UZKViewController.m
//  UZKLayoutComponents
//
//  Created by Tiago Furlanetto on 2/14/14.
//  Copyright (c) 2014 Uzaak. All rights reserved.
//

#import "UZKViewController.h"

@interface UZKViewController ()

@end

@implementation UZKViewController

- (void)setPbv:(UZKPickerButtonView *)pbv
{
    _pbv = pbv;
    _pbv.data = @[@"Maçãs", @"Bananas", @"Pêras", @"Pikachus"];
}

@end
