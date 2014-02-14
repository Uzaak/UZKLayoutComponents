//
//  UZKInputFieldView.m
//  UZKLayoutComponents
//
//  Created by Tiago Furlanetto on 2/14/14.
//  Copyright (c) 2014 Uzaak. All rights reserved.
//

#import "UZKInputFieldView.h"

@interface UZKInputFieldView ()

@property (nonatomic, strong) IBOutlet UILabel * upperLabel;
@property (nonatomic, strong) IBOutlet UILabel * placeholderLabel;

@property (nonatomic, strong) IBOutlet UITextField * textField;


@end

@implementation UZKInputFieldView

- (void)setUpperLabel:(UILabel *)upperLabel
{
    _upperLabel = upperLabel;
    [self resetLabels];
}

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel
{
    _placeholderLabel = placeholderLabel;
    [self resetLabels];
}


#pragma mark - Label Mechanics

- (void)sobeOLabel
{
    [UIView animateWithDuration:0.2f animations:^{
        self.upperLabel.alpha = 1;
        self.placeholderLabel.alpha = 0;
    }];
}

- (void)desceOLabel
{
    [UIView animateWithDuration:0.2f animations:^{
        self.upperLabel.alpha = 0;
        self.placeholderLabel.alpha = 1;
    }];
}

- (void)resetLabels
{
    self.upperLabel.alpha = 0;
    self.placeholderLabel.alpha = 1;
}


#pragma mark - TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //textfield vazio? sobe o label
    [self sobeOLabel];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //textfield vazio? desce o label
    [self desceOLabel];
}


@end