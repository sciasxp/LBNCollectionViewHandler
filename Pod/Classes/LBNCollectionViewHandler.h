//
//  LBNCollectionViewHandler.h
//
//  Created by Luciano Bastos Nunes on 10/12/15.
//  Copyright © 2015 Tap4Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBNCollectionViewHandler : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) id<NSFastEnumeration> items;
@property (nonatomic, readwrite) bool enableDeselectOnDidSelect;

- (instancetype)initWithItems:(id<NSFastEnumeration>)items
               CellIdentifier:(NSString * (^)(id item))cellIdentifier
                ConfigureCell:(void (^)(id cell, id item, NSIndexPath *indexPath))configureCellBlock
                    DidSelect:(void (^)(NSIndexPath *indexPath, id item))didSelectCellBlock
                   SizeForCel:(CGSize (^)(NSIndexPath *indexPath, id item))sizeForCell NS_DESIGNATED_INITIALIZER;

@end
