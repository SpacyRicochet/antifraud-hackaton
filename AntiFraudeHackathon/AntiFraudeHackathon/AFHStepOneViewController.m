//
//  AFHStepOneViewController.m
//  AntiFraudeHackathon
//
//  Created by Michiel Boertjes on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHStepOneViewController.h"

@interface AFHStepOneViewController ()

@end

@implementation AFHStepOneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_verstuurMeldingBtn addTarget:self action:@selector(verstuurButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _verstuurMeldingBtn.layer.cornerRadius = 5;
    _websiteBtn.layer.cornerRadius = 5;
    self.title = @"1. Controleer";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)verstuurButtonPressed:(UIButton *)button
{
    
}

- (void)viewWillAppear:(BOOL)animated
{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
