//
//  MapTableViewController.m
//  MapTable
//
//  Created by Laboratorio San Agustin on 8/03/14.
//  Copyright (c) 2014 Online Studio Productions LLC. All rights reserved.
//

#import "MapTableViewController.h"
#import "MapTablePlace.h"
#import "MapTableMapViewController.h"

@interface MapTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *plist;
@property (strong, nonatomic) NSMutableArray *places;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MapTableViewController

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
        _places = [[NSMutableArray alloc] init];
    }
    return _places;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.plist enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        MapTablePlace *place = [[MapTablePlace alloc] initWithName:obj[@"name"] address:obj[@"address"] andImage:nil];
        [self.places addObject:place];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MapSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MapTablePlace *place = self.places[indexPath.row];
        
        MapTableMapViewController *vc = segue.destinationViewController;
        vc.address = place.address;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MapTableViewControllerCell"];
    MapTablePlace *place = self.places[indexPath.row];
    cell.textLabel.text = place.name;
    cell.detailTextLabel.text = place.address;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"MapSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
