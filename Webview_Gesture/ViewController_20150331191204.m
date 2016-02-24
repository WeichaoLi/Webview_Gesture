//
//  ViewController.m
//  Webview_Gesture
//
//  Created by 李伟超 on 15/3/9.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "ViewController.h"

typedef enum SwitchPageDirection{
    SwitchtoNextPage = 1,
    SwithctoFowardPage = 2,
}SwitchPageDirection;

@interface ViewController () {
    CGPoint startPoint;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _webviw = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webviw.delegate = self;    
    [self.view addSubview:_webviw];
    
    _webviw.scrollView.scrollEnabled = NO;
    _webviw.scrollView.bounces = NO;
    _webviw.scrollView.alwaysBounceVertical = YES;
    _webviw.scrollView.pagingEnabled = YES;
    
    _webviw.backgroundColor = [UIColor whiteColor];
    
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://k3p.l.mob.com/OKL2Q"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webviw loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    CGPoint currentPoint = [panGesture locationInView:self.view];
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            startPoint = currentPoint;
            break;
        case UIGestureRecognizerStateEnded: {
            CGFloat XD = currentPoint.x - startPoint.x;
            if (XD < 0) {
                if (_currentIndex < _pageCount - 1) {
//                    [self animationInView:_webviw WithDirection:SwitchtoNextPage];
                    [self setUIViewAnimation:_webviw With:SwitchtoNextPage];
                }
            }else {
                if (_currentIndex > 0) {
                    [self animationInView:_webviw WithDirection:SwithctoFowardPage];
                }
            }
            
        }
            break;
        default:
            break;
    }
}

- (void)animationInView:(UIView *)view WithDirection:(SwitchPageDirection)direction{
    [self didAnimation:direction];
    
    CATransition *animation = [CATransition animation];
//    animation.delegate = self;
    animation.duration = 1.f;
//    animation.speed = 1.0f; //切换速度
//    animation.startProgress = 0.5;
//    animation.endProgress = 0.8;
//    animation.timeOffset = 4.f;
//    animation.fillMode = kCAFillModeBackwards;
//    animation.filter = kCAFilterTrilinear;
    
    /** type
     *
     *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于似有的API(我是这么认为的,可以点进去看下注释).
     *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
     *  @"cube"                     立方体翻滚效果
     *  @"moveIn"                   新视图移到旧视图上面
     *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
     *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
     *  @"pageCurl"                 向上翻一页
     *  @"pageUnCurl"               向下翻一页
     *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
     *  @"rippleEffect"             滴水效果,(不支持过渡方向)
     *  @"oglFlip"                  上下左右翻转效果
     *  @"rotate"                   旋转效果
     *  @"push"
     *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
     *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
     */
    
    /** type
     *
     *  kCATransitionFade            交叉淡化过渡
     *  kCATransitionMoveIn          新视图移到旧视图上面
     *  kCATransitionPush            新视图把旧视图推出去
     *  kCATransitionReveal          将旧视图移开,显示下面的新视图
     */
    switch (direction == 1 ? 8 : 9) {
        case 0:
            animation.type = kCATransitionFade;
            break;
        case 1:
            animation.type = kCATransitionMoveIn;
            break;
        case 2:
            animation.type = kCATransitionPush;
            break;
        case 3:
            animation.type = kCATransitionReveal;
            break;
        case 4:
            animation.type = @"cube";
            break;
        case 5:
            animation.type = @"suckEffect";
            break;
        case 6:
            animation.type = @"oglFlip";
            break;
        case 7:
            animation.type = @"rippleEffect";
            break;
        case 8:
            animation.type = @"pageCurl";
            break;
        case 9:
            animation.type = @"pageUnCurl";
            break;
        case 10:
            animation.type = @"cameraIrisHollowOpen";
            break;
        case 11:
            animation.type = @"cameraIrisHollowClose";
            break;
            
        default:
            break;
    }
    
    switch (direction == 1 ? 0 : 1) {
        case 0:
            animation.subtype = kCATransitionFromBottom;
            break;
        case 1:
            animation.subtype = kCATransitionFromTop;
            break;
        case 2:
            animation.subtype = kCATransitionFromLeft;
            break;
        case 3:
            animation.subtype = kCATransitionFromRight;
            break;
        default:
            break;
    }
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)didAnimation:(SwitchPageDirection)direction {
    if (direction == SwitchtoNextPage) {
        CGPoint point = CGPointMake(0 , _webviw.scrollView.bounds.size.height * ++_currentIndex);
        [_webviw.scrollView setContentOffset:point animated:NO];
    }else {
        CGPoint point = CGPointMake(0 , _webviw.scrollView.bounds.size.height * --_currentIndex);
        [_webviw.scrollView setContentOffset:point animated:NO];
    }
}

- (void)setUIViewAnimation:(UIView *)view With:(SwitchPageDirection)direction {
    [self didAnimation:direction];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:NO];
    [UIView commitAnimations];
}

#pragma -
#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //计算总页数
    CGFloat count = _webviw.scrollView.contentSize.height / _webviw.scrollView.bounds.size.height;
    _pageCount = count > (NSUInteger)count ? ((NSUInteger)count + 1) : (NSUInteger)count;
    _currentIndex = 0;
    
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [_webviw addGestureRecognizer:_panGesture];
    }
}

@end
