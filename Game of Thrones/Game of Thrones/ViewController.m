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

@interface ViewController ()

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
    [self addControl:self.name underControl:nil withHeightUnits:1 andLabelText:@"Nombre"];
}

- (void)setUpBiografyInput {
    self.biografy = [UITextView new];
    [self addControl:self.biografy underControl:self.name withHeightUnits:3 andLabelText:@"Biografía"];
}

- (void)setUpHouse {
    self.house = [[UISegmentedControl alloc] initWithItems:@[@"Stark", @"Lannister", @"Targaryen", @"Baratheon"]];
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
    [self.saveButton setTitle:@"Guardar" forState:UIControlStateNormal];
    [self.saveButton setTitle:@"Rellena todos los campos" forState:UIControlStateDisabled];
    
    [self addControl:self.saveButton underControl:self.kill.superview withHeightUnits:1];
}

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