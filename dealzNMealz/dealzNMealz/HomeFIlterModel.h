//
//  HomeFIlterModel.h
//  dealzNMealz
//
//  Created by siva sandeep on 24/09/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeFIlterModel : NSObject

@end

@interface HomeFIlterLocationModel : NSObject
@property NSMutableArray *locationArray;
-(void)assignLocatioDataToModel:(NSArray*)arrayList;
@end

@interface HomeFIlterCategoryModel : NSObject
@property NSMutableArray *categoryArray;
-(void)assignCategoryDataToModel:(NSArray*)arrayList;
@end

@interface HomeFIlterPriceModel : NSObject
@property NSMutableArray *PriceArray;
@end




// data models

@interface HomeFIlterLocatioDatanModel : NSObject
@property NSString *locationName;
@end


@interface HomeFIlterCategoryDatanModel : NSObject
@property NSString *categoryID;
@property NSString *categoryName;

@end
