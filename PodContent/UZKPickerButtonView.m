//
//  UZKPickerButtonView.m
//  UZKLayoutComponents
//
//  Created by Tiago Furlanetto on 2/16/14.
//  Copyright (c) 2014 Uzaak. All rights reserved.
//

#import "UZKPickerButtonView.h"

@interface UZKPickerButtonView ()

@property (nonatomic, strong) IBOutlet UIButton * button;
@property (nonatomic, strong) UIPickerView * picker;

@property (nonatomic, strong) id selectedObject;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation UZKPickerButtonView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if ( self )
    {
        self.picker = [[UIPickerView alloc] init];
    }
    
    return self;
}

- (void)setData:(NSArray *)data
{
    _data = data;
    [self.picker reloadAllComponents];
}

- (void)setButton:(UIButton *)button
{
    _button = button;
    [_button addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setPicker:(UIPickerView *)picker
{
    _picker = picker;
    _picker.dataSource = self;
    _picker.delegate = self;
}

#pragma mark - Picker DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.data count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.data objectAtIndex:row] description];
}

#pragma mark - Picker Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedObject = [self.data objectAtIndex:row];
    [self.button setTitle:[self.selectedObject description] forState:UIControlStateNormal];
    
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                  target:self
                                                selector:@selector(dismissPicker)
                                                userInfo:nil
                                                 repeats:NO];
}

#pragma mark - Showing Picker Magicks

- (void)showPicker
{
    self.button.alpha = 0;
    
    float sizeHeight = self.button.frame.size.height;
    
    if ( sizeHeight > 216 )
    {
        sizeHeight = 216;
    }
    
    if ( sizeHeight < 162 )
    {
        sizeHeight = 162;
    }
    
    float yOffset = ( sizeHeight - self.button.frame.size.height ) / 2;
    
    self.picker.frame = CGRectMake(self.button.frame.origin.x, self.button.frame.origin.y - yOffset, self.button.frame.size.width, sizeHeight);
    
    [self addSubview:self.picker];
    [self.picker becomeFirstResponder];
}

- (void)dismissPicker
{
    [self.picker resignFirstResponder];
    [self.picker removeFromSuperview];
    self.button.alpha = 1;
}

@end
