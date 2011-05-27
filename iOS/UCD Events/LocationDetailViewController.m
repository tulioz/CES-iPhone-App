//
//  LocationDetailViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationDetailViewController.h"


@implementation LocationDetailViewController

@synthesize viewingLocation;
@synthesize nameLabel;
@synthesize typeLabel;
@synthesize phoneButton;
@synthesize imageView;

@synthesize contactTable;

@synthesize delegate = _delegate;

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.nameLabel.text = self.viewingLocation.name;
	self.typeLabel.text = self.viewingLocation.category;
//	self.imageView = [[UIImageView alloc] initWithImage:self.viewingLocation.imageURL];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Info";
}

-(id)initWithLocationId:(NSString *)locationId {
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        NSLog(@"LocationDetailView called with locationId %@", locationId);
        _locationId = locationId;
    }

    return self;
}

-(void)createModel {
    self.dataSource = [[[LocationItemJSONDataSource alloc] initWithLocationId:_locationId] autorelease];
}

- (void)dealloc {
	TT_RELEASE_SAFELY(imageView);
    [super dealloc];
}

-(id<UITableViewDelegate>)createDelegate {
    return [[[TTTableViewVarHeightDelegate alloc] initWithController:self] autorelease];
//	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
