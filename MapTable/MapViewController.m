//
//  MapViewController.m
//  MapTable
//
//  Created by Ricardo Reyes on 6/20/14.
//  Copyright (c) 2014 iOS Coding Lab. All rights reserved.
//

#import "MapViewController.h"

@import CoreLocation;
@import MapKit;

@interface MapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) CLGeocoder *geocoder;

@end

@implementation MapViewController

- (CLGeocoder *)geocoder
{
    if (!_geocoder)
    {
        _geocoder = [CLGeocoder new];
    }
    return _geocoder;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
                
                MKPointAnnotation *annotation = [MKPointAnnotation new];
                annotation.title = self.name;
                annotation.subtitle = self.address;
                annotation.coordinate = placemark.location.coordinate;
                
                [self.mapView addAnnotation:annotation];
                
                MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 500, 500);
                self.mapView.region = region;
                
                MKMapCamera *camera = [[MKMapCamera alloc] init];
                camera.centerCoordinate = placemark.location.coordinate;
                camera.altitude = 300.0f;
                camera.pitch = -45;
                self.mapView.camera = camera;
            }
        }
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    annotationView.annotation = annotation;
    annotationView.pinColor = MKPinAnnotationColorRed;
    return annotationView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
