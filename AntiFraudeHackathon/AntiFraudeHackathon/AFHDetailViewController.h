//
//  AFHDetailViewController.h
//  AntiFraudeHackathon
//
//  Created by Jonas Treub on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AFHDataObject;

@interface AFHDetailViewController : UIViewController

@property (nonatomic, retain) AFHDataObject *dataObject;
@property (nonatomic, retain) UIImage *image;

@end
