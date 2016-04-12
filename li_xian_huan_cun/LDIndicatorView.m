//
//  LDIndicatorView.m
//  LosAngeles
//
//  Created by 李庆彬 on 1/26/16.
//  Copyright © 2016 狗民网. All rights reserved.
//

#import "LDIndicatorView.h"
// 屏幕宽高
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface LDIndicatorView ()
@property (weak, nonatomic) UIView * coverView;
@property (weak, nonatomic) UIImageView * imageView;
@end

@implementation LDIndicatorView

- (void)show {
    UIView * coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    coverView.backgroundColor = [UIColor clearColor];
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];
    NSLog(@"%@",window);
    self.coverView = coverView;
    [window addSubview:coverView];
    
    NSMutableArray * imagesArray = [NSMutableArray array];
    for (int i = 1; i < 17; i++) {
        NSString * imageName = [NSString stringWithFormat:@"indicator%d",i];
        UIImage * image = [UIImage imageNamed:imageName];
        [imagesArray addObject:image];
    }
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    imageView.center = CGPointMake(kScreenWidth / 2.0, kScreenHeight / 2.0);
    [coverView addSubview:imageView];
    imageView.animationImages = imagesArray;
    imageView.animationDuration = 1.2;
    imageView.animationRepeatCount = 100;
    [imageView startAnimating];
    imageView.alpha = 0.95;
    self.imageView = imageView;
}

- (void) gone {
    [self.coverView removeFromSuperview];
    [self.imageView stopAnimating];
    [self.imageView setAnimationImages:nil];
}


@end
