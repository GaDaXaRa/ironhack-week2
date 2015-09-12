//
//  ViewController.m
//  Game of Thrones
//
//  Created by Miguel Santiago Rodríguez on 11/9/15.
//  Copyright (c) 2015 Miguel Santiago Rodríguez. All rights reserved.
//

#import "ViewController.h"

static NSUInteger const padding = 16;
static NSUInteger const margin = 8;

static NSUInteger const heightUnit = 40;

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) UITextField *name;
@property (strong, nonatomic) UITextView *biografy;
@property (strong, nonatomic) UISwitch *kill;
@property (strong, nonatomic) UISegmentedControl *house;
@property (strong, nonatomic) UISlider *evilness;
@property (assign, nonatomic) CGSize screenSize;
@property (strong, nonatomic) UILabel *deadOrAliveLabel;
@property (strong, nonatomic) UIButton *saveButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenSize = self.view.frame.size;
    [self setUpInterface];
}

- (void)setUpInterface {
    [self setUpNameInput];
    [self setUpBiografyInput];
    [self setUpHouse];
    [self setUpEvilness];
    [self setUpKill];
    [self setUpSaveButton];
}

- (void)setUpNameInput {
    self.name = [UITextField new];
    self.name.borderStyle = UITextBorderStyleRoundedRect;
    self.name.placeholder = @"Nombre";
    self.name.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.name.delegate = self;
    [self assignImageNamed:@"baratheon" toTextFieldLeftView:self.name];
    [self addControl:self.name underControl:nil withHeightUnits:1 andLabelText:@"Nombre"];
}

- (void)assignImageNamed:(NSString *)imageName toTextFieldLeftView:(UITextField *)textField {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake(0, 0, 40, 40);
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = imageView;
}

- (void)setUpBiografyInput {
    self.biografy = [UITextView new];
    self.biografy.delegate = self;
    [self addBiografyPlaceHolder];
    [self addControl:self.biografy underControl:self.name withHeightUnits:3 andLabelText:@"Biografía"];
}

- (void)addBiografyPlaceHolder {
    self.biografy.textColor = [UIColor lightGrayColor];
    self.biografy.text = @"Añade la biografía del personaje";
    self.biografy.tag = 0;
}

- (void)setUpHouse {
    self.house = [[UISegmentedControl alloc] initWithItems:@[@"Stark", @"Lannister", @"Targaryen", @"Baratheon", @"Tully"]];
    [self.house setWidth:50 forSegmentAtIndex:0];
    [self.house setWidth:50 forSegmentAtIndex:4];
    [self.house addTarget:self action:@selector(houseChanged:) forControlEvents:UIControlEventValueChanged];
    [self addControl:self.house underControl:self.biografy withHeightUnits:1];
}

- (void)setUpEvilness {
    self.evilness = [UISlider new];
    self.evilness.minimumValue = 0;
    self.evilness.maximumValue = 100;
    self.evilness.minimumTrackTintColor = [UIColor redColor];
    self.evilness.maximumTrackTintColor = [UIColor greenColor];
    [self addControl:self.evilness underControl:self.house withHeightUnits:1 andLabelText:@"Maldad"];
}

- (void)setUpKill {
    UIView *killView = [[UIView alloc] initWithFrame:[self frameWithNumberOfHeightsUnits:1 relativeToFrame:self.evilness.frame]];
    self.kill = [[UISwitch alloc] initWithFrame:CGRectMake(killView.bounds.origin.x, killView.bounds.origin.y, 0, killView.bounds.size.height)];
    [killView addSubview:self.kill];
    
    self.deadOrAliveLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.kill.frame.size.width + padding, killView.bounds.origin.y, killView.bounds.size.width / 2 - padding, self.kill.frame.size.height)];
    self.deadOrAliveLabel.text = @"Vivo";
    [killView addSubview:self.deadOrAliveLabel];
    [self.view addSubview:killView];
}

- (void)setUpSaveButton {
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.saveButton setTitle:@"Añadir" forState:UIControlStateNormal];
    [self.saveButton setTitle:@"Rellena todos los campos" forState:UIControlStateDisabled];
    
    [self addControl:self.saveButton underControl:self.kill.superview withHeightUnits:1];
}

#pragma mark - House selection target/action

- (void)houseChanged:(UISegmentedControl *)housesSegmentedControl {
    switch (housesSegmentedControl.selectedSegmentIndex) {
        case 0:
            [self assignImageNamed:@"stark" toTextFieldLeftView:self.name];
            break;
        case 1:
            [self assignImageNamed:@"lannister" toTextFieldLeftView:self.name];
            break;
        case 2:
            [self assignImageNamed:@"targaryen" toTextFieldLeftView:self.name];
            break;
        case 3:
            [self assignImageNamed:@"baratheon" toTextFieldLeftView:self.name];
            break;
        case 4:
            [self assignImageNamed:@"tully" toTextFieldLeftView:self.name];
            break;
        default:
            break;
    }
    
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.name) {
        [self.saveButton setTitle:[NSString stringWithFormat:@"Añadir a %@", textField.text] forState:UIControlStateNormal];
    }
    
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (textView == self.biografy && textView.tag == 0) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (textView == self.biografy && [textView.text length] == 0) {
        [self addBiografyPlaceHolder];
    }
    
    [textView resignFirstResponder];
    
    return YES;
}

#pragma mark - Addind controls

- (void)addControl:(UIView *)bottomControl underControl:(UIView *)upperControl withHeightUnits:(NSUInteger)heightUnits andLabelText:(NSString *)labelText {
    UILabel *textLabel = [UILabel new];
    textLabel.font = [UIFont systemFontOfSize:12.0];
    textLabel.text = labelText;
    if (upperControl) {
        [self addControl:textLabel underControl:upperControl withHeightUnits:1];
    } else {
        [self addControl:textLabel underFrame:CGRectMake(0, 2 * margin, 0, 0) withHeightUnits:1];
    }
    
    [self addControl:bottomControl underControl:textLabel withHeightUnits:heightUnits];
}

- (void)addControl:(UIView *)bottomControl underControl:(UIView *)upperControl withHeightUnits:(NSUInteger)heightUnits {
    [self addControl:bottomControl underFrame:upperControl.frame withHeightUnits:heightUnits];
}

- (void)addControl:(UIView *)bottomControl underFrame:(CGRect)frame withHeightUnits:(NSUInteger)heightUnits {
    bottomControl.frame = [self frameWithNumberOfHeightsUnits:heightUnits relativeToFrame:frame];
    [self.view addSubview:bottomControl];
}

- (void)setHeightInUnits:(NSUInteger)heightUnits forControl:(UIView *)control {
    control.bounds = CGRectInset(control.bounds, heightUnits * heightUnit, CGRectGetWidth(control.bounds));
}

- (CGRect)frameWithNumberOfHeightsUnits:(NSUInteger)heightUnitis relativeToFrame:(CGRect)frame {
    return CGRectMake(padding, frame.size.height + frame.origin.y + margin, self.screenSize.width - 2 * padding, heightUnitis * heightUnit);
}

@end