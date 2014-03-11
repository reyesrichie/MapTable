//
//  MapTableMapViewController.m
//  MapTable
//
//  Created by Laboratorio San Agustin on 8/03/14.
//  Copyright (c) 2014 Online Studio Productions LLC. All rights reserved.
//

@import MapKit;
@import CoreLocation;

#import "MapTableMapViewController.h"

@interface MapTableMapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLGeocoder *geocoder;

@end

@implementation MapTableMapViewController

- (CLGeocoder *)geocoder
{
    if (!_geocoder)
    {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.geocoder geocodeAddressString:self.address completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if (!error)
        {
            if ([placemarks count])
            {
                CLPlacemark *placemark = [placemarks firstObject];
                
                self.mapView.region = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 250, 250);
                
                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                annotation.coordinate = placemark.location.coordinate;
                annotation.title = self.address;
                [self.mapView addAnnotation:annotation];
            }
        }
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    pin.annotation = annotation;
    pin.pinColor = MKPinAnnotationColorRed;
    return pin;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
