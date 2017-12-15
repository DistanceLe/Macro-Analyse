//
//  SecondViewController.m
//  MacroDemo
//
//  Created by LiJie on 2017/2/15.
//  Copyright © 2017年 LiJie. All rights reserved.
//

#import "SecondViewController.h"
#import "TestView.h"


#if defined(__cplusplus)
#define let auto const
#define var auto
#else
#define let const __auto_type
#define var __auto_type
#endif




#define RandomColor [UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1]

@interface SecondViewController ()

@property(nonatomic, strong)TestView* demoView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.demoView = [[TestView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.demoView.center = self.view.center;
    self.demoView.backgroundColor = [UIColor redColor];
    
    
    var but = [UIButton new];
    let num = 89;
    let numF = 42.5;
    
    
    __weak typeof(self) tempWeakSelf=self;
    @weakify(self)
    
    [self.demoView setCallBack:^(id obj) {
        
        @strongify(self)
        typeof(self) strongSelf=tempWeakSelf;
        
        strongSelf.view.backgroundColor = RandomColor;
        self.view.backgroundColor = RandomColor;
        
        //开始😯
//        self.demoView.backgroundColor = RandomColor;
//        _demoView.backgroundColor = RandomColor;
    }];
    [self.view addSubview:self.demoView];
    
    
    
    
//    NSRunLoop* loop=[NSRunLoop currentRunLoop];
    //普通模式是以下模式中常用的几个模式的集合(也就相当于加入到了多个模式中)
//    [loop addTimer:nil forMode:NSRunLoopCommonModes];
    
    //默认模式 NSDefaultRunLoopMode 大多数操作在该模式下完成，建议在该模式下启动runloop，以及配置输入源。
    //连接模式 NSConnectionReplyMode Cocoa用这种模式来和NSConnection对象一起监视连接响应。不建议使用这个模式
    //模态模式 NSModalPanelRunLoopMode Cocoa使用这个模式来标识意图模态面板的事件。
    //事件追踪模式 NSEventTrackingRunLoopMode 在鼠标拖拽等用户交互过程中，Cocoa使用这个模式对输入事件进行限制。
    //[loop addTimer:nil forMode:NSDefaultRunLoopMode];
    
//    [loop run];
//    [loop runUntilDate:[NSDate date]];
    
    /**  
     上面说到run loop本质上是一个函数，函数内部是一个do-while循环，但它也有相关的属性，比如运行模式等，也有启动和停止的需求，因此它被封装成了CFRunLoop，其指针类型为CFRunLoopRef。NSRunloop是对CFRunLoop进行了进一步的封装。下面就介绍操作run loop的方法（针对CFRunLoop和NSRunloop的方法都有）。
     1、获取当前线程的runloop：
     需要获取线程a的runloop需要在线程a中调用以下方法。
     方法一：[NSRunloop currentRunloop];
     方法二：CFRunLoopGetCurrent(void);
     2、开启runloop：
     方法一：无条件开启，即调用run方法。
     方法二：设定runloop开启时间
     3、结束runloop
     方法一：设定runloop的失效时间
     方法二：直接停止runloop，调用CFRunLoopStop()； */
}


- (IBAction)click:(UIButton *)sender {
    [self.demoView touchBlock];
    
}

-(void)dealloc{
    NSLog(@"second  dealloc");
}


/**  源代码：
                        __weak typeof(self) tempWeakSelf=self;
 try{} @finally{} {}    __weak __typeof__(object) weak##_##object = object;
 try{} @finally{}       __typeof__(object) object = weak##_##object;
 
     预编译后的代码
                        __attribute__((objc_ownership(weak))) typeof(self) tempWeakSelf=self;
 @try{} @finally{} {}   __attribute__((objc_ownership(weak))) __typeof__(self) weak_self = self;
 @try{} @finally{}      __typeof__(self) self = weak_self;

 
typeof(self) strongSelf=tempWeakSelf; -----> typeof(self) strongSelf=tempWeakSelf;
 
 
 - (void)__attribute__((ibaction))click:(UIButton *)sender {
 [self.demoView touchBlock];
 }
 */


/**  前提申明 
 1.__ 标准C要求 编译器使用(__)双下划线 为语言扩展前缀（__一般前后都要加__）。 个人的函数，变量不应使用__
 2.#  在C语言的宏中，#的功能是将其后面的宏参数进行字符串化操作（Stringfication）
      简单说就是在对它所引用的宏变量 通过替换后在其左右各加上一个双引号  #abc -> "abc"
 3.## 连接符（concatenator）用来将两个Token连接为一个Token (把参数连接在一起, 连接完依旧是一个参数，而不是字符串)
      int a;  int b;  int ab;     a##b  -> ab 变量
 4....在C宏中称为Variadic Macro，也就是变参宏  (stderr  标准错误输出设备 也就是控制台 意思是输出到控制台)
      #define myprintf(templt,...) fprintf(stderr,templt,__VA_ARGS__)  没有名字的变参
      #define myprintf(templt,args...) fprintf(stderr,templt,args)     有名字的变参
      #define myprintf(templt,...) fprintf(stderr,templt, ##__VAR_ARGS__)
      这时，##这个连接符号充当的作用就是当__VAR_ARGS__为空的时候，消除前面的那个逗号，要不然以上两个变参是不能为空的
 5.   尽量让宏的末尾接 分号结尾。 
      #define MY_MACRO(x) {	xxx }
      #define MY_MACRO(x) do { xxx } while(0)  这种写法就会更好一些
 6.   #define min(X,Y) ((X) > (Y) ? (Y) : (X))
      #define min(X,Y) ({ typeof (X) x_ = (X); typeof (Y) y_ = (Y); (x_ < y_) ? x_ : y_; }) 这种好些
      c = min(a,foo(b));  foo() 函数 就不会被调用 两次。
 7.   ({...})的作用是将内部的几条语句中最后一条的值返回，它也允许在内部声明变量（因为它通过大括号组成了一个局部Scope）。
 */





/**  
 
__attribute__ 可以设置函数属性（Function Attribute ）、变量属性（Variable Attribute ）和类型属性（Type Attribute ）
 
 1.前后都有两个下划线，并切后面会紧跟一对原括弧，括弧里面是相应的__attribute__ 参数
 2.__attribute__ ((attribute-list))
 
 例子：typedef int int32_t __attribute__ ((aligned (8)));
      该声明将强制编译器确保（尽它所能）变量类 型为int32_t 的变量在分配空间时采用8 字节对齐方式
 
 
 
 __attribute__((objc_ownership(weak)))就是weak的实现
 __attribute__((objc_ownership(strong))) 相当于_strong，创建了对self_weak的强引用，变量名为self
 
 */



@end
