//
//  ViewController.m
//  OCMethodExchangeDemo
//
//  Created by crystal on 15/7/16.
//  Copyright (c) 2015年 crystal. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

//- (void)viewDidLoaded
//{
//    //调用自己原有的方法
////    [self viewDidLoaded];
////    NSLog(@"%@ did load", self);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
//    Person *p = [[Person alloc] init];
//    [p run];
}

//+ (void)load
//{
//    //保证交换方法只执行一次
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //获取到这个类的viewDidLoad方法，它的类型是一个objc_method结构体的指针
//        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
//        //获取到自己刚刚新建的一个方法
//        Method viewDidLoaded = class_getInstanceMethod(self, @selector(viewDidLoaded));
//        //互换两个方法的实现
//        method_exchangeImplementations(viewDidLoad, viewDidLoaded);
//    });
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
