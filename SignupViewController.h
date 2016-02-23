//
//  SignupViewController.h
//  RVR
//
//  Created by Muhammad Faraz on 04/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *signUpButton;


@property (weak, nonatomic) IBOutlet UITextField *Firstname;
@property (weak, nonatomic) IBOutlet UITextField *Lastname;

@property (weak, nonatomic) IBOutlet UITextField *Email;
@property (weak, nonatomic)IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPassword;


@property (weak, nonatomic) IBOutlet UIScrollView *myscrollView;


-(IBAction)signup:(id)sender;

-(BOOL)emailFormat:(NSString *)emailText;

@end
