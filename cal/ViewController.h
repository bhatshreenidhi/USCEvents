//
//  ViewController.h
//  cal
//
//  Created by Shreenidhi Bhat on 3/20/14.
//  Copyright (c) 2014 Shreenidhi Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController<FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end
