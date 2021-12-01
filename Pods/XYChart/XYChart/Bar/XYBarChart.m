//
//  XYBarChart.m
//  XYChart
//
//  Created by Daniel on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//


#import "XYBarChart.h"
#import "XYBarView.h"
#import "XYBarCell.h"
#import "XYChart.h"

@interface XYBarChart ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XYBarChart

- (instancetype)initWithChartView:(XYChart *)chartView
{
    self = [super init];
    if (self) {
        _chartView = chartView;
        [self initBaseUIElements];
    }
    return self;
}

- (void)initBaseUIElements
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[XYBarCell class] forCellWithReuseIdentifier:NSStringFromClass([XYBarCell class])];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    [_collectionView reloadData];
}

#pragma mark - XYChartContainer

- (void)reloadData:(BOOL)animation
{
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_chartView.dataSource numberOfRowsInChart:_chartView];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XYBarCell class]) forIndexPath:indexPath];
    [cell setDataSource:_chartView.dataSource row:indexPath.row chart:_chartView];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    const BOOL isAutoSizing = [_chartView.dataSource autoSizingRowInChart:_chartView];
    CGFloat rows = [_chartView.dataSource numberOfRowsInChart:_chartView];
    rows = rows>0 ? rows : 1;
    const CGFloat rowWidth = isAutoSizing ? xy_width(self)/rows : [_chartView.dataSource rowWidthOfChart:_chartView];
    return CGSizeMake(rowWidth, xy_height(self));
}

@end
