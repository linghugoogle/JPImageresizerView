//
//  JPViewController.m
//  JPImageresizerView
//
//  Created by ZhouJianPing on 12/21/2017.
//  Copyright (c) 2017 ZhouJianPing. All rights reserved.
//

#import "JPViewController.h"
#import "JPImageViewController.h"

#import "JPConstant.h"
#import "UIView+JPExtension.h"
#import "UIView+JPPOP.h"
#import "JPProgressHUD.h"
#import "UIColor+JPExtension.h"

@interface JPViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *processBtns;
@property (weak, nonatomic) IBOutlet UIButton *recoveryBtn;
@property (weak, nonatomic) IBOutlet UIButton *resizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *horMirrorBtn;
@property (weak, nonatomic) IBOutlet UIButton *verMirrorBtn;
@property (weak, nonatomic) IBOutlet UIButton *rotateBtn;
@property (nonatomic, weak) JPImageresizerView *imageresizerView;
@property (nonatomic, assign) JPImageresizerFrameType frameType;
@property (nonatomic, strong) UIImage *borderImage;
@property (nonatomic, assign) BOOL isToBeArbitrarily;
@end

@implementation JPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.configure.bgColor;
    self.frameType = self.configure.frameType;
    self.borderImage = self.configure.borderImage;
    self.recoveryBtn.enabled = NO;
    
    __weak typeof(self) wSelf = self;
    JPImageresizerView *imageresizerView = [JPImageresizerView imageresizerViewWithConfigure:self.configure imageresizerIsCanRecovery:^(BOOL isCanRecovery) {
        __strong typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;
        // 当不需要重置设置按钮不可点
        sSelf.recoveryBtn.enabled = isCanRecovery;
    } imageresizerIsPrepareToScale:^(BOOL isPrepareToScale) {
        __strong typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;
        // 当预备缩放设置按钮不可点，结束后可点击
        BOOL enabled = !isPrepareToScale;
        sSelf.rotateBtn.enabled = enabled;
        sSelf.resizeBtn.enabled = enabled;
        sSelf.horMirrorBtn.enabled = enabled;
        sSelf.verMirrorBtn.enabled = enabled;
    }];
    [self.view insertSubview:imageresizerView atIndex:0];
    self.imageresizerView = imageresizerView;
    self.configure = nil;
    
    // initialResizeWHScale默认为初始化时的resizeWHScale，此后可自行修改initialResizeWHScale的值
    // self.imageresizerView.initialResizeWHScale = 16.0 / 9.0; // 可随意修改该参数
    
    // 调用recoveryByInitialResizeWHScale方法进行重置，则resizeWHScale会重置为initialResizeWHScale的值
    // 调用recoveryByCurrentResizeWHScale方法进行重置，则resizeWHScale不会被重置
    // 调用recoveryByResizeWHScale:方法进行重置，可重置为任意resizeWHScale
    
    // 注意：iOS11以下的系统，所在的controller最好设置automaticallyAdjustsScrollViewInsets为NO，不然就会随导航栏或状态栏的变化产生偏移
    if (@available(iOS 11.0, *)) {
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (@available(iOS 13.0, *)) {
        [[UIApplication sharedApplication] setStatusBarStyle:(self.statusBarStyle == UIStatusBarStyleDefault ? UIStatusBarStyleDarkContent : UIStatusBarStyleLightContent) animated:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle animated:YES];
    }
}

- (void)dealloc {
    NSLog(@"viewController is dead");
}

- (IBAction)changeFrameType:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.borderImage) {
        self.imageresizerView.borderImage = sender.selected ? nil : self.borderImage;
        return;
    } else {
        self.imageresizerView.frameType = sender.selected ? (self.frameType == JPClassicFrameType ? JPConciseFrameType : JPClassicFrameType) : self.frameType;
    }
}

- (IBAction)rotate:(id)sender {
    [self.imageresizerView rotation];
}

- (IBAction)recovery:(id)sender {
    // 1.按当前【resizeWHScale】进行重置
    [self.imageresizerView recoveryByCurrentResizeWHScale];
    
    // 2.按【initialResizeWHScale】进行重置
//    [self.imageresizerView recoveryByInitialResizeWHScale:self.isToBeArbitrarily];
    
    // 3.按【目标裁剪宽高比】进行重置
//    [self.imageresizerView recoveryByTargetResizeWHScale:self.imageresizerView.imageresizeWHScale isToBeArbitrarily:self.isToBeArbitrarily];
}

