//
//  LFScrollLabel.h
//  LFScrollNumberDemo
//
//  Created by souge 3 on 2019/2/28.
//  Copyright © 2019 liufei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    LFScrollNumAnimationTypeNormal = 0,
    LFScrollNumAnimationTypeFast,
    LFScrollNumAnimationTypeRandom
} LFScrollNumAnimationType;

@interface LFScrollLabel : UIView

@property (nonatomic, assign)LFScrollNumAnimationType scrollType;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIImage *textImage;

@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, assign) NSInteger currentNum;

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) NSInteger randomNum;//random下有效

- (void)updateNumber:(NSInteger)number nextNumber:(NSInteger)nextNumber;

@end

NS_ASSUME_NONNULL_END
