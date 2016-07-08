//
//  HomeViewController.m
//  LastMissor
//
//  Created by HXjiang on 16/6/17.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "HomeViewController.h"
#import "RectangleView.h"
#import "PicturesLoop.h"
#import "AnimationViewController.h"
#import "TableViewController.h"


#define CellHeightForRow
#define CellHeightForHeader
#define CellHeightForFooter (20)

//dictionary key
#define keyImg      (@"keyImg")
#define keyText     (@"keyText")
#define keyVc       (@"keyVc")


// 注意const的位置
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";


@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RectangleViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *vcArray;
@property (nonatomic, strong) NSMutableArray *mvcArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    self.navigationItem.rightBarButtonItems = @[[self setupBarButtonItemWihtImageName:@"tabbar_mainframe"],
                                                [self setupBarButtonItemWihtImageName:@"tabbar_contacts"],
                                                [self setupBarButtonItemWihtImageName:@"tabbar_discover"]];
    
    [self loadData];
    
    [self setupScanView];
    
    
    [self.view addSubview:self.collectionView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadData
{
    _vcArray = @[
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          
                          @{keyVc:@"TableViewController",
                            keyText:@"TableView",
                            keyImg:@""},
                          
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          
                          @{keyVc:@"AnimationViewController",
                            keyText:@"Animation",
                            keyImg:@""},
                          ];

    
    _mvcArray = [[NSMutableArray alloc] initWithCapacity:0];
    int N = 22;
    for (int i = 0; i < N; i++) {
        
        [_mvcArray addObject:@{keyVc:@"AnimationViewController",
                               keyText:@"Animation",
                               keyImg:@""}];
    }
}

//导航栏Items
- (UIBarButtonItem *)setupBarButtonItemWihtImageName:(NSString *)imageName
{
    //tabbar_mainframe,tabbar_discover,tabbar_contacts
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton *buttonItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [buttonItem setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem];

    return barItem;
}

//扫描付款区
- (void)setupScanView
{
    CGFloat viewH = 100.0f;
    
    UIView *viewScan = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, viewH)];
    viewScan.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    [self.view addSubview:viewScan];
}



#pragma mark - UICollectionViewDelegate
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 164, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-164-49) collectionViewLayout:_collectionViewFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        // 注册cell、sectionHeader、sectionFooter
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
        
        //此方法用来消除Grouped样式头部空白
//        _tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    }
    return _collectionView;
    
}//@collectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return _array.count;
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    lab.backgroundColor = [UIColor orangeColor];
//    [cell.contentView addSubview:lab];
    
    if (indexPath.section == 0) {
        
        RectangleView *rectangle = [[RectangleView alloc] initWithFrame:CGRectMake(0, 0, 320, 74*3) WithArray:_vcArray];
        rectangle.delegate = self;
        [cell.contentView addSubview:rectangle];
    
    }//@section == 0
    
    if (indexPath.section == 1) {
        NSInteger num = 4;
        NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 1; i <= num; i++) {
            [mArray addObject:[NSString stringWithFormat:@"pictureloop%d.jpg", i]];
        }
        PicturesLoop *pictureLoop = [[PicturesLoop alloc] initWithFrame:CGRectMake(0, 0, 320, 74) WithImages:mArray];
        [cell.contentView addSubview:pictureLoop];
    
    }//@section == 1

    
    if (indexPath.section == 2) {
        
        RectangleView *rectangle = [[RectangleView alloc] initWithFrame:CGRectMake(0, 0, 320, 74*6) WithArray:_mvcArray];
        [cell.contentView addSubview:rectangle];
    
    }//@section == 2
    
    return cell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor grayColor];
        
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
        
        return footerView;
    }
    
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}




#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.bounds.size.width, 74*3);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(self.view.bounds.size.width, 74);
    }
    if (indexPath.section == 2) {
        return CGSizeMake(self.view.bounds.size.width, 74*6);
    }
    return CGSizeMake(50, 50);
}




//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}


//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 5.f;
//}


//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 5.f;
//}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){0,0};
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){self.view.frame.size.width, 15};
}




#pragma mark ---- UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
}


// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


// 长按某item，弹出copy和paste的菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 使copy和paste有效
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"])
    {
        return YES;
    }
    
    return NO;
}



//
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
//{
//    if([NSStringFromSelector(action) isEqualToString:@"copy:"])
//    {
//        //        NSLog(@"-------------执行拷贝-------------");
//        [_collectionView performBatchUpdates:^{
//            [_section0Array removeObjectAtIndex:indexPath.row];
//            [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
//        } completion:nil];
//    }
//    else if([NSStringFromSelector(action) isEqualToString:@"paste:"])
//    {
//        NSLog(@"-------------执行粘贴-------------");
//    }
//}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - RectangleViewDelegate
- (void)didClickBtnWithDictionary:(NSDictionary *)dic {
    
    UIViewController *viewcontroller = [[NSClassFromString(dic[@"keyVc"]) alloc] init];
    viewcontroller.title = dic[@"keyText"];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

/*
 在老版本的iOS中，状态栏永远都是白色风格。而在iOS 7中，我们可以修改每个view controller中状态栏的外观。通过UIStatusBarStyle常量可以指定状态栏的内容是暗色或亮色。默认情况下，状态栏的显示是暗色。也就是说，状态栏上的时间、电池指示器和Wi-Fi信号显示为暗色。
 
 我们可能希望将导航栏的风格修改为亮色。这里有两个方法可以实现。在iOS 7中，我们可以在每个view controller中overridingpreferredStatusBarStyle:方法，如下所示：
 - (UIStatusBarStyle)preferredStatusBarStyle {     return UIStatusBarStyleLightContent; }
 PS：此法的只有在设置了以下代码才会被调用（对于preferredStatusBarStyle不执行问题）：
 [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
 
 */

@end
