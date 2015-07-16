//
//  Person.m
//  OCMethodExchangeDemo
//
//  Created by crystal on 15/7/16.
//  Copyright (c) 2015年 crystal. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Car.h"

@implementation Person

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}
/*
在Person类的.m文件中，实现了resolveInstanceMethod这个方法为Person类动态增加了一个run方法的实现。（动态增加就是在程序运行的时候给某类的某个方法增加实现。）
 当外部调用[p run]时，由于没有实现run对应的方法，那么系统会调用resolveInstanceMethod让你去做一些其他的操作。（当然，也可以不做操作，只是在这个例子中，run方法动态增加了实现。）

 */
void running (id self, SEL _cmd)
{
    NSLog(@"%@  %s", self, sel_getName(_cmd));
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
//    if (sel == @selector(run))
//    {
//        class_addMethod(self, sel, (IMP)running, "v@:");
//        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}

//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    return [[Car alloc] init];
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *sel = NSStringFromSelector(aSelector);
    //判断你要转发的SEL
    if ([sel isEqualToString:@"run"])
    {
        //为你的转发方法手动生成签名
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = [anInvocation selector];
    //新建需要转发消息的对象
    Car *car = [[Car alloc] init];
    if ([car respondsToSelector:selector])
    {
        //唤醒这个方法
        [anInvocation invokeWithTarget:car];
    }
}
/*
 关于生成签名的类型"v@:"的解释，每一个方法会默认隐藏两个参数，self、_cmd， self代表方法调用者，_cmd代表这个方法的SEL，签名类型就是用来描述这个方法的返回值、参数的，v代表返回值为void，@表示self，:表示_cmd。
 
在viewController中调用的是Person类的run方法，最终方法被Car类的对象来接受。这就是OC的消息转发机制。
 */

@end
