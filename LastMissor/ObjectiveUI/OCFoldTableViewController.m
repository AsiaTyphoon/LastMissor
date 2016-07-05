//
//  OCFoldTableViewController.m
//  OcTrain
//
//  Created by HXjiang on 16/3/4.
//  Copyright © 2016年 蒋林. All rights reserved.
//

#import "OCFoldTableViewController.h"

#define UI_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define UI_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface OCFoldTableViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger didSection;   //当前选中行
    BOOL open;              //row展开标志位，yes为已经展开， no为未展开
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation OCFoldTableViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化选中的Section数，防止出错
    didSection = NSIntegerMax;
    NSLog(@"didSection = %zd", didSection);
    
//    [self loadBarButton];
    
    [self.view addSubview:self.tableView];
    
    //注册屏幕旋转观察
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (didSection == section)
    {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == didSection)
    {
        return 50;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat headviewX = 0.0f;
    CGFloat headviewY = 0.0f;
    CGFloat headviewW = UI_SCREEN_WIDTH;
    CGFloat headviewH = 50.0f/*UI_SCREEN_HEIGHT*/;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(headviewX, headviewY, headviewW, headviewH)];
    headView.backgroundColor = [UIColor redColor];
    
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    headButton.frame = CGRectMake(headviewX+10, headviewY, headviewW, 40.0f);
    NSString *buttonTitle = [NSString stringWithFormat:@"展开第%ld行", section+1];
    [headButton setTitle:buttonTitle forState:UIControlStateNormal];
    [headButton.layer setCornerRadius:5.0f];
    [headButton addTarget:self action:@selector(answerToHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    headButton.tag = section;
    [headView addSubview:headButton];
    
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(headviewX, 50.0f, headviewW, 1.0f)];
    lineLable.backgroundColor = [UIColor greenColor];
    [headView addSubview:lineLable];
    
    UIView *retView = [[UIView alloc] init];
//    retView.backgroundColor = [UIColor greenColor];
    [retView addSubview:headButton];
    [retView addSubview:lineLable];
    
    return retView;
//    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MyTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.section];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.section+1];
    cell.detailTextLabel.textColor = [UIColor purpleColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

#pragma mark ----折叠tableview 第一种方法
//是否展开
- (void)answerToHeadButton:(UIButton *)btn
{
    //此参数用来传递当前section号
    NSInteger curretSection = btn.tag;
    
    [_tableView beginUpdates];
    
    if (!open)
    {
        //open为no 点击时插入该行,同时改变open为yes
        open = YES;
        didSection = curretSection;
        //插入该点击行
        [self insertCurrentSection:didSection];
    }
    else
    {
        if (didSection == curretSection)
        {
            //open为yes， 若点击该行则删除该行,同时改变open为no,改变didSection为可选中行之外的数值
            open = NO;
            //删除该行
            [self deleteCurrentSection:didSection];
            didSection = NSIntegerMax;
        }
        else
        {
            //open为yes， 若点击其他行，则删除该行，再插入点击行，open的状态不变
            //删除当前行
            [self deleteCurrentSection:didSection];
            
            //插入点击行
            didSection = curretSection;
            [self insertCurrentSection:didSection];
        }
    }
    [_tableView endUpdates];
}

//插入当前行
- (void)insertCurrentSection:(NSInteger)currentSection
{
    NSMutableArray *rowArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:currentSection];
    [rowArray addObject:indexPath];
    [_tableView insertRowsAtIndexPaths:rowArray withRowAnimation:UITableViewRowAnimationFade];
}

//删除当前行
- (void)deleteCurrentSection:(NSInteger)currentSection
{
    NSMutableArray *rowArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:currentSection];
    [rowArray addObject:indexPath];
    [_tableView deleteRowsAtIndexPaths:rowArray withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - lazy load
- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc] initWithObjects:@"第一行", @"第二行", @"第三行", nil];
    }
    
    return _dataArray;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        CGRect rect /*= CGRectMake(0, 64, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)*/;
        rect = self.view.bounds;
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UITableView alloc] init];
    }
    return _tableView;
}

#pragma mark - 自定义返回按钮
- (void)loadBarButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                                          target:self
                                                                                          action:@selector(leftBarButtonAction)];
}

- (void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark --
//是否支持设备旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

//返回支持的屏幕指向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)statusBarChanged:(NSNotification *)notification
{
    self.tableView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    [self.tableView reloadData];
}

@end
