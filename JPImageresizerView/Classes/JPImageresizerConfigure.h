//
//  JPImageresizerConfigure.h
//  JPImageresizerView
//
//  Created by 周健平 on 2018/4/22.
//
//  JPImageresizerConfigure：用于配置初始化参数

#import <UIKit/UIKit.h>
#import "JPImageresizerTypedef.h"

@interface JPImageresizerConfigure : NSObject
/**
 * 默认参数值：
    - viewFrame = [UIScreen mainScreen].bounds;
    - frameType = JPConciseFrameType;
    - animationCurve = JPAnimationCurveLinear;
    - blurEffect = nil;
    - bgColor = [UIColor blackColor];
    - maskAlpha = 0.75;
    - strokeColor = [UIColor whiteColor];
    - resizeWHScale = 0.0;
    - contentInsets = UIEdgeInsetsZero;
    - borderImage = nil;
    - borderImageRectInset = CGPointZero;
    - maximumZoomScale = 10.0;
    - isRoundResize = NO;
    - isShowMidDots = YES;
    - isBlurWhenDragging = NO;
    - isShowGridlinesWhenDragging = NO;
    - gridCount = 3;
 */
+ (instancetype)defaultConfigureWithResizeImage:(UIImage *)resizeImage make:(void(^)(JPImageresizerConfigure *configure))make;

/**
 * 默认参数的基础上：
    - blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    - bgColor = [UIColor whiteColor];
    - maskAlpha = 0.3;
 */
+ (instancetype)lightBlurMaskTypeConfigureWithResizeImage:(UIImage *)resizeImage make:(void (^)(JPImageresizerConfigure *configure))make;

/**
 * 默认参数的基础上：
    - blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    - bgColor = [UIColor blackColor];
    - maskAlpha = 0.3;
 */
+ (instancetype)darkBlurMaskTypeConfigureWithResizeImage:(UIImage *)resizeImage make:(void (^)(JPImageresizerConfigure *configure))make;

/** 裁剪图片 */
@property (nonatomic, strong) UIImage *resizeImage;

/** 视图区域 */
@property (nonatomic, assign) CGRect viewFrame;

/** 边框样式 */
@property (nonatomic, assign) JPImageresizerFrameType frameType;

/** 动画曲线 */
@property (nonatomic, assign) JPAnimationCurve animationCurve;

/** 模糊效果 */
@property (nonatomic, strong) UIBlurEffect *blurEffect;

/** 背景颜色 */
@property (nonatomic, strong) UIColor *bgColor;

/** 遮罩颜色的透明度（背景颜色 * 透明度） */
@property (nonatomic, assign) CGFloat maskAlpha;

/** 裁剪线颜色 */
@property (nonatomic, strong) UIColor *strokeColor;

/** 裁剪宽高比（0则为任意比例） */
@property (nonatomic, assign) CGFloat resizeWHScale;

/** 裁剪框边线能否进行对边拖拽（当裁剪宽高比为0，即任意比例时才有效，默认为yes） */
@property (nonatomic, assign) BOOL edgeLineIsEnabled;

/** 裁剪区域与主视图的内边距 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;

/** 是否顺时针旋转 */
@property (nonatomic, assign) BOOL isClockwiseRotation;

/** 边框图片 */
@property (nonatomic, strong) UIImage *borderImage;

/** 边框图片与边线的偏移量 */
@property (nonatomic, assign) CGPoint borderImageRectInset;

/** 最大缩放比例（默认为10.0，小于1.0则无效） */
@property (nonatomic, assign) CGFloat maximumZoomScale;

/** 是否初始化圆切（若为YES则resizeWHScale为1） */
@property (nonatomic, assign) BOOL isRoundResize;

/** 是否显示中间的4个点（上、下、左、右的中点） */
@property (nonatomic, assign) BOOL isShowMidDots;

/** 拖拽时是否遮罩裁剪区域以外的区域 */
@property (nonatomic) BOOL isBlurWhenDragging;

/** 拖拽时是否能继续显示网格线（frameType 为 JPClassicFrameType 且 gridCount > 1 才显示网格） */
@property (nonatomic) BOOL isShowGridlinesWhenDragging;

/** 每行/列的网格数（frameType 为 JPClassicFrameType 且 gridCount > 1 才显示网格） */
@property (nonatomic, assign) NSUInteger gridCount;

@property (readonly) JPImageresizerConfigure *(^jp_resizeImage)(UIImage *resizeImage);
@property (readonly) JPImageresizerConfigure *(^jp_viewFrame)(CGRect viewFrame);
@property (readonly) JPImageresizerConfigure *(^jp_frameType)(JPImageresizerFrameType frameType);
@property (readonly) JPImageresizerConfigure *(^jp_animationCurve)(JPAnimationCurve animationCurve);
@property (readonly) JPImageresizerConfigure *(^jp_blurEffect)(UIBlurEffect *blurEffect);
@property (readonly) JPImageresizerConfigure *(^jp_bgColor)(UIColor *bgColor);
@property (readonly) JPImageresizerConfigure *(^jp_maskAlpha)(CGFloat maskAlpha);
@property (readonly) JPImageresizerConfigure *(^jp_strokeColor)(UIColor *strokeColor);
@property (readonly) JPImageresizerConfigure *(^jp_resizeWHScale)(CGFloat resizeWHScale);
@property (readonly) JPImageresizerConfigure *(^jp_edgeLineIsEnabled)(BOOL edgeLineIsEnabled);
@property (readonly) JPImageresizerConfigure *(^jp_contentInsets)(UIEdgeInsets contentInsets);
@property (readonly) JPImageresizerConfigure *(^jp_isClockwiseRotation)(BOOL isClockwiseRotation);
@property (readonly) JPImageresizerConfigure *(^jp_borderImage)(UIImage *borderImage);
@property (readonly) JPImageresizerConfigure *(^jp_borderImageRectInset)(CGPoint borderImageRectInset);
@property (readonly) JPImageresizerConfigure *(^jp_maximumZoomScale)(CGFloat maximumZoomScale);
@property (readonly) JPImageresizerConfigure *(^jp_isRoundResize)(BOOL isRoundResize);
@property (readonly) JPImageresizerConfigure *(^jp_isShowMidDots)(BOOL isShowMidDots);
@property (readonly) JPImageresizerConfigure *(^jp_isBlurWhenDragging)(BOOL isBlurWhenDragging);
@property (readonly) JPImageresizerConfigure *(^jp_isShowGridlinesWhenDragging)(BOOL isShowGridlinesWhenDragging);
@property (readonly) JPImageresizerConfigure *(^jp_gridCount)(NSUInteger gridCount);
@end
