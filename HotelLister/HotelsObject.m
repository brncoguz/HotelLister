//
//  HotelsObject.m
//  HotelLister
//
//  Created by Oguz Birinci on 19/10/2016.
//  Copyright © 2016 Booking.com. All rights reserved.
//

#import "HotelsObject.h"

@implementation HotelsObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self){
        self.Id = [dictionary objectForKey:@"id"];
        self.name = [dictionary objectForKey:@"name"];
        self.address = [dictionary objectForKey:@"address"];
        self.district = [dictionary objectForKey:@"district"];
        self.city = [dictionary objectForKey:@"city"];
        self.zipcode = [dictionary objectForKey:@"zipcode"];
        self.latitude = [dictionary objectForKey:@"latitude"];
        self.longitude = [dictionary objectForKey:@"longitude"];
        self.star_rating = [dictionary objectForKey:@"star_rating"];
        self.review_count = [dictionary objectForKey:@"review_count"];
        self.review_word = [dictionary objectForKey:@"review_word"];
        self.review_score = [dictionary objectForKey:@"review_score"];
        self.photo_url = [[dictionary objectForKey:@"photo_url" ] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    }
    return self;
}


@end
