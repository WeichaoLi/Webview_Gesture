//
//  ViewController.h
//  Webview_Gesture
//
//  Created by 李伟超 on 15/3/9.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>{
    NSUInteger _currentIndex;
    NSUInteger _pageCount;
}

@property (nonatomic, retain) IBOutlet UIWebView *webviw;
@property (nonatomic, retain) UIPanGestureRecognizer *panGesture;


@end

