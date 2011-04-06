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

@synthesize locationName;
@synthesize locationCategory;
@synthesize locationPhone;
@synthesize locationImage;

@synthesize locationAddress;
@synthesize locationCity;
@synthesize locationCountry;

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.nameLabel.text = self.locationName;
	self.typeLabel.text = self.locationCategory;
	self.imageView = [[UIImageView alloc] initWithImage:self.locationImage];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	
	self.locationName = viewingLocation.name;
	self.locationCategory = viewingLocation.category;
	self.locationPhone = viewingLocation.phone;
	
	NSData *previewImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:viewingLocation.imageURL]];

	UIImage *previewImage;
	if (previewImageData) {
		previewImage = [[UIImage alloc] initWithData:previewImageData];
	} else {
		previewImage = [UIImage imageNamed:@"agg2x.png"];
	}

	[self.imageView setImage:previewImage];
	TT_RELEASE_SAFELY(previewImage);
	
	self.locationAddress = viewingLocation.address;
	self.locationCity = viewingLocation.city;
	self.locationCountry = viewingLocation.country;
	
	contactTable = [[UITableView alloc] init];
	[contactTable setDelegate:self];
	[contactTable setDataSource:self];
	
	self.title = @"Info";
}

-(id)initWithType:(NSString *)typeId locationId:(NSString *)locationId {
    _typeId = typeId;
    _locationId = locationId;
    
    return self;
}

-(id) initWithLocation:(LocationItem *) theLocation {
	self = [super init];
	if (nil != self) {
		viewingLocation = theLocation;
	}
	
	return self;
}

-(void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading && TTIsStringWithAnyText(_myurl)) {
		// Create a request for the XML file passed by the init method
		TTURLRequest *request = [TTURLRequest requestWithURL:self.myurl delegate:self];
        
		// Define a cacheTimeout of 7 days
		NSTimeInterval cacheTimeout = 7 * 24 * 60 * 60;
		
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = cacheTimeout;
        
		// Prepare a response for the request
		TTURLJSONResponse *response = [[TTURLJSONResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		// Send out the request
		if ([request send]) {
			NSLog(@"Loaded URL From cache");
		} else {
			NSLog(@"Loaded URL from web");
		}
	}
}

-(void)requestDidFinishLoad:(TTURLRequest *)request {
	TTURLJSONResponse *response = request.response;
    NSLog(@"%@", [response.rootObject class]);
	TTDASSERT([response.rootObject isKindOfClass:[NSArray class]]);
	
	// rootObject represents the parsed JSON feed in an array of dictionaries representing nodes
	NSArray *feed = response.rootObject;
    
	NSArray *theLocations = feed;
    
	NSMutableArray *locations = [[NSMutableArray alloc] init];
    
	for (NSDictionary *currentLocationDictionary in theLocations) {
        NSDictionary *currentLocation = [currentLocationDictionary objectForKey:@"location"];
		LocationItem *location = [[LocationItem alloc] initWithLocationDictionary:currentLocation];
        
		[locations addObject:location];
		TT_RELEASE_SAFELY(location);
	}
    
	_finished = TRUE;
	
	// Clear out locations just in case we've done this before
	[_locations removeAllObjects];
	[_locations addObjectsFromArray:locations];
    
	TT_RELEASE_SAFELY(locations);
	
	[super requestDidFinishLoad:request];
}


-(IBAction) message {
	NSLog(@"pressed directions!");
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
	}
	
	if (indexPath.section == 0) {
		cell.textLabel.text = @"phone";
		cell.detailTextLabel.text = [self formatPhoneString:self.locationPhone];
	} else if (indexPath.section == 1) {
		cell.textLabel.text = @"address";
		cell.textLabel.numberOfLines = 3;
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.detailTextLabel.text = locationAddress;
	} 

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if (indexPath.section == 0) {
		NSLog(@"Selected Phone!");
		NSString *callString = [@"tel://" stringByAppendingString:self.locationPhone];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:callString]];
	}
	
}

/*-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		return 90;
	} else {
		return 45;
	}

}*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;	
}

-(NSString *) formatPhoneString:(NSString *) rawString {
//	http://www.iphonesdkarticles.com/2008/11/localizating-iphone-apps-custom.html
	NSRange range;
	range.length = 3;
	range.location = 3;
	
	NSString *areaCode = [rawString substringToIndex:3];
	NSString *phonePart1 = [rawString substringWithRange:range];
	NSString *phonePart2 = [rawString substringFromIndex:6];
	
	return [NSString stringWithFormat:@"+1 (%@) %@-%@", areaCode, phonePart1, phonePart2];		
}

-(NSString *) getURL {
    return [NSString stringWithFormat:@""];
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


@end