- (IBAction)anyScale:(id)sender {
    self.imageresizerView.resizeWHScale = 0;
}

- (IBAction)one2one:(id)sender {
//    [self.imageresizerView setResizeWHScale:1.0 isToBeArbitrarily:self.isToBeArbitrarily animated:YES];
    
    UIBlurEffect *blurEffecct = nil;
    NSInteger index = (NSInteger)(0 + (arc4random() % (5 - 0 + 1)));
    switch (index) {
        case 0:
            blurEffecct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            break;
        case 1:
            blurEffecct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            break;
        case 2:
            blurEffecct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            break;
        case 3:
            blurEffecct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
            break;
        default:
            break;
    }
    
    CGFloat alpha = (CGFloat)(0 + (arc4random() % (10 - 0 + 1))) / 10.0;
    
    UIColor *strokeColor;
    UIColor *bgColor;
    if (@available(iOS 13, *)) {
        strokeColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return JPRandomColor;
            } else {
                return JPRandomColor;
            }
        }];
        
        bgColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return JPRandomColor;
            } else {
                return JPRandomColor;
            }
        }];
    } else {
        strokeColor = JPRandomColor;
        bgColor = JPRandomColor;
    }
    
    [self.imageresizerView setupBlurEffect:blurEffecct bgColor:bgColor maskAlpha:alpha strokeColor:strokeColor animated:YES];
    
    [self.imageresizerView roundResize:YES];
}

- (IBAction)sixteen2nine:(id)sender {
    [self.imageresizerView setResizeWHScale:(16.0 / 9.0) isToBeArbitrarily:self.isToBeArbitrarily animated:YES];
}

- (IBAction)replaceImage:(UIButton *)sender {
    sender.selected = !sender.selected;
    UIImage *image;
    if (sender.selected) {
        image = [UIImage imageNamed:@"Kobe.jpg"];
    } else {
        image = [UIImage imageNamed:@"Girl.jpg"];
    }
    self.imageresizerView.resizeImage = image;
}

- (IBAction)resize:(id)sender {
    [JPProgressHUD show];
    
    __weak typeof(self) wSelf = self;
    
    // 1.自定义压缩比例进行裁剪
//    [self.imageresizerView imageresizerWithComplete:^(UIImage *resizeImage) {
//        // 裁剪完成，resizeImage为裁剪后的图片
//        // 注意循环引用
//        __strong typeof(wSelf) sSelf = wSelf;
//        if (!sSelf) return;
//        [sSelf imageresizerDone:resizeImage];
//    } compressScale:0.5]; // 这里压缩为原图尺寸的50%
    
    // 2.以原图尺寸进行裁剪
    [self.imageresizerView originImageresizerWithComplete:^(UIImage *resizeImage) {
        // 裁剪完成，resizeImage为裁剪后的图片
        // 注意循环引用
        __strong typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;
        [sSelf imageresizerDone:resizeImage];
    }];
}

- (void)imageresizerDone:(UIImage *)resizeImage {
    if (!resizeImage) {
        [JPProgressHUD showErrorWithStatus:@"没有裁剪图片" userInteractionEnabled:YES];
        return;
    }

    [JPProgressHUD dismiss];

    JPImageViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JPImageViewController"];
    vc.image = resizeImage;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pop:(id)sender {
    if (self.navigationController.viewControllers.count <= 1) {
        [UIView transitionWithView:self.view.window duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self dismissViewControllerAnimated:NO completion:nil];
        } completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)lockFrame:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.imageresizerView.isLockResizeFrame = sender.selected;
}

- (IBAction)verMirror:(id)sender {
    self.imageresizerView.verticalityMirror = !self.imageresizerView.verticalityMirror;
}

- (IBAction)horMirror:(id)sender {
    self.imageresizerView.horizontalMirror = !self.imageresizerView.horizontalMirror;
}

- (IBAction)previewAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.imageresizerView.isPreview = sender.selected;
}

- (IBAction)toBeArbitrarilyAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.isToBeArbitrarily = sender.selected;
    [self.imageresizerView setResizeWHScale:self.imageresizerView.resizeWHScale isToBeArbitrarily:self.isToBeArbitrarily animated:YES];
}

@end
