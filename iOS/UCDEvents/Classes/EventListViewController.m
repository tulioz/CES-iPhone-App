//
//  EventListViewController.m
//  EventsAppDev
//
//  Created by William Binns-Smith on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventListViewController.h"

@implementation EventListViewController

@synthesize categoryName = _name;
@synthesize categoryURL = _url;

-(id)initWithName:(NSString *)name {
	if (self = [super init]) {
		NSLog(@"called initwithName....");
		self.categoryName = name;
		self.categoryURL = @"http://localhost/~william/restaurants.xml";
	}
	
	return self;
}

-(id)initWithName:(NSString*)name url:(NSString *)url {
	if (self = [super init]) {
		self.categoryName = name;
		NSString *urlString = [apiPath stringByAppendingString:url];
		self.categoryURL = urlString;
		
		self.navigationBarTintColor = [UIColor colorWithRed:.92 green:.76 blue:0 alpha:1];
		self.navigationBarStyle = UIStatusBarStyleDefault;
		
	//	[map from:@"ucde://EventDetail/didTapID" toObject:self selector:@selector(didTapID:)];
		
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

//-(void)loadView {
//	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.f, 0.f, TTApplicationFrame().size.width, TT_ROW_HEIGHT)];
//	searchBar.delegate = self;
//	self.navigationItem.titleView = searchBar;
//	[searchBar release];
//}

//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//	[searchBar resignFirstResponder];
//}

-(void)viewDidLoad {
	self.title = self.categoryName;
}

-(void)createModel {
	NSLog(@"running createModel!");
	
	self.dataSource = [[[EventJSONDataSource alloc]
						initWithMyURL:self.categoryURL]
					   autorelease];
	
	
//	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: restaurantsURL];
//	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//	[connection release];
//	[request release];
	
//	EventXMLDataSource *restaurantDataSource = [[EventXMLDataSource alloc] init];
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
	NSLog(@"didSelect called");

	TTTableMessageItem *theItem = object;
	
	NSDictionary *EventDict = theItem.userInfo;
//	NSLog(@"Dict is %@", EventDict);

	EventItem *theEvent = [EventDict objectForKey:@"event"];
//	NSLog(@"Name is %@", theEvent.time);
	
	if (theEvent) {
		EventDetailViewController *EventDetail = [[EventDetailViewController alloc] initWithEvent:theEvent];
		[self.navigationController pushViewController:EventDetail animated:YES];
	}
	
//	[self.navigationController pushViewController:EventDetail animated:YES];
//	[[restaurantDataSource model] modelItems];
	
//	selectedRestaurant = [restaurants objectAtIndex:indexPath.row];
//	restaurantDetail = [[RestaurantDetailViewController alloc] initWithRestaurant:selectedRestaurant];
//	[self.navigationController pushViewController:restaurantDetail animated:YES];
//	[restaurantDetail release];
}

-(BOOL)shouldOpenURL:(NSString *)URL {
	return NO;
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
