//
//  LBNCollectionViewHandler.m
//
//  Created by Luciano Bastos Nunes on 10/12/15.
//  Copyright © 2015 Tap4Mobile. All rights reserved.
//

#import "LBNCollectionViewHandler.h"

@interface LBNCollectionViewHandler ()

@property (nonatomic, strong) void (^configureCellBlock) (id, NSDictionary *, NSIndexPath *);
@property (nonatomic, strong) NSString * (^cellIdentifierForItem) (id);
@property (nonatomic, strong) void (^didSelectCellBlock) (NSIndexPath *, id);
@property (nonatomic, strong) CGSize (^collectionCellSize) (NSIndexPath *, id);

@end

@implementation LBNCollectionViewHandler

- (instancetype)initWithItems:(id<NSFastEnumeration>)items
               CellIdentifier:(NSString * (^)(id item))cellIdentifier
                ConfigureCell:(void (^)(id cell, id item, NSIndexPath *indexPath))configureCellBlock
                    DidSelect:(void (^)(NSIndexPath *indexPath, id item))didSelectCellBlock
                   SizeForCel:(CGSize (^)(NSIndexPath *indexPath, id item))sizeForCell {
    
    self = [super init];
    
    if (self) {
        
        _items = items;
        _cellIdentifierForItem = cellIdentifier;
        _configureCellBlock = configureCellBlock;
        _didSelectCellBlock = didSelectCellBlock;
        _collectionCellSize = sizeForCell;
    }
    
    return self;
}

- (instancetype)init {
    
    self = [self initWithItems:nil CellIdentifier:nil ConfigureCell:nil DidSelect:nil SizeForCel:nil];
    
    return self;
}

#pragma mark - Private

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    
    if ([(NSObject *)self.items isKindOfClass:[NSArray class]]) {
        
        return self.items[indexPath.row];
        
    } else {
        
        return self.items[@"sections"][indexPath.section][@"items"][indexPath.row];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if ([(NSObject *)self.items isKindOfClass:[NSArray class]]) {
        
        return 1;
    }
    
    return [self.items[@"sections"] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if ([(NSObject *)self.items isKindOfClass:[NSArray class]]) {
        
        return [(NSArray *)self.items count];
    }
    
    return [self.items[@"sections"][section][@"items"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id item = [self itemAtIndexPath:indexPath];
    
    NSString *cellIdentifier = self.cellIdentifierForItem(item);
    
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (self.configureCellBlock) {
        
        self.configureCellBlock(cell, item, indexPath);
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(0, 0);
    
    if (self.collectionCellSize) {
        
        size = self.collectionCellSize(indexPath, [self itemAtIndexPath:indexPath]);
    }
    
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.enableDeselectOnDidSelect) {
        
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    
    if (self.didSelectCellBlock) {
        
        id item = [self itemAtIndexPath:indexPath];
        
        self.didSelectCellBlock(indexPath, item);
    }
}

@end
