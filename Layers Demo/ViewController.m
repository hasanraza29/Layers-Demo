//
//  ViewController.m
//  Layers Demo
//
//  Created by Hasan on 04/03/2015.
//  Copyright (c) 2015 Wasi Ahmed. All rights reserved.
//

#import "ViewController.h"
#import "LayersView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet LayersView *myLayerView;
@property (weak, nonatomic) IBOutlet UISlider *rowsSlider;
@property (weak, nonatomic) IBOutlet UISlider *colsSlider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)columnsChanged:(UISlider *)sender
{
    [self.myLayerView createCirclesWithRows:self.rowsSlider.value andColumns:sender.value];
    [self.myLayerView layoutIfNeeded];
}
- (IBAction)rowsChanged:(UISlider *)sender
{
    [self.myLayerView createCirclesWithRows:sender.value andColumns:self.colsSlider.value];
    [self.myLayerView layoutIfNeeded];
}

@end
