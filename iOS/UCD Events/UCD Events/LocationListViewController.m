//
//  LocationListViewController.m
//  EventsAppDev
//
//  Created by William Binns-Smith on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationListViewController.h"
//#import "MockDataSource.h"
#import "Settings.h"

@implementation LocationListViewController

@synthesize categoryName = _name;
@synthesize categoryURL = _url;
@synthesize delegate = _delegate;

-(id)initWithName:(NSString*)name typeId:(NSInteger *)typeId {
	if (self = [super init]) {
		_delegate = nil;
		self.categoryName = name;
        _typeId = typeId;
		
		self.navigationBarTintColor = [UIColor colorWithRed:.92 green:.76 blue:0 alpha:1];
		self.navigationBarStyle = UIStatusBarStyleDefault;
	}
	
	return self;
}

-(void)loadView {
	[super loadView];
	
	TTTableViewController *searchController = [[[TTTableViewController alloc] init] autorelease];
	
	searchController.dataSource = [[[LocationIndexJSONDataSource alloc]
                                    initWithTypeId:_typeId]
                                    autorelease];

//	searchController.dataSource = self.dataSource;
	
	self.searchViewController = searchController;
	self.tableView.tableHeaderView = _searchController.searchBar;
	
}

//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//	[searchBar resignFirstResponder];
//}

-(void)viewDidLoad {
	self.title = self.categoryName;
}

-(void)createModel {
    self.dataSource = [[[LocationIndexJSONDataSource alloc]
                        initWithTypeId:_typeId]
                       autorelease];
}

/*-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
	[_delegate locationListViewController:self didSelectObject:object];

	TTTableSubtitleItem *theItem = object;
	
	NSDictionary *locationDict = theItem.userInfo;

	LocationItem *theLocation = [locationDict objectForKey:@"location"];
	
	if (theLocation) {
		LocationDetailViewController *locationDetail = [[LocationDetailViewController alloc] initWithLocation:theLocation];
		[self.navigationController pushViewController:locationDetail animated:YES];
	}
}*/

-(void)textField:(TTSearchTextField *)textField didSelectObject:(id)object {
	[_delegate locationListViewController:self didSelectObject:object];
}

//-(BOOL)shouldOpenURL:(NSString *)URL {
//	return NO;
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

//-(BOOL)persistView:(NSMutableDictionary *)state {
//    return NO;
//}


@end
