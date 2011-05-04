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

-(id)initWithTypeId:(NSString *)typeId locationId:(NSString *)locationId {
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        NSLog(@"LocationDetailView called with typeId %@ and locationId %@", typeId, locationId);
        _typeId = typeId;
        _locationId = locationId;
    }

    return self;
}

-(void)createModel {
    self.dataSource = [[[LocationItemJSONDataSource alloc] initWithTypeId:_typeId locationId:_locationId] autorelease];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	TT_RELEASE_SAFELY(imageView);
    [super dealloc];
}

-(id<UITableViewDelegate>)createDelegate {
    return [[[TTTableViewVarHeightDelegate alloc] initWithController:self] autorelease];
//	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

//-(BOOL)persistView:(NSMutableDictionary *)state {
//    return NO;
//}

@end
