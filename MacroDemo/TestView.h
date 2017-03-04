//
//  TestView.h
//  MacroDemo
//
//  Created by LiJie on 2017/2/15.
//  Copyright © 2017年 LiJie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TestBlock)(id obj);

@interface TestView : UIView

-(void)setCallBack:(TestBlock)handler;

-(void)touchBlock;

@end
