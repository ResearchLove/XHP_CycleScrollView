//
//  RootViewController.m
//  XHP_CycleScrollView
//
//  Created by xiaohaiping on 16/8/8.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import "ShufflingStyleListViewController.h"
#import "ShufflingStyleListCell.h"
#import "ShufflingViewController.h"

@interface ShufflingStyleListViewController ()

@end

@implementation ShufflingStyleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"轮播样式"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView registerClass:[ShufflingStyleListCell class] forCellReuseIdentifier:@"ShufflingStyleListCell"];
    
    self.dataAry = @[@[@"本地加载 - 不带标题的图片轮播器"],@[@"网络加载 - 不带标题的图片轮播器",@"网络加载 - 带标题的图片轮播器",@"网络加载 - 自定义点视图轮播器"],@[@"网络加载 - 展示文字轮播器"]];
    
    // Do any additional setup after loading the view.
}

/**
 *  UITableViewDataSource
 *
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataAry objectAtIndex:section] count];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShufflingStyleListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShufflingStyleListCell"];
    cell.titleName = [self.dataAry[indexPath.section] objectAtIndex:indexPath.row];
    
    indexPath.row == 0 ? [cell setTopLineStyle:CellLineStyleFill] : [cell setTopLineStyle:CellLineStyleNone];
    indexPath.row == [self.dataAry[indexPath.section] count] - 1 ? [cell setBottonLineStyle:CellLineStyleFill] : [cell setBottonLineStyle:CellLineStyleDefault];
    return cell;
}

/**
 *  UITableViewDelegate
 *
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShufflingViewController *shuVC = [[ShufflingViewController alloc]init];
    if (indexPath.section == 0) {
       shuVC.shufflingStype = ShufflingStypeLocal;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
             shuVC.shufflingStype = ShufflingStypeNetworkNotTitle;
        }else if(indexPath.row == 1){
          shuVC.shufflingStype = ShufflingStypeNetworkTitle;
        }else{
            shuVC.shufflingStype = ShufflingStypeNetworkCustom;
        }
    }else if(indexPath.section == 2){
      shuVC.shufflingStype = ShufflingStypeNetworkText;
    }
    [self.navigationController pushViewController:shuVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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
