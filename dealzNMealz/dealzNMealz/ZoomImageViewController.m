//
//  ZoomImageViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/8/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "ZoomImageViewController.h"

@interface ZoomImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numberOfImagesLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *imagesSCroll;
@property NSMutableArray *imagesReferenceArray;

@end

@implementation ZoomImageViewController

- (void)viewDidLoad {
    [self viewDidLayoutSubviews];
    [self loadViewIfNeeded];
    [super viewDidLoad];
    self.menuButon.hidden = YES;
    _imagesReferenceArray = [[NSMutableArray alloc]init];
    [self creatingBackButtonWithImage:@"cross"];
    [self.backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addImagesToScrollView];
    _numberOfImagesLabel.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)[_imagesArray count]];

    // Do any additional setup after loading the view.
}

- (void)addImagesToScrollView {
    
    int imageWidth = [UIScreen mainScreen].bounds.size.width;
    for (int i =0; i<[_imagesArray count]; i++) {
        UIImageView *zoomImage = [[UIImageView alloc]initWithFrame:CGRectMake((i*imageWidth)+10, 0, imageWidth-20, _imagesSCroll.bounds.size.height)];
        zoomImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[_imagesArray objectAtIndex:i]]];
        [_imagesReferenceArray addObject:zoomImage];
        zoomImage.layer.cornerRadius = 10;
        zoomImage.clipsToBounds = YES;
        [_imagesSCroll addSubview:zoomImage];
    }
    _imagesSCroll.contentSize = CGSizeMake([_imagesArray count] * imageWidth ,  _imagesSCroll.bounds.size.height);
    
}


/*E-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    int index =point.x/[UIScreen mainScreen].bounds.size.width;
    UIImageView * imageView = [_imagesReferenceArray objectAtIndex:index];
    return imageView;
}*/

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    int index =point.x/[UIScreen mainScreen].bounds.size.width;
    _numberOfImagesLabel.text = [NSString stringWithFormat:@"%d/%lu",index+1,(unsigned long)[_imagesArray count]];
}
- (void)backButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
