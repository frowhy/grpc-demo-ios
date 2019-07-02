//
//  ViewController.m
//  grpc-demo-ios
//
//  Created by 付广辉 on 2019-07-02.
//  Copyright © 2019 Govern. All rights reserved.
//

#import "ViewController.h"
#import "TestA.pbrpc.h"
#import "GRPCCall+Tests.h"

static NSString *const kHostAddress = @"localhost:50051";


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITextField *responseMessage = [[UITextField alloc] init];
    responseMessage.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    responseMessage.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    responseMessage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    responseMessage.textAlignment = NSTextAlignmentCenter;
    responseMessage.enabled = NO;
    responseMessage.text = @"Loading";

    [GRPCCall useInsecureConnectionsForHost:kHostAddress];

    TestAServiceGreeter *client = [[TestAServiceGreeter alloc] initWithHost:kHostAddress];
    TestAServiceEchoRequest *request = [[TestAServiceEchoRequest alloc] init];
    request.message = @"iOS";

    [client echoWithRequest:request handler:^(TestAServiceEchoResponse *_Nullable response, NSError *_Nullable error) {
        if (!error) {
            [responseMessage setText:response.meta.message];
        }
    }];

    [self.view addSubview:responseMessage];
}


@end