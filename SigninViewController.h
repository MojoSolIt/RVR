//
//  SigninViewController.h
//  RVR
//
//  Created by Muhammad Faraz on 04/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SigninViewController : UIViewController  <UITextFieldDelegate>

@property (strong, nonatomic)IBOutlet UIButton *signin;

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)signin:(id)sender;

-(BOOL)emailFormat:(NSString *)emailText;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end
