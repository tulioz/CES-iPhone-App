//
//  MapViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //custom
    }
    
    return self;
}

-(void)viewDidLoad {
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
    
//    from http://stackoverflow.com/questions/2473706/how-do-i-zoom-an-mkmapview-to-the-users-current-location-without-cllocationmanage
    
//    [self.mapView.userLocation addObserver:self 
//                                forKeyPath:@"location" 
//                                   options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) 
//                                   context:NULL];
    
    self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(38.537051, -121.754909), MKCoordinateSpanMake(.005, .005));
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([self.mapView isUserLocationVisible]) {
//        [self moveOr
    }
}
                
@end
