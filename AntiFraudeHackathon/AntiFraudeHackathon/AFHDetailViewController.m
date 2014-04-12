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

@interface AFHDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation AFHDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    _descriptionLabel.text = _dataObject.description;
    _accessorLabel.text = _dataObject.accessor;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    _timeLabel.text = [dateFormatter stringFromDate:_dataObject.timeStamp];
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

- (void)setDataObject:(AFHDataObject *)dataObject
{
    _dataObject = dataObject;
}

@end