//
//  UINavigationBar+viewDidLoad.m
//  OCMethodExchangeDemo
//
//  Created by crystal on 15/7/22.
//  Copyright (c) 2015年 crystal. All rights reserved.
//

#import "UIViewController+viewDidLoad.h"
#import <objc/runtime.h>

//typedef id (* _IMP)(id, SEL, ...);//有返回值的IMP指针
typedef void (* _VIMP)(id, SEL, ...);//没有返回值的IMP指针

@implementation UIViewController (viewDidLoad)

+ (void)load
{
    //保证交换方法只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获取原始方法
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        //获取方法实现
//        _IMP viewDidLoad_IMP = (_IMP)method_getImplementation(viewDidLoad);
        _VIMP viewDidLoad_IMP = (_VIMP)method_getImplementation(viewDidLoad);
        //重新设置方法实现
        method_setImplementation(viewDidLoad, imp_implementationWithBlock(^(id target, SEL action){
            //调用原有方法实现
            viewDidLoad_IMP(target, @selector(viewDidLoad));
            //新增代码
            NSLog(@"%@ did load", target);
        }));
    });
}

@end
