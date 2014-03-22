//
//  ViewController.m
//  cal
//
//  Created by Shreenidhi Bhat on 3/20/14.
//  Copyright (c) 2014 Shreenidhi Bhat. All rights reserved.
//

#import "ViewController.h"
#import "event.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self FBLogin];
    

	// Do any additional setup after loading the view, typically from a nib.
    //[self onLoad];
    //[self getData];
    
}

- (void) FBLogin{
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
    
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 100);
    [self.view addSubview:loginView];
    
    
}

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.id;
    self.nameLabel.text = user.name;
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"Welcome ";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
}

- (void) getData
{
    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
    [query whereKeyExists:@"objectId"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void) onLoad
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"ics"];
    NSString *fileComponents = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [fileComponents componentsSeparatedByString:@"\n"];
    
    
    NSEnumerator *nse = [lines objectEnumerator];
    NSString *mod;
    bool isBegin = false;
    bool isEnd = false;
    event *eventObj;
   
    NSMutableArray *eventList=[[NSMutableArray alloc]init];
    
    while(fileComponents = [nse nextObject]) {
        NSString *stringBetweenBrackets = nil;
        NSScanner *scanner = [NSScanner scannerWithString:fileComponents];
        [scanner scanUpToString:@"\r" intoString:&mod];
        
        if([mod isEqualToString:@"BEGIN:VEVENT"])
        {
            isBegin = true;
            isEnd = false;
            eventObj = [[event alloc]init];
        }
        
        if([mod isEqualToString:@"END:VEVENT"])
        {
            isEnd = true;
            isBegin = false;
        }
        
        if(isBegin)
        {
            NSArray *components = [mod componentsSeparatedByString:@":"];
            
            if([components[0] isEqualToString:@"SUMMARY"])
            {
                [eventObj setSummary:components[1]];
            }
            else if([components[0] isEqualToString:@"LOCATION"])
            {
                [eventObj setLocation:components[1]];
            }
            else if([components[0] isEqualToString:@"DESCRIPTION"])
            {
                NSString *path = [@":" stringByAppendingString:components[2]];
                NSString * url = [components[1] stringByAppendingString:path];
                [eventObj setDescription:url];
            }
            else if([components[0] isEqualToString:@"CATEGORIES"])
            {
                [eventObj setCategories:components[1]];
            }
            else if([components[0] isEqualToString:@"DTSTART"])
            {
                [eventObj setDtStart:components[1]];
            }
            else if([components[0] isEqualToString:@"DTEND"])
            {
                [eventObj setDtEnd:components[1]];
            }
            else if([components[0] isEqualToString:@"DTSTAMP"])
            {
                [eventObj setDtStamp:components[1]];
            }
            else if([components[0] isEqualToString:@"CLASS"])
            {
                [eventObj setClassType:components[1]];
  
            }
            else if([components[0] isEqualToString:@"UID"])
            {
                NSString *path = [@":" stringByAppendingString:components[2]];
                NSString * url = [components[1] stringByAppendingString:path];
                [eventObj setUid:url];
            }
            
        }
        else if(isEnd)
        {
            [eventList addObject:eventObj];
        }
        
      
    }
    
    for(int count=0;count<[eventList count];count++)
    {
        PFObject *eventObj = [PFObject objectWithClassName:@"Events"];
        event *objEvent=(event *)eventList[count];
        
        eventObj[@"summary"] = [objEvent summary];
        eventObj[@"location"] = [objEvent location];
        eventObj[@"description"] = [objEvent description];
        eventObj[@"categories"] = [objEvent categories];
        eventObj[@"dtStart"] = [objEvent dtStart];
        eventObj[@"dtEnd"] = [objEvent dtEnd];
        eventObj[@"dtStamp"] = [objEvent dtStart];
        eventObj[@"classType"] = [objEvent classType];
        eventObj[@"uid"] = [objEvent uid];
        
        [eventObj saveInBackground];
    }
        NSLog(@"data saved on to parse");
}

@end
