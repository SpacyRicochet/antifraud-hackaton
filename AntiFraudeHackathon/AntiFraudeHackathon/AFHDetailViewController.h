//
//  AFHDetailViewController.h
//  AntiFraudeHackathon
//
//  Created by Jonas Treub on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHActivity.h"
@class AFHDataObject;

@interface AFHDetailViewController : UIViewController

@property (nonatomic, retain) AFHActivity *dataObject;
@property (nonatomic, retain) UIImage *image;

@end
