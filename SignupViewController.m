//
//  SignupViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 04/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize Firstname,Lastname,Email,Password,ConfirmPassword,myscrollView;

- (void)viewDidLoad

{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Firstname.delegate = self;
    self.Lastname.delegate = self;
    self.Email.delegate = self;
    self.Password.delegate = self;
    self.ConfirmPassword.delegate = self;
    [myscrollView setContentSize:CGSizeMake(320, 568)];
    

    
    UIColor *pwdcolor = [UIColor whiteColor];
    self.Password.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Password"
     attributes:@{NSForegroundColorAttributeName:pwdcolor}];
    
    UIColor *FN = [UIColor whiteColor];
    self.Firstname.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"First Name"
     attributes:@{NSForegroundColorAttributeName:FN}];
    
    UIColor *LN = [UIColor whiteColor];
    self.Lastname.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Last Name"
     attributes:@{NSForegroundColorAttributeName:LN}];
    
    UIColor *email = [UIColor whiteColor];
    self.Email.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Email Address"
     attributes:@{NSForegroundColorAttributeName:email}];
    
    UIColor *CF = [UIColor whiteColor];
    self.ConfirmPassword.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Confirm Password"
     attributes:@{NSForegroundColorAttributeName:CF}];
    
    
    
    
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    
    NSString *savedValue = [ preferences
                            stringForKey:@"name"];
//    if(savedValue)
//    {
//        
//        [self performSegueWithIdentifier:@"goto_signin" sender:self];
//    }

    
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL)isValidEmail:(NSString *)candidate;
{
    BOOL stricterFilter = NO;
    
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

- (IBAction)signup:(id)sender

{
    NSInteger success = 0;
    
    @try
    {
        if ([[self.Firstname text] isEqualToString:@""] || [[self.Lastname text] isEqualToString:@""]            || [[self.Email text] isEqualToString:@""] || [[self.Password text] isEqualToString:@""]||
            [[self.ConfirmPassword text] isEqualToString:@""]
            )
        {
            
            [self alertStatus:@"Please enter all required field" :@"Sign Up Failed!":0];
            
        }
        
        else if([self isValidEmail:[Email text]]==NO)
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid Email"
                                                                           message:@"Please enter a valid email address "
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if (![self.Password.text isEqualToString:self.ConfirmPassword.text])
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter Password" message:@"Password does not match" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        else
            
        {
            
NSString *post =[[NSString alloc] initWithFormat:@"firstname=%@&lastname=%@&email=%@&password=%@&confirmpassword=%@",[self.Firstname text],[self.Lastname text],[self.Email text],[self.Password text],[self.ConfirmPassword text]];
            
            
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://mojosol.com/mojodev/RVR/signup.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
                
            {
                
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                
                
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                success = [jsonData[@"success"] integerValue];
                NSLog(@"Success: %ld",(long)success);
                
                if(success)
                    
                {
                    
                    
                    NSLog(@"Login SUCCESS");
                    //[self.INDICATOR startAnimating];
                   
                    
                    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
                    // NSString *str =jsonData[@"username"];
                    [preferences setObject:jsonData[@"firstname"] forKey:@"name"];
                    
                    
                    
//                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sign up successfull" message:@"Please login here" preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    }];
//                    [alert addAction:defaultAction];
//                    [self presentViewController:alert animated:YES completion:nil];
                    
                    [self performSegueWithIdentifier:@"Signup_sucessfull" sender:self];
                    
                }
                else
                    
                {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Sign Up Failed!" :0];
                }
                
            }
            else
            {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
            }

        }
  
    }
    
    @catch (NSException * e)
    
    {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    
    
    if (success)
        
    {
        [self performSegueWithIdentifier:@"Signup_sucessfull" sender:self];
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    if(textField == Firstname)
        
    {
        [Lastname becomeFirstResponder];
        [myscrollView setContentOffset:CGPointMake(0, 120) animated:YES];
    }
    else if(textField == Lastname)
    {
        [Email becomeFirstResponder];
        [myscrollView setContentOffset:CGPointMake(0, 140) animated:YES];
    }
    
    else if(textField == Email)
    {
        [Password becomeFirstResponder];
        [myscrollView setContentOffset:CGPointMake(0, 140) animated:YES];
    }
    
    else if(textField == Password)
    {
        [ConfirmPassword becomeFirstResponder];
        [myscrollView setContentOffset:CGPointMake(0, 140) animated:YES];
        
    }
    else
    {
        [self signup:self];
    }
    
    
    return YES;
}

- (IBAction)backgroundTap:(id)sender {
    [self.Firstname resignFirstResponder];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField


{
    if(textField == Firstname)
    {
        [myscrollView setContentOffset:CGPointMake(0, 120) animated:YES];
    }
    else if(textField == Lastname)
    {
        [myscrollView setContentOffset:CGPointMake(0, 140) animated:YES];
    }
    else if(textField == Email)
    {
        [myscrollView setContentOffset:CGPointMake(0, 140) animated:YES];
    }
    else if(textField == Password)
    {
        [myscrollView setContentOffset:CGPointMake(0, 140) animated:YES];
    }
    else if(textField == ConfirmPassword)
    {
        [myscrollView setContentOffset:CGPointMake(0, 140) animated:YES];
    }
   
    return YES;
}



-(void)viewWillAppear:(BOOL)animated


{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:YES];
}


#pragma mark - Email Validation

-(BOOL)emailFormat:(NSString *)emailText

{
    BOOL status;
    status = YES;
    NSString *emailString;
    //emailString = emailAddress.text;
    emailString = emailText;
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    
    if (([emailTest evaluateWithObject:emailString] != YES) || [emailString isEqualToString:@""])
        
    {
        status =  NO;
    }
    
    
    return status;
}


-(void)viewDidAppear:(BOOL)animated

{
    
    [super viewDidAppear:animated];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    
    NSString *savedValue = [ preferences
                            stringForKey:@"name"];
    if(savedValue)
    {
        
        //  [self performSegueWithIdentifier:@"login_success" sender:self];
    }
    
    
    
}




@end
