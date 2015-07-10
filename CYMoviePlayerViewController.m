//
//  CZMoviePlayerViewController.m
//  B05_视频播放
//
//  Created by apple on 15-3-3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CYMoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CYMoviePlayerViewController ()

@property(strong,nonatomic)MPMoviePlayerController *movieContr;

@end

@implementation CYMoviePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //断言
    NSAssert(self.movieURL != nil, @"请先设置movieURL");
    
    //初化一个视频播放器
    MPMoviePlayerController *movieContr = [[MPMoviePlayerController alloc] initWithContentURL:self.movieURL];
    
    //设置movieContr的View的尺寸
    movieContr.view.frame = self.view.bounds;
    
    //设置视频播放的适配
    movieContr.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //把movieContr的View 添加到当前视频控制器的View
    [self.view addSubview:movieContr.view];
    
    //播放
    [movieContr prepareToPlay];
    
    [movieContr play];
    
    //赋值
    self.movieContr = movieContr;
    
    //监听Done事件 通过通知的方式实现
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(exit) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
    //监听视频播放完成
    [center addObserver:self selector:@selector(exit) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    
    //截屏 设置时间
//    [self.movieContr requestThumbnailImagesAtTimes:@[@(2.0)] timeOption:MPMovieTimeOptionExact];
    if (self.captureTimes) {
        [self.movieContr requestThumbnailImagesAtTimes:self.captureTimes timeOption:MPMovieTimeOptionExact];
    }
    //监听截屏返回图片
    [center addObserver:self selector:@selector(captureImage:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    
    

}



#pragma mark 获取截图
-(void)captureImage:(NSNotification *)noti{

    NSLog(@"%@",noti.userInfo);
    
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(moviePlayerViewController:didFinishCapturedImage:)]) {
        
        UIImage *img = noti.userInfo[MPMoviePlayerThumbnailImageKey];
        
        [self.delegate moviePlayerViewController:self didFinishCapturedImage:img];
    }
}

#pragma mark 退出
-(void)exit{
    NSLog(@"%s",__func__);
    //退出当前的控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
