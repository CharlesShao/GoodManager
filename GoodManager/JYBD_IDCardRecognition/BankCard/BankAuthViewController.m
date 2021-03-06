//
//  IDAuthViewController.m
//  IDCardRecognition
//
//  Created by tianxiuping on 2018/6/27.
//  Copyright © 2018年 XP. All rights reserved.
//

#import "BankAuthViewController.h"
#import "BankInfoViewController.h"
#import "JYBDBankCardVC.h"
#import "JYBDIDCardVC.h"
@interface BankAuthViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation BankAuthViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self customBackBarButtonItem];
    }
    
    return self;
}

#pragma mark - 自定义系统自带的backBarButtomItem
// 去掉系统默认自带的文字（上一个控制器的title），修改系统默认的样式（一个蓝色的左箭头）为自己的图片
-(void)customBackBarButtonItem {
    // 去掉文字
    // 自定义全局的barButtonItem外观
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
    // 将文字减小并设其颜色为透明以隐藏
    [barButtonItemAppearance setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:0.1], NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
    
    // 设置图片
    // 获取全局的navigationBar外观
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    // 获取原图
    UIImage *image = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 修改navigationBar上的返回按钮的图片，注意：这两个属性要同时设置
    navigationBarAppearance.backIndicatorImage = image;
    navigationBarAppearance.backIndicatorTransitionMaskImage = image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"银行卡识别";
//    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 银行卡扫描
- (IBAction)shootAction:(UIButton *)sender {
    __weak __typeof__(self) weakSelf = self;
    
    JYBDBankCardVC *vc = [[JYBDBankCardVC alloc]init];//扫描页面
    vc.callbackfun = self.callbackfun;
    vc.finish = ^(JYBDBankCardInfo *info, UIImage *image) {
        BankInfoViewController *infoM = [[BankInfoViewController alloc]init];
        infoM.cardInfo = info;
        infoM.IDImage = image;
        infoM.callbackfun = self.callbackfun;
        [weakSelf.navigationController pushViewController:infoM animated:YES];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)backAction:(id)sender {
    UIViewController *present = self.presentingViewController;
    while (YES) {
        if (present.presentingViewController) {
            present = present.presentingViewController;
        }else{
            break;
        }
    }
    [present dismissViewControllerAnimated:YES completion:nil];
}



@end
