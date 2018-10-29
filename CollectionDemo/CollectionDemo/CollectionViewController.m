//
//  CollectionViewController.m
//  CollectionDemo
//
//  Created by 李鹏霖 on 2018/10/29.
//  Copyright © 2018年 李鹏霖. All rights reserved.
//

#import "CollectionViewController.h"

static NSString *const kCellIdentifier = @"UIColleciontCell";

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UILabel *indexLabel;


@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGPoint targetPoint = CGPointMake(self.collectionView.frame.size.width * self.index, 0);
     self.collectionView.contentOffset = targetPoint;
}
- (void)createUI {
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.indexLabel];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.indexLabel.text = [NSString stringWithFormat:@"%d",currentPage];
    
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];

    }
    return _collectionView;
}

-(UILabel *)indexLabel{
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc]init];
        _indexLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_index];
        _indexLabel.font = [UIFont systemFontOfSize:20];
        _indexLabel.frame  = CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2, 100, 100);
    }
    return _indexLabel;
}

@end
