//
//  TestView.m
//  MacroDemo
//
//  Created by LiJie on 2017/2/15.
//  Copyright © 2017年 LiJie. All rights reserved.
//

#import "TestView.h"


@implementation TestView
{
    TestBlock tempBlock;
}


-(void)setCallBack:(TestBlock)handler{
    tempBlock = handler;
}


-(void)touchBlock{
    if (tempBlock) {
        tempBlock(nil);
    }
}








@end
