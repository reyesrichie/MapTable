//
//  ViewController.m
//  MapTable
//
//  Created by Ricardo Reyes on 6/20/14.
//  Copyright (c) 2014 iOS Coding Lab. All rights reserved.
//

#import "ViewController.h"
#import "Place.h"
#import "MapViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
            
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *plist;
@property (strong, nonatomic) NSMutableArray *places;

@end

@implementation ViewController

#pragma mark - Lazy instantiators

- (NSArray *)plist
{
    if (!_plist)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Places" ofType:@"plist"];
        _plist = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _plist;
}

- (NSMutableArray *)places
{
    if (!_places)
    {
        _places = [NSMutableArray new];
    }
    return _places;
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.plist enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        NSDictionary *placeDict = obj;
        
        Place *place = [[Place alloc] initWithName:placeDict[@"name"] address:placeDict[@"address"]];
        [self.places addObject:place];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MapSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Place *place = self.places[indexPath.row];
        
        MapViewController *mapVC = segue.destinationViewController;
        mapVC.name = place.name;
        mapVC.address = place.address;
    }
}

#pragma mark - Table View Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Place *place = self.places[indexPath.row];
    cell.textLabel.text = place.name;
    cell.detailTextLabel.text = place.address;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
