//
//  NJWViewController.h
//  WebServiceTest
//
//  Created by Nick Woodward on 8/13/14.
//  Copyright (c) 2014 softwaremerchant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJWViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
- (IBAction)submit:(id)sender;

@end
