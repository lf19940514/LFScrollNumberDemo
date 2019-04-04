//
//  LFScrollNumber.h
//  LFScrollNumberDemo
//
//  Created by souge 3 on 2019/3/1.
//  Copyright © 2019 liufei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFScrollLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LFScrollNumber : UIView

- (instancetype)initWithPoint:(CGPoint)point andPlaces:(NSInteger)places andLabelSize:(CGSize)size andLabelMargin:(CGFloat)margin;

@property (nonatomic, copy) NSString *numberStr;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIImage *textImage;

@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, assign) NSInteger randomNum;//random下有效
@property (nonatomic, assign) NSInteger randomAdd;//random下有效 依次增加数量

@property (nonatomic, assign)LFScrollNumAnimationType scrollType;

@end

NS_ASSUME_NONNULL_END
