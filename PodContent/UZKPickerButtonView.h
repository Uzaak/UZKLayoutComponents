//
//  UZKPickerButtonView.h
//  UZKLayoutComponents
//
//  Created by Tiago Furlanetto on 2/16/14.
//  Copyright (c) 2014 Uzaak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UZKPickerButtonView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, readonly) id selectedObject;

@property (nonatomic) int fontSize;
@property (nonatomic) float selectionDelay;

@property (nonatomic, strong) id defaultValue;

@property (nonatomic, strong) void (^didSelectRowBlock)(id selectedItem);

- (void)resetSelection;

@end
