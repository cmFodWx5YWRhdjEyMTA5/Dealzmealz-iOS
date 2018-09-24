//
//  URLList.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/9/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#ifndef URLList_h
#define URLList_h

#define BASE_URL @"https://dealznmealz.com/mobileapi.php?"


#define BASE_IMAGE_URL @"https://dealznmealz.com/"
#define MOST_SEARCHED_IMAGE_URL BASE_IMAGE_URL@"image/home1.jpg"
#define MOST_REVIEWED_IMAGE_URL BASE_IMAGE_URL@"image/home2.jpeg"
#define LATEST_RESTO_IMAGE_URL BASE_IMAGE_URL@"image/home4.jpg"



#define HOME_PAGE_DISCOUNTS_URL BASE_URL@"discount="
#define HOME_PAGE_BANNER_URL BASE_URL@"paidbanners="

#define HOT_DEALS_URL BASE_URL@"hotdealz="

#define MOST_SEARCHED_RESTO_URL BASE_URL@"searched="

#define LATEST_RESTO_URL BASE_URL@"latest="

#define REVIEWED_RESTO_URL BASE_URL@"reviewed="

#define LOGIN_URL BASE_URL"loginuser=1&username="

#define SIGNUP_OTP_RECEIVE_URL BASE_URL@"signup=1&name="

#define SIGNUP_RECEIVE_URL BASE_URL@"insertusersigup=1&name="

#define DISCOUNT_DETAILS_RESTAURENTS_URL BASE_URL@"discdetails="

#define OFFER_DETAILS_RESTAURENTS_URL BASE_URL@"offdetails="

#define DISC_RESTO_DETAIL_URL BASE_URL@"offrestdisc="

#define BOOK_TBL_URL BASE_URL@"bookatable="


#define REVIEWED_RESTO_DETAIL_URL BASE_URL@"reviewed="
#define LATEST_RESTO_DETAIL_URL BASE_URL@"searched="
#define SEARCHED_RESTO_DETAIL_URL BASE_URL@"offrestdisc="

#define SEARCH_CATEGORY_URL BASE_URL@"callcategory=1"
#define SEARCH_LOCATION_URL BASE_URL@"calllocation=1"

#define FILTER_CAT_LOC_COS_URL BASE_URL@"filterdata=1&category="


//https://dealznmealz.com/mobileapi.php?filterdata=1&category=cat&location=loc&cost=cost
#endif /* URLList_h */
