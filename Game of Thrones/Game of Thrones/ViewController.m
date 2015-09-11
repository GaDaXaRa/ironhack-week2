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
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 3 * margin, self.screenSize.width - 2 * padding, heightUnit)];
    nameLabel.text = @"Nombre";
    [self.view addSubview:nameLabel];
    
    self.name = [[UITextField alloc] initWithFrame:[self frameWithNumberOfHeightsUnits:1 relativeToView:nameLabel]];
    self.name.borderStyle = UITextBorderStyleRoundedRect;
    self.name.placeholder = @"Nombre";
    [self.view addSubview:self.name];
}

- (void)setUpBiografyInput {
    UILabel *biografyLabel = [[UILabel alloc] initWithFrame:[self frameWithNumberOfHeightsUnits:1 relativeToView:self.name]];
    biografyLabel.text = @"Biografía";
    [self.view addSubview:biografyLabel];
    
    self.biografy = [[UITextView alloc] initWithFrame:[self frameWithNumberOfHeightsUnits:2 relativeToView:biografyLabel]];
    [self.view addSubview:self.biografy];
}

- (void)setUpHouse {
    self.house = [[UISegmentedControl alloc] initWithItems:@[@"Stark", @"Lannister", @"Targaryen", @"Baratheon"]];
    self.house.frame = [self frameWithNumberOfHeightsUnits:1 relativeToView:self.biografy];
    
    [self.view addSubview:self.house];
}

- (void)setUpEvilness {
    UILabel *evilnessLabel = [[UILabel alloc] initWithFrame:[self frameWithNumberOfHeightsUnits:1 relativeToView:self.house]];
    evilnessLabel.text = @"Maldad";
    [self.view addSubview:evilnessLabel];
    
    self.evilness = [[UISlider alloc] initWithFrame:[self frameWithNumberOfHeightsUnits:1 relativeToView:evilnessLabel]];
    self.evilness.minimumValue = 0;
    self.evilness.maximumValue = 100;
    self.evilness.minimumTrackTintColor = [UIColor redColor];
    self.evilness.maximumTrackTintColor = [UIColor greenColor];
    [self.view addSubview:self.evilness];
}

- (void)setUpKill {
    UIView *killView = [[UIView alloc] initWithFrame:[self frameWithNumberOfHeightsUnits:1 relativeToView:self.evilness]];
    self.kill = [[UISwitch alloc] initWithFrame:CGRectMake(killView.bounds.origin.x, killView.bounds.origin.y, 0, killView.bounds.size.height)];
    [killView addSubview:self.kill];
    
    self.deadOrAliveLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.kill.frame.size.width + padding, killView.bounds.origin.y, killView.bounds.size.width / 2 - padding, self.kill.frame.size.height)];
    self.deadOrAliveLabel.text = @"Vivo";
    [killView addSubview:self.deadOrAliveLabel];
    [self.view addSubview:killView];
}

- (void)setUpSaveButton {
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.saveButton.frame = [self frameWithNumberOfHeightsUnits:1 relativeToView:self.kill.superview];
    [self.saveButton setTitle:@"Guardar" forState:UIControlStateNormal];
    [self.saveButton setTitle:@"Rellena todos los campos" forState:UIControlStateDisabled];
    
    [self.view addSubview:self.saveButton];
}

- (CGRect)frameWithNumberOfHeightsUnits:(NSUInteger)heightUnitis relativeToView:(UIView *)view {
    return CGRectMake(padding, view.frame.size.height + view.frame.origin.y + margin, self.screenSize.width - 2 * padding, heightUnitis * heightUnit);
}

@end