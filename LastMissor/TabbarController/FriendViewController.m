//
//  FriendViewController.m
//  LastMissor
//
//  Created by HXjiang on 16/6/17.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "FriendViewController.h"
#import "HXProgress.h"
#import "Masonry.h"
#import "FriendViewCell.h"
#import "UILabel+TextAlignment.h"

@interface FriendViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.tableView];
    
    
//    UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
//    labelText.center = self.view.center;
//    labelText.text = @"i am text am text am text am text am text am text am text am text am text am text am text am text am text am text";
//    labelText.backgroundColor = [UIColor redColor];
//    
//    [self.view addSubview:labelText];
//    
//    [labelText setTextAlignmentTop];
//    [labelText setTextAlignmentBottom];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)barBtnItemLeftAction:(id)sender {
    
    NSString *text = @"llksjfakjlfjalsdjflajdflajdfljasdlfjalsdjfljsdfljasdlfjljllksjfakjlfjalsdjflajdflajdfljasdlfjalsdjfljsdfljasdlfjlj";

    [HXProgress showText:text withSize:CGSizeMake(300, 50) durationTime:2];
}



#pragma mark - UITableViewDelegate
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UITableView alloc] init];
        _tableView.estimatedRowHeight = 150.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorColor = [UIColor redColor];
    }
    return _tableView;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"llksjsdlfjljllksjfakjlfjalsddlfjlj",
                    @"东西冲海岸线穿越",
                    @"llksjf爆米花没有了akjlfjalsdjflajdfla爆米花没有了jdfljasdlfjalsdjfljsdfljasdlfjljllksjfakjlfjalsdjflajdflajdfl爆米花没有jasdlfjalsdjfljsdfljasdlfjlj",
                    @"llksjfakjlfjalsdjflajdflajdfljasdlfjalsdjfljsdfljasdlfjljllksjfak爆米花没有了jlfjalsdjflajdflajdfljasdlfjalsdjfljsdfljasdlfjljllksjfakjlfjalsdjflajdflajdfljasdlfjalsdjfljsdfljasdlfjljllksjfak000",
                    @"llksjfakjlfjalsdjflajdflajdfljasdl爆米花没有了fjalsdjfljsdfljasdlfjljllksjfakjlfjalsdjflajdflajdfljasdlfjalsdjfljsdfljasdlfjlj",
                    @"llksjfakjlfj爆米花没有了alsdjflajdflajdfljasdlfjalsdjfljsdfljasd爆米花没有了lfjljllksjfakjlfjalsdjflajdflajdfl爆米花没有了jasdlfjalsdjfljsdfljasdlfjlj",
                    @"llksjfakjlfjalsdjflajdflajdfljasdlfjalsdjf爆米花没有了ljsdfljasdlfjlfjlj"];
    }
    return _titles;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"FriendViewCellID";
    FriendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[FriendViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    cell.titleLabel.text = self.titles[indexPath.row];
    NSString *imageName = [NSString stringWithFormat:@"pictureloop%ld.jpg", indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:imageName];
    
    //NSLog(@"cell.titleLabel.text:%@", cell.titleLabel.text);
    //NSLog(@"self.titles[indexPath.row]:%@", self.titles[indexPath.row]);

    return cell;
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
