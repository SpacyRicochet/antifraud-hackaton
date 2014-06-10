//
//  AFHStepTwoViewController.m
//  AntiFraudeHackathon
//
//  Created by Michiel Boertjes on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHStepTwoViewController.h"
#import "AFHAdditionalDataHelper.h"

@interface AFHStepTwoViewController ()

@end

@implementation AFHStepTwoViewController
{
    NSDictionary *_dict;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _websiteBtn.layer.cornerRadius = 5;

    [_websiteBtn addTarget:self action:@selector(websiteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = _isStepThree ? @"3. Extra" : @"2. Rapporteer";
    _dict = [AFHAdditionalDataHelper dictForKey:self.dataObject.event];
    _textField.text = [_dict textForStep:(_isStepThree ? @3 : @2)];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    
    annotation.title = _dataObject.accessor;
    annotation.coordinate = [_dict locationForStep:(_isStepThree ? @3 : @2)];
    
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
    [[UIApplication sharedApplication] openURL:[_dict urlForStep:(_isStepThree ? @3 : @2)]];
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
