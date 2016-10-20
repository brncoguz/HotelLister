//
//  ViewController.m
//  HotelLister
//
//  Copyright (c) 2015 Booking.com. All rights reserved.
//

#import "HotelsViewController.h"
#import "HotelsObject.h"

@interface HotelsViewController()

@property (nonatomic,strong) NSMutableArray *objectHolderArray;
@property (nonatomic, strong) NSMutableDictionary *hotels;
@property (nonatomic, strong) NSArray *hotelKeys;

@end

@implementation HotelsViewController

NSDictionary *animals;
NSArray *animalSectionTitles;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self editTheData];
    
}

-(NSMutableArray *)objectHolderArray{
    if(!_objectHolderArray) _objectHolderArray = [[NSMutableArray alloc]init];
    return _objectHolderArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.hotels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionTitle = [self.hotelKeys objectAtIndex:section];
    NSArray *sectionHotels = [self.hotels objectForKey:sectionTitle];
    return [sectionHotels count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%@",[[[self.hotels allKeys] sortedArrayUsingSelector: @selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 134;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    
    NSString *sectionTitle = [self.hotelKeys objectAtIndex:indexPath.section];
    NSArray *sectionHotels = [self.hotels objectForKey:sectionTitle];
    HotelsObject * ho = [sectionHotels objectAtIndex:indexPath.row];
    
    
    [((UIImageView *)[cell viewWithTag:1001]) sd_setImageWithURL:[NSURL URLWithString:ho.photo_url]];
    
    
    [((UILabel *)[cell viewWithTag:1000]) setText:[NSString stringWithFormat:@"%@ - %.0f star", ho.name, [ho.star_rating doubleValue]]];
    [((UILabel *)[cell viewWithTag:1002]) setText:[NSString stringWithFormat:@"%@ %@ \n %@ \n %@",ho.address, ho.district, ho.city, ho.zipcode]];
    
    return cell;
}


- (void)editTheData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hotels" ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSArray* dataArray = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSSortDescriptor *lastDescriptor = [[NSSortDescriptor alloc] initWithKey:@"review_score"
                                                                   ascending:NO selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:lastDescriptor, nil];
    NSArray *arr = [dataArray sortedArrayUsingDescriptors:descriptors];
    for (int i = 0; i < arr.count; i++) {
        HotelsObject *currentTrip = [[HotelsObject alloc] initWithDictionary:[arr objectAtIndex:i]];
        if ([currentTrip.review_score doubleValue] > 8.0)
        [self.objectHolderArray addObject:currentTrip];
    }
    
    NSMutableDictionary *grouped = [[NSMutableDictionary alloc] initWithCapacity:self.objectHolderArray.count];
    for (NSDictionary *dict in self.objectHolderArray) {
        id key = [dict valueForKey:@"city"];
        
        NSMutableArray *tmp = [grouped objectForKey:key];
        if (tmp == nil) {
            tmp = [[NSMutableArray alloc] init];
            [grouped setObject:tmp forKey:key];
        }
        [tmp addObject:dict];
    }
    self.hotels = [grouped copy];
    self.objectHolderArray = nil;
    self.hotelKeys = [[self.hotels allKeys] sortedArrayUsingSelector: @selector(localizedCaseInsensitiveCompare:)];
}

@end
