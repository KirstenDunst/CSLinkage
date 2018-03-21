//
//  CSLinkageTwo.m
//  Linkage
//
//  Created by 曹世鑫 on 2018/3/20.
//  Copyright © 2018年 曹世鑫. All rights reserved.
//

#import "CSLinkageTwo.h"
#import "CSCollectionViewCell.h"
#import "CSCollectionHeaderView.h"
#import "CSCollectionModel.h"
#import <YYModel.h>
#import <UIImageView+WebCache.h>

static NSString *collectionViewCellID = @"provinceCellID";
static NSString *CollectionViewHeaderViewID = @"cityCellID";
static NSString *provinceCellID = @"tableProvinceCellID";

@interface CSLinkageTwo ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    BOOL isDownOrUp;
}
@property(strong,nonatomic)UITableView * provinceTableView;//省级列表
@property(strong,nonatomic)UICollectionView * cityCollView;//市级列表
@property(strong,nonatomic)NSMutableArray * allDataArray;//省级总数据
@property(strong,nonatomic)NSMutableArray * cityDataArray;//市级总数据
@end

#define SCREEN_W [[UIScreen mainScreen] bounds].size.width
#define SCREEN_H [[UIScreen mainScreen] bounds].size.height

@implementation CSLinkageTwo
#pragma mark 懒加载
- (NSMutableArray *)allDataArray {
    if (_allDataArray == nil) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}
- (NSMutableArray *) cityDataArray {
    if (_cityDataArray == nil) {
        _cityDataArray  = [NSMutableArray array];
    }
    return _cityDataArray;
}
- (UITableView *)provinceTableView {
    if (_provinceTableView == nil) {
        _provinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W/3, SCREEN_H)];
        _provinceTableView.dataSource = self;
        _provinceTableView.delegate = self;
        _provinceTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _provinceTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _provinceTableView.showsVerticalScrollIndicator = NO;
        [_provinceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:provinceCellID];
    }
    return _provinceTableView;
}
- (UICollectionView *) cityCollView {
    if (_cityCollView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        flowLayout.minimumLineSpacing = 2;//设置两行之间的最小间距 float类型
//        flowLayout.minimumInteritemSpacing = 2; //设置两个cell水平之间的最小间距 float类型
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        
        _cityCollView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_W/3 , 0 , SCREEN_W/3*2, SCREEN_H) collectionViewLayout:flowLayout];
        _cityCollView.delegate = self;
        _cityCollView.dataSource = self;
        _cityCollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _cityCollView.showsVerticalScrollIndicator = NO;
        _cityCollView.showsHorizontalScrollIndicator = NO;
        [_cityCollView setBackgroundColor:[UIColor whiteColor]];
        //            注册cell
        [_cityCollView registerClass:[CSCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellID];
        //            注册分区头标题
        [_cityCollView registerClass:[CSCollectionHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:CollectionViewHeaderViewID];
    }
    return _cityCollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"与collection的联动";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.provinceTableView];
    [self.view addSubview:self.cityCollView];
    
    [self analysisPlistUse_YYModel];
    [self.provinceTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
#pragma mark  使用YYModel对数据进行解析
- (void)analysisPlistUse_YYModel {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *array = dict[@"data"][@"categories"];
    for (NSDictionary *dict in array) {
        CSCollectionModel *model = [CSCollectionModel yy_modelWithJSON:dict];
        [self.allDataArray addObject:model];
        NSArray *arr = dict [@"subcategories"];
        NSMutableArray *collectionArr = [NSMutableArray array];
        for ( NSDictionary *dic in arr) {
            CSCollectionNextModel *cityModel = [CSCollectionNextModel yy_modelWithJSON:dic];
            [collectionArr addObject:cityModel];
        }
        [self.cityDataArray addObject:collectionArr];
    }
}
#pragma mark --------------tableviewDelegate方法---------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.allDataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:provinceCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:provinceCellID];
    }
    CSCollectionModel *model = self.allDataArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}
// 选中 处理collectionView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cityCollView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

#pragma mark----------------collectionViewDelegate方法----------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.allDataArray.count;
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.cityDataArray[section] count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
    CSCollectionNextModel *model = self.cityDataArray[indexPath.section][indexPath.row];
    cell.model = model;
    cell.backgroundColor = [UIColor cyanColor];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(90, 130);
}
//设置区头，区尾的size大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(10, 10);
//}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(100,40);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//水平距离(上下两个item之间的最小距离)
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
//垂直距离（左右两个item之间的最小距离）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CSCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionViewHeaderViewID forIndexPath:indexPath];
    CSCollectionModel *model = self.allDataArray[indexPath.section];
    headerView.model = model;
    return headerView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (!isDownOrUp &&(collectionView.dragging || collectionView.decelerating)) {
        [self selectRowAtIndexPath:indexPath.section];
    }
}
// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath {
    if (isDownOrUp &&(collectionView.dragging || collectionView.decelerating)) {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}
// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index {
    [self.provinceTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static float lastOffsetY = 0;
    if (scrollView == self.cityCollView) {
        isDownOrUp = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
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
