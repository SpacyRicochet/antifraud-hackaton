//
//  AFHDetailViewController.m
//  AntiFraudeHackathon
//
//  Created by Jonas Treub on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "AFHDetailViewController.h"
#import "AFHDataObject.h"
#import "AFHReportViewController.h"
#import "AFHAditionalDataHelper.h"

@interface AFHDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *databaseLabel;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *mainTextLabel;

@end

@implementation AFHDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    _descriptionLabel.text = _dataObject.event;
    _accessorLabel.text = _dataObject.accessor;
    _databaseLabel.text = _dataObject.database;
    NSDictionary *dict = [AFHAditionalDataHelper dictForKey:_dataObject.event];
    _mainTextLabel.text = [dict information];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    _timeLabel.text = [dateFormatter stringFromDate:_dataObject.date];
    [_icon setImage:_image];
    
    [_reportButton addTarget:self action:@selector(reportButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _reportButton.layer.cornerRadius = 5;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_dataObject.flaggedValue)
    {
        [_reportButton setTitle:@"Meer informatie" forState:UIControlStateNormal];
        _reportButton.backgroundColor = [UIColor colorWithRed:(19.f/255.f) green:(147.f/255.f) blue:(61.f/255.f) alpha:1.f];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    
    annotation.title = _dataObject.accessor;
    annotation.coordinate = CLLocationCoordinate2DMake(52.0114726,4.3544441);
    
    [_mapView addAnnotation:annotation];
    [_mapView showAnnotations:@[annotation] animated:YES];
    [_mapView selectAnnotation:annotation animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction

- (void)reportButtonPressed
{
    [self performSegueWithIdentifier:@"reportSegue" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AFHReportViewController *reportVC = [segue destinationViewController];
    reportVC.dataObject = _dataObject;
}

@end