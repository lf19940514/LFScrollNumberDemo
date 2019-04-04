//
//  ViewController.m
//  LFScrollNumberDemo
//
//  Created by souge 3 on 2019/2/28.
//  Copyright © 2019 liufei. All rights reserved.
//

#import "ViewController.h"
#import "LFScrollNumber.h"
@interface ViewController ()

@property (nonatomic, strong)LFScrollNumber *scrollNumber1;
@property (nonatomic, strong)LFScrollNumber *scrollNumber2;
@property (nonatomic, strong)LFScrollNumber *scrollNumber3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _scrollNumber1 = [[LFScrollNumber alloc] initWithPoint:CGPointZero andPlaces:7 andLabelSize:CGSizeMake(42, 56) andLabelMargin:10];
    _scrollNumber1.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/6.0*1.0);
    [self.view addSubview:_scrollNumber1];
    _scrollNumber1.backgroundImage = [UIImage imageNamed:@"LFScrollBackColor"];
    _scrollNumber1.textImage = [UIImage imageNamed:@"LFScrollTextColor"];
    _scrollNumber1.scrollType = LFScrollNumAnimationTypeNormal;
    
    _scrollNumber2 = [[LFScrollNumber alloc] initWithPoint:CGPointZero andPlaces:7 andLabelSize:CGSizeMake(42, 56) andLabelMargin:10];
    _scrollNumber2.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/6.0*3.0);
    [self.view addSubview:_scrollNumber2];
    _scrollNumber2.backgroundImage = [UIImage imageNamed:@"LFScrollBackColor"];
    _scrollNumber2.textImage = [UIImage imageNamed:@"LFScrollTextColor"];
    _scrollNumber2.scrollType = LFScrollNumAnimationTypeFast;
    _scrollNumber2.duration = 0.5;
    
    _scrollNumber3 = [[LFScrollNumber alloc] initWithPoint:CGPointZero andPlaces:7 andLabelSize:CGSizeMake(42, 56) andLabelMargin:10];
    _scrollNumber3.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/6.0*5.0);
    [self.view addSubview:_scrollNumber3];
    _scrollNumber3.backgroundImage = [UIImage imageNamed:@"LFScrollBackColor"];
    _scrollNumber3.textImage = [UIImage imageNamed:@"LFScrollTextColor"];
    _scrollNumber3.scrollType = LFScrollNumAnimationTypeRandom;
    _scrollNumber3.randomNum = 5;
    _scrollNumber3.randomAdd = 3;
    _scrollNumber3.duration = 0.1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int num = arc4random()%10000000;
    _scrollNumber1.numberStr = [NSString stringWithFormat:@"%i",num];
    _scrollNumber2.numberStr = [NSString stringWithFormat:@"%i",num];
    _scrollNumber3.numberStr = [NSString stringWithFormat:@"%i",num];
}

@end
