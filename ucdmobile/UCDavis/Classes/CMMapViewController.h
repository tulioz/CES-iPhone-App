//
//  CMMapViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/11/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class CMBuilding;

@interface CMMapViewController : UIViewController <MKMapViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate, CLLocationManagerDelegate> {
	
	MKMapView *mapView;
	CLLocationManager *locationManager;
	
	NSArray *buildings;
	NSMutableArray *filteredBuildings;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSArray *buildings;
@property (nonatomic, retain) NSMutableArray *filteredBuildings;

- (IBAction)showCurrentLocation:(id)sender;
- (IBAction)didSelectMapType:(UISegmentedControl *)sender;
- (void)addBuildingToMap:(CMBuilding *)building;

@end
