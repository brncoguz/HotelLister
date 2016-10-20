//
//  HotelsObject.h
//  HotelLister
//
//  Created by Oguz Birinci on 19/10/2016.
//  Copyright © 2016 Booking.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelsObject : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic) NSString *Id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *district;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *zipcode;
@property (nonatomic) NSNumber *latitude;
@property (nonatomic) NSNumber *longitude;
@property (nonatomic) NSNumber *star_rating;
@property (nonatomic) NSString *review_count;
@property (nonatomic) NSString *review_word;
@property (nonatomic) NSString *review_score;
@property (nonatomic) NSString *photo_url;

@end
