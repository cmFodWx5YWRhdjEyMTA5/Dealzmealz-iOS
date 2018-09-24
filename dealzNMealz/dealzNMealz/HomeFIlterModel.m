//
//  HomeFIlterModel.m
//  dealzNMealz
//
//  Created by siva sandeep on 24/09/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import "HomeFIlterModel.h"

@implementation HomeFIlterModel

@end


@implementation HomeFIlterCategoryModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.categoryArray = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)assignCategoryDataToModel:(NSArray*)arrayList {
    
    [_categoryArray removeAllObjects];
    [_categoryArray addObjectsFromArray:arrayList];

/*    for (int i = 0; i< [arrayList count]; i++) {
        NSDictionary *singelObj = [arrayList objectAtIndex:i];
        
        NSString *catName = [NSString stringWithFormat:@"%@",[singelObj valueForKey:@"category_name"]];
        NSString *catId = [NSString stringWithFormat:@"%d",[[singelObj valueForKey:@"catid"]intValue]];
        
        HomeFIlterCategoryDatanModel *dataModel = [[HomeFIlterCategoryDatanModel alloc]init];
        dataModel.categoryID = catId;
        dataModel.categoryName = catName;
        [_categoryArray addObject:dataModel];
    }*/
}

@end


@implementation HomeFIlterLocationModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.locationArray = [[NSMutableArray alloc]init];
    }
    return self;
}



-(void)assignLocatioDataToModel :(NSArray*)arrayList{
    [_locationArray removeAllObjects];
    [_locationArray addObjectsFromArray:arrayList];
//    for (int i = 0; i< [arrayList count]; i++) {
//        NSDictionary *singelObj = [arrayList objectAtIndex:i];
//        NSString *areaName = [NSString stringWithFormat:@"%@",[singelObj valueForKey:@"area"]];
//        HomeFIlterLocatioDatanModel *dataModel = [[HomeFIlterLocatioDatanModel alloc]init];
//        dataModel.locationName = areaName;
//        [_locationArray addObject:dataModel];
//    }
}

@end


@implementation HomeFIlterPriceModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.PriceArray = [[NSMutableArray alloc]init];
        [self addItemsToArray];
    }
    return self;
}


- (void)addItemsToArray{
    
    [self.PriceArray addObject:@"100 Rs -300 RS"];
    [self.PriceArray addObject:@"301 Rs -600 RS"];
    [self.PriceArray addObject:@"600 Rs -1000 RS"];
    [self.PriceArray addObject:@"1000 RS Plus"];
}



@end



@implementation HomeFIlterCategoryDatanModel
@end

@implementation HomeFIlterLocatioDatanModel
@end

