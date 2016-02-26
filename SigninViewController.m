//
//  SigninViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 04/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "SigninViewController.h"

@interface SigninViewController ()

@end

@implementation SigninViewController

@synthesize email,txtPassword;

- (void)viewDidLoad

{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.email.text =nil;
    self.txtPassword.text=nil;
    [self.myScrollView setContentSize:CGSizeMake(320, 568)];
    
    UIColor *pwdcolor = [UIColor whiteColor];
    self.txtPassword.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Password"
     attributes:@{NSForegroundColorAttributeName:pwdcolor}];
    
    UIColor *Emailcolor = [UIColor whiteColor];
    self.email.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Email"
     attributes:@{NSForegroundColorAttributeName:Emailcolor}];

    
    self.email.delegate = self;
    self.txtPassword.delegate = self;
    
    
    
}

- (void)didReceiveMemoryWarning


{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated


{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:YES];
}




- (IBAction)signin:(id)sender

{
    NSInteger success = 0;
    
    @try
    
    
    {
        if ([[self.email text] isEqualToString:@""])
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Email address required"
                                                                           message:@"Please enter your email address"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
               else if ([[self.txtPassword text]isEqualToString:@""])
        {
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Password required"
                                                                          message:@"Please enter your password "
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }

        

        else
        {
            
   NSString *post =[[NSString alloc] initWithFormat:@"email=%@&password=%@",[self.email text],[self.txtPassword text]];
            
            
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://mojosol.com/mojodev/RVR/signin.php"];
            
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
                
                success = [jsonData[@"status"] integerValue];
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                    //[self.INDICATOR startAnimating];
                    
            NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
           [preferences setObject:jsonData[@"firstname"] forKey:@"name"];
                ;
                    
                    
                }
                else
                    
                {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Sign in Failed! \n Please enter valid credentials" :0];
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
        [self performSegueWithIdentifier:@"login_success" sender:self];
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

- (IBAction)backgroundTap:(id)sender

{
    [self.view endEditing:YES];
}

-(void)viewDidAppear:(BOOL)animated

{
    
    [super viewDidAppear:animated];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    
    NSString *savedValue = [ preferences
                            stringForKey:@"name"];
    if(savedValue)
    {
        
        [self performSegueWithIdentifier:@"login_success" sender:self];
    }
    
    
    
}

    
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.email resignFirstResponder];
    if (textField == email)
    {
        [txtPassword becomeFirstResponder];
    }
    else
    {
        [self signin:self];
    }
    return YES;
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

- (IBAction)forgotPassword:(id)sender {
    NSString *myurl=@"https://www.google.com";
    NSURL *url = [NSURL URLWithString:myurl];
    [[UIApplication sharedApplication] openURL:url];
    NSLog(@"Calling");

}




@end
