//
//  UZKPickerButtonView.m
//  UZKLayoutComponents
//
//  Created by Tiago Furlanetto on 2/16/14.
//  Copyright (c) 2014 Uzaak. All rights reserved.
//

#import "UZKPickerButtonView.h"

@interface UZKPickerButtonView ()

@property (nonatomic, strong) NSString * defaultButtonText;

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
        
        self.fontSize = 17;
        self.selectionDelay = 1.0f;
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
    
    self.defaultButtonText = [self.button titleForState:UIControlStateNormal];
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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = (UILabel *)view;
    
    if ( ! label )
    {
        label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:self.fontSize];
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    label.text = [[self.data objectAtIndex:row] description];
    
    return label;
}

#pragma mark - Picker Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedObject = [self.data objectAtIndex:row];
    
    [self.button setTitle:[self.selectedObject description] forState:UIControlStateNormal];
    
    [self countdownToDoom];
    
    if ( self.didSelectRowBlock )
    {
        self.didSelectRowBlock(self.selectedObject);
    }
}

#pragma mark - Showing Picker Magicks

- (void)showPicker
{
    if ( ! self.selectedObject )
    {
        [self pickerView:self.picker didSelectRow:0 inComponent:0];
    }
    
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
    
    [self countdownToDoom];
}

- (void)dismissPicker
{
    [self.picker resignFirstResponder];
    [self.picker removeFromSuperview];
    self.button.alpha = 1;
}

- (void)countdownToDoom
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.selectionDelay
                                                  target:self
                                                selector:@selector(dismissPicker)
                                                userInfo:nil
                                                 repeats:NO];
}


#pragma mark - And to dust you shall return

- (void)resetSelection
{
    [self dismissPicker];
    self.selectedObject = nil;
    [self.button setTitle:self.defaultButtonText forState:UIControlStateNormal];
}


#pragma mark - Getters should Get

- (id)selectedObject
{
    if ( ! _selectedObject )
    {
        return _defaultValue;
    }
    
    return _selectedObject;
}


@end
