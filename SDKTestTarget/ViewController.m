//
//  ViewController.m
//  SDKTestTarget
//
//  Created by 李一贤 on 2018/10/23.
//  Copyright © 2018 李一贤. All rights reserved.
//

#import "ViewController.h"
#import "MySDKDemoLib.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)test_Init:(id)sender {
    
    [[MySDKDemoLib shareInstance] Kola_Init];
    
}


- (IBAction)test_Login:(id)sender {
    [[MySDKDemoLib shareInstance] Kola_Login];
}

-(void)KolaDidInitFinish:(NSDictionary *)initRuslt{
    
    NSLog(@"aaa");
}

-(void)KolaDidLoginFinish:(NSDictionary*)LoginResult{
    NSLog(@"bbb");
    
}

-(void)KolaHandleFail:(NSString*)failType andDtail:(NSDictionary*)detail{
    
    NSLog(@"ccc");
}

@end
