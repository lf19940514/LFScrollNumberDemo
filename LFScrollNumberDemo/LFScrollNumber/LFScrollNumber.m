//
//  LFScrollNumber.m
//  LFScrollNumberDemo
//
//  Created by souge 3 on 2019/3/1.
//  Copyright © 2019 liufei. All rights reserved.
//

#import "LFScrollNumber.h"

@interface LFScrollNumber() {
    NSInteger _places;
    CGSize _labelSize;
    CGFloat _margin;
}
@property (nonatomic, strong)NSMutableArray *labelArray;

@end

@implementation LFScrollNumber

- (instancetype)initWithPoint:(CGPoint)point andPlaces:(NSInteger)places andLabelSize:(CGSize)size andLabelMargin:(CGFloat)margin{
    if (self = [super init]) {
        _places = places;
        _labelSize = size;
        _margin = margin;
        self.frame = CGRectMake(point.x, point.y, (_places*_labelSize.width)+((_places-1)*margin), _labelSize.height);
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.backgroundColor = [UIColor clearColor];
    _randomAdd = 0;
    
    _labelArray = [NSMutableArray array];
    for (int i = 0; i < _places; i++) {
        LFScrollLabel *foldLabel = [[LFScrollLabel alloc] init];
        foldLabel.frame = CGRectMake(i*(_labelSize.width+_margin), 0, _labelSize.width, _labelSize.height);
        [self addSubview:foldLabel];
        [_labelArray addObject:foldLabel];
    }
}


- (void)setNumberStr:(NSString *)numberStr{
    _numberStr = numberStr;
    if (numberStr.length<_places) {
        for (int i = 0; i < (_places-numberStr.length); i++) {
            _numberStr = [NSString stringWithFormat:@"0%@",_numberStr];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    [_labelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LFScrollLabel *label = obj;

        char c = [weakSelf.numberStr characterAtIndex:idx];
        NSString *str = [NSString stringWithFormat:@"%c",c];

        if (weakSelf.scrollType==LFScrollNumAnimationTypeRandom) {
            [label updateNumber:label.currentNum nextNumber:[str integerValue]];
        } else {
            if ([str integerValue]!=label.currentNum) {
                [label updateNumber:label.currentNum nextNumber:[str integerValue]];
            }
        }
    }];
}

- (void)setFont:(UIFont *)font{
    _font = font;
    for (int i = 0; i < _labelArray.count; i++) {
        LFScrollLabel *label = _labelArray[i];
        label.font = font;
    }
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    for (int i = 0; i < _labelArray.count; i++) {
        LFScrollLabel *label = _labelArray[i];
        label.textColor = textColor;
    }
}

- (void)setTextImage:(UIImage *)textImage{
    _textImage = textImage;
    for (int i = 0; i < _labelArray.count; i++) {
        LFScrollLabel *label = _labelArray[i];
        label.textImage = textImage;
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    for (int i = 0; i < _labelArray.count; i++) {
        LFScrollLabel *label = _labelArray[i];
        label.backgroundImage = backgroundImage;
    }
}

- (void)setScrollType:(LFScrollNumAnimationType)scrollType{
    _scrollType = scrollType;
    for (int i = 0; i < _labelArray.count; i++) {
        LFScrollLabel *label = _labelArray[i];
        label.scrollType = scrollType;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    for (int i = 0; i < _labelArray.count; i++) {
        LFScrollLabel *label = _labelArray[i];
        label.backgroundColor = backgroundColor;
    }
}

- (void)setDuration:(NSTimeInterval)duration{
    _duration = duration;
    for (int i = 0; i < _labelArray.count; i++) {
        LFScrollLabel *label = _labelArray[i];
        label.duration = duration;
    }
}

- (void)setRandomAdd:(NSInteger)randomAdd{
    _randomAdd = randomAdd;
    for (int i = 0; i < _labelArray.count; i++) {
        LFScrollLabel *label = _labelArray[i];
        label.randomNum = _randomNum+(i*_randomAdd);
    }
}

- (void)setRandomNum:(NSInteger)randomNum{
    _randomNum = randomNum;
    for (int i = 0; i < _labelArray.count; i++) {
        LFScrollLabel *label = _labelArray[i];
        label.randomNum = randomNum+(i*_randomAdd);
    }
}

@end
