//
//  ViewController.m
//  firebase
//
//  Created by 朱校明 on 2020/4/29.
//  Copyright © 2020 goodick.com. All rights reserved.
//

#import "ViewController.h"
#import "FirebaseRecognitionVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)firebaseRecognitionAction:(id)sender {
    
    [self presentViewController:[[FirebaseRecognitionVC alloc] init] animated:YES completion:^{
        
    }];
}

@end
