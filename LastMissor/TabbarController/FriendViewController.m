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

@interface FriendViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = RGBA_COLOR(230, 230, 230, 1);
//    
//    NSString *text = @"llksjfakjlfjalsdjflajdflajdfljasdlfjalsdjfljsdfljasdlfjljllksjfakjlfjalsdjflajdflajdfljasdlfjalsdjfljsdfljasdlfjlj";
//    
//    UIFont *attributeFont = [UIFont systemFontOfSize:17];
//    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    
//    NSDictionary *attributesDic = @{NSFontAttributeName:attributeFont, NSParagraphStyleAttributeName:paragraphStyle};
//    
//    CGFloat w = [UIScreen mainScreen].bounds.size.width;
//    CGFloat h = [UIScreen mainScreen].bounds.size.height;
//    
//    CGSize size = CGSizeMake(w-150, CGFLOAT_MAX);
//    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributesDic context:nil];
//    
//    NSLog(@"rect(%.f %.f %.f %.f)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
//    
//    UILabel *labText = [[UILabel alloc] initWithFrame:rect];
//    labText.text = text;
//    labText.center = CGPointMake(w/2, h/2);
//    //labText.font = attributeFont;
//    labText.adjustsFontSizeToFitWidth = YES;
//    labText.backgroundColor = [UIColor redColor];
//    
//    //自动折行设置
////    labText.lineBreakMode = NSLineBreakByWordWrapping;
//    labText.numberOfLines = 0;
//    
//    [self.view addSubview: labText];
// 
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStyleDone target:self action:@selector(barBtnItemLeftAction:)];
//    
//    
//    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
//    
//    __weak typeof(self) weakSelf = self;
//    
//    UIView *superView = self.view;
//    
//   // [superView addConstraints:@[[NSLayoutConstraint constraintWithItem:labText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:padding.top]]];
// 
//    [labText mas_makeConstraints:^(MASConstraintMaker *make) {
//        
////        // 约束控件的大小尺寸
////        make.size.mas_equalTo(CGSizeMake(100, 100));
////        // 约束控件的剧中
////        make.center.equalTo(weakSelf.view);
//        
//        make.top.mas_equalTo(100);
//        make.left.mas_equalTo(20);
//        make.right.mas_equalTo(-20);
//        //make.bottom.mas_equalTo(-20);
//        
//        
//        //make.size.mas_equalTo(CGSizeMake(rect.size.width, rect.size.height));
//        //make.left.and.top.mas_equalTo(20);
//    }];
    
    
    [self.view addSubview:self.tableView];
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
                    @"llksjfakj爆米花没有lfjalsdjflajdflajdfljasdlfjalsdjfljsdfljasdlfjljllksjfakjlfjalsdjflajdflajdfljasdlfjalsdjfljsdfljasdlfjlj",
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
