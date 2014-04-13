//
//  AFHReportViewController.m
//  AntiFraudeHackathon
//
//  Created by Jonas Treub on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHReportViewController.h"
#import "AFHDataObject.h"
#import "AFHStepOneViewController.h"
#import "AFHStepTwoViewController.h"
#import "AFHStepThreeViewController.h"

@interface AFHReportViewController () <UIScrollViewDelegate>
{
    NSArray *_stepsViewControllers;
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIPageControl *_pageControl;
}
@end

@implementation AFHReportViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPages];
    [self setupUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    int i = 0;
    for (UIViewController *vc in _stepsViewControllers) {
        CGRect frame = vc.view.frame;
        frame.origin.x += 320 * i;
        vc.view.frame = frame;
        i++;
    }
    self.title = ((UIViewController *)_stepsViewControllers[0]).title;
}

- (void)setupPages
{
    AFHStepOneViewController *vc1 = [AFHStepOneViewController new];
    AFHStepTwoViewController *vc2 = [AFHStepTwoViewController new];
    AFHStepThreeViewController *vc3 = [AFHStepThreeViewController new];
    
    _stepsViewControllers = @[vc1, vc2, vc3];
    _pageControl.numberOfPages = _stepsViewControllers.count;
}

- (void)setupUI
{
    _scrollView.contentSize = CGSizeMake(_stepsViewControllers.count * 320, self.view.bounds.size.height - 64);
    _scrollView.delegate = self;
    
    for (UIViewController *vc in _stepsViewControllers)
    {
        [_scrollView addSubview:vc.view];
    }
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _scrollView.frame.size.width; // you need to have a **iVar** with getter for scrollView
    float fractionalPage = _scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if(page != _pageControl.currentPage){
        UIViewController *pageVc = _stepsViewControllers[page];
        NSString *title = pageVc.title;
        self.title = title;
        _pageControl.currentPage = page; // you need to have a **iVar** with getter for pageControl
    }
}

@end
