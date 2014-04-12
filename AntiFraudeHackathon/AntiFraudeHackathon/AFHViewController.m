//
//  AFHViewController.m
//  AntiFraudeHackathon
//
//  Created by Bruno Scheele on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHViewController.h"

@interface AFHViewController ()
{
    UITextField *_userNameField;
    UITextField *_passcodeField;
    
    UIButton *_loginButton;
    
    NSLayoutConstraint *_constraintForLoginButton;
}

@end

@implementation AFHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupInterface];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self showInterface];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UI

- (void)setupInterface
{
    _userNameField = [UITextField new];
    _passcodeField = [UITextField new];
    _loginButton = [UIButton new];
    for (UITextField *textField in @[_userNameField, _passcodeField])
    {
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:textField];
        [self constraintLeftOfView:self.view withOtherView:textField andOffset:16];
        [self constraintRightOfView:self.view withOtherView:textField andOffset:16];
        [self constraintHeight:44 OfView:textField];
        textField.layer.cornerRadius = 5;
        textField.layer.borderColor = [UIColor colorWithWhite:.8 alpha:1].CGColor;
        textField.layer.borderWidth = 1;
        textField.autocapitalizationType =UITextAutocapitalizationTypeWords;
        textField.delegate = self;
        [_userNameField setEnablesReturnKeyAutomatically:YES];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, textField.frame.size.height)];
        leftView.backgroundColor = textField.backgroundColor;
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    for (UIButton *button in @[_loginButton])
    {
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:button];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self constraintLeftOfView:self.view withOtherView:button andOffset:16];
        [self constraintRightOfView:self.view withOtherView:button andOffset:16];
        [self constraintHeight:44 OfView:button];
        button.layer.cornerRadius = 5;
        
        button.backgroundColor = [UIColor colorWithRed:0.07 green:0.2 blue:0.37 alpha:1];
    }
    
    _userNameField.returnKeyType = UIReturnKeyNext;
    _passcodeField.returnKeyType = UIReturnKeyDone;
    [_userNameField setPlaceholder:NSLocalizedString(@"Gebruiksnaam", nil)];
    [_passcodeField setPlaceholder:NSLocalizedString(@"Wachtwoord", nil)];
    [_passcodeField setSecureTextEntry:YES];
    [_loginButton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    _constraintForLoginButton = [NSLayoutConstraint constraintWithItem:self.view
                                                                                 attribute:NSLayoutAttributeBottom
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:_loginButton
                                                                                 attribute:NSLayoutAttributeBottom
                                                                                multiplier:1
                                                                                  constant:-170];
    [self.view addConstraint:_constraintForLoginButton];
    
    NSLayoutConstraint *_constraintForPasscodeField = [NSLayoutConstraint constraintWithItem:_loginButton
                                                                                 attribute:NSLayoutAttributeTop
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:_passcodeField
                                                                                 attribute:NSLayoutAttributeBottom
                                                                                multiplier:1
                                                                                  constant:16];
    [self.view addConstraint:_constraintForPasscodeField];
    
    NSLayoutConstraint *_constraintForUserNameField = [NSLayoutConstraint constraintWithItem:_passcodeField
                                                                                   attribute:NSLayoutAttributeTop
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:_userNameField
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                  multiplier:1
                                                                                    constant:16];
    [self.view addConstraint:_constraintForUserNameField];
}

- (void)showInterface
{
    _constraintForLoginButton.constant = 235;
    [UIView animateWithDuration:.8
                          delay:0
         usingSpringWithDamping:.75
          initialSpringVelocity:.3
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished){
                         
                     }];
    if ([_userNameField canBecomeFirstResponder])
    {
        [_userNameField becomeFirstResponder];
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _userNameField)
    {
        [_passcodeField becomeFirstResponder];
    }
    else
    {
        [self login];
    }
    return YES;
}

#pragma mark - Login

- (void)login
{
    if ([_userNameField isFirstResponder])
    {
        [_userNameField resignFirstResponder];
    }
    else if ([_passcodeField isFirstResponder])
    {
        [_passcodeField resignFirstResponder];
    }
    
    [self performSegueWithIdentifier:@"tableViewSegue" sender:self];
}

#pragma mark - Constraints

- (void)constraintBottomOfView:(UIView *)view withOtherView:(UIView *)otherView andOffset:(NSUInteger)offset
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:otherView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:offset]];
}

- (void)constraintBottomOfView:(UIView *)view withTopOfView:(UIView *)otherView andOffset:(NSUInteger)offset
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:otherView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:offset]];
}

- (void)constraintTopOfView:(UIView *)view withOtherView:(UIView *)otherView andOffset:(NSUInteger)offset
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:otherView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:offset]];
}

- (void)constraintLeftOfView:(UIView *)view withOtherView:(UIView *)otherView andOffset:(NSUInteger)offset
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:otherView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1
                                                           constant:offset]];
}

- (void)constraintRightOfView:(UIView *)view withOtherView:(UIView *)otherView andOffset:(NSUInteger)offset
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:otherView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1
                                                           constant:offset]];
}

- (void)constraintWidth:(NSUInteger)width OfView:(UIView *)view
{
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:width]];
}

- (void)constraintHeight:(NSUInteger)height OfView:(UIView *)view
{
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:height]];
}

- (void)constraintCenterXOfView:(UIView *)view withOtherView:(UIView *)otherView
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:otherView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
}

- (void)constraintCenterYOfView:(UIView *)view withOtherView:(UIView *)otherView
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:otherView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
}

- (void)constraintCenterYOfView:(UIView *)view withOtherView:(UIView *)otherView andOffset:(NSInteger)offset
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:otherView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:offset]];
}

- (void)constraintWidthOfView:(UIView *)view withView:(UIView *)otherView
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:otherView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0]];
}

@end
