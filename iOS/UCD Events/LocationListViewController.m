//
//  LocationListViewController.m
//  EventsAppDev
//
//  Created by William Binns-Smith on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationListViewController.h"
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
	}
	
	return self;
}

-(void)loadView {
	[super loadView];
//	TTTableViewController *searchController = [[[TTTableViewController alloc] init] autorelease];
//	
//	searchController.dataSource = [[[LocationIndexJSONDataSource alloc]
//                                    initWithTypeId:_typeId]
//                                    autorelease];
//
//	searchController.dataSource = self.dataSource;
//	
//	self.searchViewController = searchController;
//	self.tableView.tableHeaderView = _searchController.searchBar;
	
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

-(void)textField:(TTSearchTextField *)textField didSelectObject:(id)object {
	[_delegate locationListViewController:self didSelectObject:object];
}

-(id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewVarHeightDelegate alloc] initWithController:self] autorelease];
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
