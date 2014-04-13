//
//  AFHReportViewController.m
//  AntiFraudeHackathon
//
//  Created by Jonas Treub on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHReportViewController.h"
#import "AFHDataObject.h"

@interface AFHReportViewController () <UIScrollViewDelegate>
{
    NSMutableArray *_pages;
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

- (void)setupPages
{
    _pages = @[].mutableCopy;
    
    for (NSUInteger i = 0; i < 5; i++)
    {
        UIView *view = [UIView new];
        float hue = (1.0  / 5.0) * (float)i;
        view.backgroundColor = [UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1];
        view.frame = self.view.bounds;
        view.frame = CGRectMake(i * 320, 0, 320, self.view.bounds.size.height - 64);
        [_pages addObject:view];
    }
}

- (void)setupUI
{
    _scrollView.contentSize = CGSizeMake(_pages.count * 320, self.view.bounds.size.height - 64);
    _scrollView.delegate = self;
    
    for (UIView *view in _pages)
    {
        [_scrollView addSubview:view];
    }
    [self.view addSubview:_scrollView];
    
    _pageControl.layer.zPosition = 10;
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _scrollView.frame.size.width; // you need to have a **iVar** with getter for scrollView
    float fractionalPage = _scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    _pageControl.currentPage = page; // you need to have a **iVar** with getter for pageControl
}

@end
