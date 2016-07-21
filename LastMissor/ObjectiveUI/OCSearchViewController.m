//
//  OCSearchViewController.m
//  OcTrain
//
//  Created by HXjiang on 16/3/29.
//  Copyright © 2016年 蒋林. All rights reserved.
//

#import "OCSearchViewController.h"

@interface OCSearchViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate,
UISearchControllerDelegate
>
{
    BOOL isSearching;
}

@property (nonatomic, strong) NSArray *arrayResult;
@property (nonatomic, strong) NSArray *arrayData;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchBar *searchBar;



@end

@implementation OCSearchViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    isSearching = NO;
    
    [self.view addSubview:self.tableView];
//    [self setUpUIBarButtonItem];
 
    
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

#pragma mark - UIBarButtonItem
- (void)setUpUIBarButtonItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                                          target:self
                                                                                          action:@selector(didClickLeftBarbutton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                           target:self
                                                                                           action:@selector(setUpSearchBar)];
}

- (void)didClickLeftBarbutton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchBar
- (void)setUpSearchBar
{
    [self hideNavigationBar:YES];
    
    CGFloat searchX = 0.0f;
    CGFloat searchY = 20.0f;
    CGFloat searchW = self.view.bounds.size.width;
    CGFloat searchH = 44.0f;
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(searchX, searchY, searchW, searchH)];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    
    [self.searchBar becomeFirstResponder];
    [self.view addSubview:self.searchBar];
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.active = YES;
}

- (void)hideNavigationBar:(BOOL)isHide
{
    [self.navigationController setNavigationBarHidden:isHide animated:YES];
}

#pragma mark -- UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self hideNavigationBar:NO];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    isSearching = NO;
    self.searchBar.hidden = YES;
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterBySubstring:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self hideNavigationBar:NO];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    self.searchBar.hidden = YES;
    [self filterBySubstring:searchBar.text];
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void)filterBySubstring:(NSString *)subStr
{
    isSearching = YES;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[C] %@", subStr];//CONTAINS只适用于string类型查找
    self.arrayResult = [self.arrayData filteredArrayUsingPredicate:pred];
    NSLog(@"arrayResult = %@", self.arrayResult);
    [self.tableView reloadData];
}

#pragma mark - UITableView
- (UITableView *)tableView
{
    if (!_tableView)
    {
        CGRect frame = self.view.bounds;
        frame.origin.y += 64.0f;
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UITableView alloc] init];
    }
    
    return _tableView;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return isSearching ? self.arrayResult.count : self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MyCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    NSNumber *number = isSearching ? [self.arrayResult objectAtIndex:indexPath.row] : [self.arrayData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", number];
    
    return cell;
}

#pragma mark -- lazy load
- (NSArray *)arrayData
{
    if (!_arrayData)
    {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < 1000; i++)
        {
            [mutableArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        _arrayData = [[NSArray alloc] initWithArray:mutableArray];
    }
    return _arrayData;
}

@end
