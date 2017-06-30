//
//  LJTest.m
//  MacroDemo
//
//  Created by LiJie on 2017/6/26.
//  Copyright © 2017年 LiJie. All rights reserved.
//
#import "XCBaseTest.h"

@interface LJTest : XCBaseTest

@end

@implementation LJTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
