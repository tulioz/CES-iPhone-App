//
//  LocationListViewController.m
//  EventsAppDev
//
//  Created by William Binns-Smith on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationListViewController.h"
#import "MockDataSource.h"
#import "Settings.h"

@implementation LocationListViewController

@synthesize categoryName = _name;
@synthesize categoryURL = _url;
@synthesize delegate = _delegate;
@synthesize lastLocation;

-(id)initWithName:(NSString *)name {
	if (self = [super init]) {
		_delegate = nil;
		NSLog(@"called initwithName....");
		self.categoryName = name;
		self.categoryURL = @"http://localhost/~william/restaurants.xml";
	}
	
	return self;
}

-(id)initWithName:(NSString*)name url:(NSString *)url {
	if (self = [super init]) {
		_delegate = nil;
		self.categoryName = name;
		NSString *dataFormat = @"json";
//		NSString *apiBasePath = @"";
		NSString *urlString = [NSString stringWithFormat:@"%@get.php?format=%@&type=%@", apiPath, dataFormat, url]; // apiBasePath from Settings.h
//		urlString = @"http://localhost/~william/get.php?format=json&type=restaurants"; // Override url string
		self.categoryURL = urlString;
		
		NSLog(@"url is %@", self.categoryURL);
		
		self.navigationBarTintColor = [UIColor colorWithRed:.92 green:.76 blue:0 alpha:1];
		self.navigationBarStyle = UIStatusBarStyleDefault;
		
		self.dataSource = [[[LocationJSONDataSource alloc]
							initWithMyURL:self.categoryURL]
						   autorelease];

//		NSLog(@"received name of %@ and %@.", self.categoryName, self.categoryURL);
	}
	
	return self;
}

//-(void)didTapID:(NSString *)tapID {
//	[self.navigationController 
//}

/*-(void)navigationController:(UINavigationController *)navigationController
willShowViewController:(UIViewController *)viewController
animated:
(BOOL) animated {
	[viewController viewWillAppear:animated];
}

-(void)navigationController:(UINavigationController *)navigationController
didShowViewController:(UIViewController *)viewController
animated:
(BOOL)animated {
	[viewController viewDidAppear:animated];
}*/

-(void)loadView {
	[super loadView];
	
	TTTableViewController *searchController = [[[TTTableViewController alloc] init] autorelease];
	
	searchController.dataSource = [[[LocationJSONDataSource alloc]
									initWithMyURL:self.categoryURL]
								   autorelease];

//	searchController.dataSource = [[[MockSearchDataSource alloc] init] autorelease];
	
//	searchController.dataSource = self.dataSource;
	
	self.searchViewController = searchController;
	self.tableView.tableHeaderView = _searchController.searchBar;
	
}

//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//	[searchBar resignFirstResponder];
//}

-(void)viewDidLoad {
	self.title = self.categoryName;
	
	LocationManager *locationManager = [[LocationManager alloc] init];
	locationManager.delegate = self;
	[locationManager startUpdates];
}

-(void)createModel {
	NSLog(@"running createModel!");
	


//	self.dataSource = self.searchViewController.dataSource;
	
//	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: restaurantsURL];
//	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//	[connection release];
//	[request release];
	
//	LocationXMLDataSource *restaurantDataSource = [[LocationXMLDataSource alloc] init];
//	self.dataSource = restaurantDataSource;
//	TT_RELEASE_SAFELY(restaurantDataSource);
	
//	int numberOfRestaurants = [restaurants count];
	
//	NSMutableArray *restaurantItems = [[NSMutableArray alloc] init];
	
/*	for (int i = 0; i < numberOfRestaurants; i++) {
		NSDictionary *currentRestaurantDictionary = [restaurants objectAtIndex:i];
//		NSLog(@"the image url is:%@", [currentRestaurantDictionary objectForKey:@"imageURL"]);
		SelectableImageItem *newTableItem = [TTTableImageItem itemWithText:[currentRestaurantDictionary objectForKey:@"name"] imageURL:[currentRestaurantDictionary objectForKey:@"imageURL"] URL:nil];
//		newTableItem.imageStyle = [TTImageStyle styleWithImage:nil contentMode:UIViewContentModeScaleAspectFill size:CGSizeMake(120.f, 90.f) next:nil];
		[restaurantItems addObject:newTableItem];
	}
	
	TTListDataSource *restaurantDataSource = [[TTListDataSource alloc] initWithItems:restaurantItems];
	self.dataSource = restaurantDataSource;									  
*/
	
//	parser.rootObject;
//	NSArray *arrayOfRestaurants = [parser.rootObject objectForXMLNode];
//	arrayOfRestaurants;
	
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
	[_delegate locationListViewController:self didSelectObject:object];
	NSLog(@"didSelect called");

	TTTableSubtitleItem *theItem = object;
	
	NSDictionary *locationDict = theItem.userInfo;
	NSLog(@"Dict is %@", locationDict);

	LocationItem *theLocation = [locationDict objectForKey:@"location"];
	NSLog(@"Name is %@", theLocation.name);
	
	if (theLocation) {
		LocationDetailViewController *locationDetail = [[LocationDetailViewController alloc] initWithLocation:theLocation];
		[self.navigationController pushViewController:locationDetail animated:YES];
	}
	
//	[self.navigationController pushViewController:locationDetail animated:YES];
//	[[restaurantDataSource model] modelItems];
	
//	selectedRestaurant = [restaurants objectAtIndex:indexPath.row];
//	restaurantDetail = [[RestaurantDetailViewController alloc] initWithRestaurant:selectedRestaurant];
//	[self.navigationController pushViewController:restaurantDetail animated:YES];
//	[restaurantDetail release];
}

-(void)textField:(TTSearchTextField *)textField didSelectObject:(id)object {
	[_delegate locationListViewController:self didSelectObject:object];
}

-(BOOL)shouldOpenURL:(NSString *)URL {
	return NO;
}

-(void)updateLocation:(CLLocation *)location {
	self.lastLocation = location;
	NSLog(@"Updated location!!!");
}

//-(id)init {
//	return [self initWithURL:@"http://localhost/~william/restaurants.xml"];
//}

//-(id)initWithURL:(NSString *)feedURL {
//	NSLog(@"hello2!");
//	if (self = [super init]) {
//		NSLog(@"hello!");
//		NSURL *feedNSURL = [[NSURL alloc] initWithString:feedURL];
//		NSLog(feedURL);
//		self.restaurantsURL = feedNSURL;
//		[self parseXMLFile];
//	}
//	return self;
//}
		 

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

-(id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

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
    [super dealloc];
}


@end
