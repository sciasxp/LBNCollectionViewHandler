# LBNCollectionViewHandler

[![CI Status](http://img.shields.io/travis/Luciano Bastos Nunes/LBNCollectionViewHandler.svg?style=flat)](https://travis-ci.org/Luciano Bastos Nunes/LBNCollectionViewHandler)
[![Version](https://img.shields.io/cocoapods/v/LBNCollectionViewHandler.svg?style=flat)](http://cocoapods.org/pods/LBNCollectionViewHandler)
[![License](https://img.shields.io/cocoapods/l/LBNCollectionViewHandler.svg?style=flat)](http://cocoapods.org/pods/LBNCollectionViewHandler)
[![Platform](https://img.shields.io/cocoapods/p/LBNCollectionViewHandler.svg?style=flat)](http://cocoapods.org/pods/LBNCollectionViewHandler)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LBNCollectionViewHandler is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LBNCollectionViewHandler"
```

## Author

Luciano Bastos Nunes, sciasxp@gmail.com

## License

LBNCollectionViewHandler is available under the MIT license. See the LICENSE file for more info.

## Usage

Include the file LBNCollectionViewHandler.h in your class:
```objective-c
#import LBNCollectionViewHandler.h
```

After including LBNCollectionViewHandler.h in the class so you can use it, you need to create a global property to keep reference to LBNCollectionViewHndler instance that can be made this way:
```objective-c
@property (nonatomic, strong) LBNCollectionViewHandler *mainCollectionViewHandler;
```

And this is how you can use it:
```objective-c

NSDictionary *sections = 
@{@"sections":
    @[
        @{@"headerConfig":@{@"title":@"Novidades"},
        @"items":@[@"Title 1", @"Title 2"]}
     ]
};

self.mainCollectionViewHandler = [LBNCollectionViewHandler allloc] initWithItems:<NSARRAY WITH THE ITENS TO BE SHOWN IN THE TABLE VIEW OR A NSDICTIONARY WITH THE ABOVE FORMAT> CellIdentifier:^NSString *(id item) {

    return <RETURN CELL IDENTIFIER,	AS IN YOUR COLLECTIONVIEWCELL AT STORYBOARD, FOR AN ITEM>;

} ConfigureCell:^(id cell, id item, NSIndexPath *indexPath) {

    <CONFIGURE YOUR CELL AS WANTED>

} DeleteCell:<NOT IMPLEMENTED YET. USE NIL> HeightForItem:^CGFloat(id item) {

    return <RETURN CELL HEIGHT FOR AN ITEM>;

} DidSelect:^(NSIndexPath *indexPath, id item) {

    <WHAT TO DO WHEN A ITEM IS SELECTED IN THE COLLECTION>

} ViewForSectionHeader:^UIView *(NSInteger section, id item) {

    <CREATE AND RETURN THE VIEW THAT WILL BE A HEADER FOR THIS SECTION>

    //OBS: <<item>> is the content of headerConfig key

} HeightForHeader:^CGFloat(NSInteger, id) {

    <RETURN THE HEIGHT FOR THIS SECTIONS HEADER>

    //OBS: <<item>> is the content of headerConfig key
}

self.mainCollectionView.dataSource = self.mainCollectionViewHandler;
self.mainCollectionView.delegate = self.mainCollectionViewHandler;
self.mainCollectionViewHeader.enableDeselectOnDidSelect = YES; //It will automatically deselect a cell

```
OBS: Everything in between "<>" are instructions and have to be replaced by your code.