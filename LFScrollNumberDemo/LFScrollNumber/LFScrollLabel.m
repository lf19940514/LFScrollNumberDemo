//
//  LFScrollLabel.m
//  LFScrollNumberDemo
//
//  Created by souge 3 on 2019/2/28.
//  Copyright © 2019 liufei. All rights reserved.
//

#import "LFScrollLabel.h"

@interface LFScrollLabel()
{
    UIImageView *backgroundImageView;
    UILabel *currentLabel;
    CAScrollLayer *layer;
    NSTimeInterval animationTime;
}
@property (nonatomic, strong) NSMutableArray *scrollLabels;

@end

@implementation LFScrollLabel

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    backgroundImageView.frame = self.bounds;
    layer.frame = self.bounds;
    currentLabel.frame = layer.bounds;
    [self setFont:[UIFont fontWithName:@"DIN Alternate" size:self.frame.size.height]];
}

- (void)buildUI {
    self.backgroundColor = [UIColor darkGrayColor];
    backgroundImageView = [[UIImageView alloc] init];
    [self addSubview:backgroundImageView];
    
    _textColor = [UIColor whiteColor];
    _currentNum = 0;
    _duration = 0.3;
    _randomNum = 10;
    // 配置新的数据和UI
    layer = [CAScrollLayer layer];
    [self.layer addSublayer:layer];
    
    currentLabel = [self createLabel:[NSString stringWithFormat:@"%ld",_currentNum]];
    [layer addSublayer:currentLabel.layer];
    _scrollLabels = [NSMutableArray array];
}

#pragma mark Setter
- (void)setFont:(UIFont *)font {
    _font = font;
    currentLabel.font = font;
}
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    currentLabel.textColor = textColor;
}
- (void)setTextImage:(UIImage *)textImage{
    [self setTextColor:[UIColor colorWithPatternImage:[self scaleToSize:textImage size:self.frame.size]]];
}
- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    self.backgroundColor = [UIColor clearColor];
    backgroundImageView.image = backgroundImage;
}
- (void)setCurrentNum:(NSInteger)currentNum{
    _currentNum = currentNum;
}
- (void)setDuration:(NSTimeInterval)duration{
    _duration = duration;
}
- (void)setRandomNum:(NSInteger)randomNum{
    _randomNum = randomNum;
}
- (void)setScrollType:(LFScrollNumAnimationType)scrollType{
    _scrollType = scrollType;
}

- (void)configScrollFromNumber:(NSInteger)fromNumber toNumber:(NSInteger)toNumber{
    NSMutableArray *scrollNumbers = [NSMutableArray array];
    if (self.scrollType==LFScrollNumAnimationTypeFast) {
        [scrollNumbers addObject:[NSString stringWithFormat:@"%ld", (long)fromNumber]];
        [scrollNumbers addObject:[NSString stringWithFormat:@"%ld", (long)toNumber]];
    }else if (self.scrollType==LFScrollNumAnimationTypeRandom){
        [scrollNumbers addObject:[NSString stringWithFormat:@"%ld", (long)fromNumber]];
        for (int i = 0; i < _randomNum; i++) {
            [scrollNumbers addObject:[NSString stringWithFormat:@"%u",arc4random()%10]];
        }
        [scrollNumbers addObject:[NSString stringWithFormat:@"%ld", (long)toNumber]];
    }else{
        if (fromNumber<toNumber) {
            for (NSInteger i = fromNumber; i < (toNumber+1); i++) {
                [scrollNumbers addObject:[NSString stringWithFormat:@"%ld", (long)i]];
            }
        }else{
            for (NSInteger i = fromNumber; i < 10; i++) {
                [scrollNumbers addObject:[NSString stringWithFormat:@"%ld", (long)i]];
            }
            for (NSInteger i = 0; i < (toNumber+1); i++) {
                [scrollNumbers addObject:[NSString stringWithFormat:@"%ld", (long)i]];
            }
        }
    }
    
    __weak typeof(self) weakSelf = self;
    __block CGFloat height = 0;
    [scrollNumbers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [self createLabel:text];
        label.frame = CGRectMake(0, height, CGRectGetWidth(self->layer.frame), CGRectGetHeight(self->layer.frame));
        [self->layer addSublayer:label.layer];
        
        [weakSelf.scrollLabels addObject:label];
        // 累加高度
        height = CGRectGetMaxY(label.frame);
    }];
    
    animationTime = (scrollNumbers.count-1)*_duration;
}

- (UILabel *)createLabel:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = _textColor;
    label.font = _font;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = text;
    
    return label;
}

- (void)createAnimations
{
    CGFloat maxY = [[layer.sublayers lastObject] frame].origin.y;
    // keyPath 是 sublayerTransform ，因为动画应用于 layer 的 subLayer。
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
    animation.duration = animationTime;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.toValue = @0;
    animation.fromValue = [NSNumber numberWithFloat:-maxY];
    // 添加动画
    [layer addAnimation:animation forKey:@"LFNumberScrollAnimatedView"];
}


- (void)updateNumber:(NSInteger)number nextNumber:(NSInteger)nextNumber{
    // 先删除旧数据
    [layer removeAnimationForKey:@"LFNumberScrollAnimatedView"];
    [layer removeFromSuperlayer];
    [_scrollLabels removeAllObjects];
    
    // 配置新的数据和UI
    layer = [CAScrollLayer layer];
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    
    [self configScrollFromNumber:number toNumber:nextNumber];
    [self createAnimations];
    
    _currentNum = nextNumber;
}

/**
 *  改变图片的大小
 *
 *  @param image     需要改变的图片
 *  @param size 新图片的大小
 *
 *  @return 返回修改后的新图片
 */
- (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
