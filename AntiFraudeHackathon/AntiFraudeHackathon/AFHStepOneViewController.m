//
//  AFHStepOneViewController.m
//  AntiFraudeHackathon
//
//  Created by Michiel Boertjes on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHStepOneViewController.h"
#import "AFHAditionalDataHelper.h"

@interface AFHStepOneViewController ()

@end

@implementation AFHStepOneViewController
{
    NSDictionary *_dict;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_verstuurMeldingBtn addTarget:self action:@selector(verstuurButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _verstuurMeldingBtn.layer.cornerRadius = 5;
    _websiteBtn.layer.cornerRadius = 5;
    [_websiteBtn addTarget:self action:@selector(websiteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.title = @"1. Controleer";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _dict = [AFHAditionalDataHelper dictForKey:self.dataObject.event];
    _textField.text = [_dict textForStep:@1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    
    annotation.title = _dataObject.accessor;
    annotation.coordinate = [_dict locationForStep:@1];
    
    [_mapView addAnnotation:annotation];
    [_mapView showAnnotations:@[annotation] animated:YES];
    [_mapView selectAnnotation:annotation animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)websiteBtnPressed:(UIButton *)button
{
    [[UIApplication sharedApplication] openURL:[_dict urlForStep:@1]];
}

- (void)verstuurButtonPressed:(UIButton *)button
{
    self.dataObject.flaggedValue = YES;
}

@end
