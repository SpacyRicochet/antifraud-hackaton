//
//  AFHStepTwoViewController.h
//  AntiFraudeHackathon
//
//  Created by Michiel Boertjes on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AFHActivity.h"

@interface AFHStepTwoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *textField;
@property (strong, nonatomic) IBOutlet UIButton *websiteBtn;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) BOOL isStepThree;
@property (nonatomic, retain) AFHActivity *dataObject;

@end
