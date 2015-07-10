//
//  CZMoviePlayerViewController.h
//  B05_视频播放
//
//  Created by apple on 15-3-3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYMoviePlayerViewController;
@protocol CYMoviePlayerViewControllerDelegate <NSObject>

-(void)moviePlayerViewController:(CYMoviePlayerViewController *)vc didFinishCapturedImage:(UIImage *)image;

@end

@interface CYMoviePlayerViewController : UIViewController

@property(strong,nonatomic)NSURL *movieURL;

@property(strong,nonatomic)NSArray *captureTimes;//设置截图的时间

@property(weak,nonatomic)id<CYMoviePlayerViewControllerDelegate> delegate;

@end
