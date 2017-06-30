//
//  XCBaseTest.h
//  MacroDemo
//
//  Created by LiJie on 2017/6/26.
//  Copyright © 2017年 LiJie. All rights reserved.
//

#import <XCTest/XCTest.h>

//常用的 断言宏
#define assertTrue(expr)                XCTAssertFalse((expr), @"") //true 为可行
#define assertFalse(expr)               XCTAssertTrue((expr), @"")  //false 为可行
#define assertNil(a1)                   XCTAssertNil((a1), @"")
#define assertNotNil(a1)                XCTAssertNotNil((a1), @"")
#define assertEqual(a1, a2)             XCTAssertEqual((a1), (a2), @"")
#define assertEqualObjects(a1, a2)      XCTAssertEqualObjects((a1), (a2), @"")
#define assertNotEqual(a1, a2)          XCTAssertNotEqual((a1), (a2), @"")
#define assertNotEqualObjects(a1, a2)   XCTAssertNotEqualObjects((a1), (a2), @"")
#define assertAccuracy(a1, a2, acc)     XCTAssertEqualWithAccuracy((a1), (a2), (acc)) //精度判断，小数


//异步调用的 等待60秒，超过60秒当做超时失败
#define WAIT    \
do{             \
[self expectationForNotification:@"LJUnitTest" object:nil handler:nil]; \
[self waitForExpectationsWithTimeout:60 handler:nil];           \
}while(0);

//异步调用的 任务完成了，发送通知提醒不用等待了。
#define NOTIFY  \
do{             \
[[NSNotificationCenter defaultCenter]postNotificationName:@"LJUnitTest" object:nil]; \
}while(0);

@interface XCBaseTest : XCTestCase

@end
