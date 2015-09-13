//
//  CharacterImageSelectorViewController.m
//  Game of Thrones
//
//  Created by Miguel Santiago Rodríguez on 12/9/15.
//  Copyright (c) 2015 Miguel Santiago Rodríguez. All rights reserved.
//

#import "CharacterImageSelectorViewController.h"
#import "CharacterPicturesDataSource.h"

@interface CharacterImageSelectorViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *saveButton;

@property (strong, nonatomic) CharacterPicturesDataSource *datasource;

@end

@implementation CharacterImageSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpImage];
    [self setUpInterface];
    [self setUpSaveButton];
}

- (void)setUpInterface {
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpPicker];
}

- (void)setUpImage {
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addControl:self.imageView underControl:nil withHeightUnits:3 andLabelText:@"Selecciona una foto"];
}

- (void)setUpPicker {
    self.picker = [UIPickerView new];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    [self addControl:self.picker underControl:self.imageView withHeightUnits:4];
    [self.picker selectRow:0 inComponent:0 animated:NO];
    [self showImageForSelectedRowInPicker];
}

- (void)setUpSaveButton {
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.saveButton setTitle:@"Seleccionar" forState:UIControlStateNormal];
    [self addControl:self.saveButton underControl:self.picker withHeightUnits:1];
    [self.saveButton addTarget:self action:@selector(didPressSaveButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didPressSaveButton:(UIButton *)saveButton {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Picker datasource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self.datasource allCharactersImageNames] count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.datasource allCharactersImageNames] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self showImageForSelectedRowInPicker];
    [self notifyDidChooseImage];
}

- (void)showImageForSelectedRowInPicker {
    self.imageView.image = [UIImage imageNamed:[self imageNameForSelectedRow]];
}

- (void)notifyDidChooseImage {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectImageNotification" object:self userInfo:@{@"imageName":[self imageNameForSelectedRow]}];
}

- (NSString *)imageNameForSelectedRow {
    return [[self.datasource allCharactersImageNames] objectAtIndex:[self.picker selectedRowInComponent:0]];
}

- (CharacterPicturesDataSource *)datasource {
    if (!_datasource) {
        _datasource = [CharacterPicturesDataSource new];
    }
    
    return _datasource;
}

@end
