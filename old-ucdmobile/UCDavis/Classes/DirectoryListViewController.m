//
//  DirectoryListViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/9/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "DirectoryListViewController.h"
#import "DirectoryDetailViewController.h"
#import "DatabaseHelper.h"
#import "CMPerson.h"
#import "MBProgressHud.h"

@implementation DirectoryListViewController

@synthesize peopleSearchBar;
@synthesize peopleDictionary;
@synthesize sectionTitles;

- (void)dealloc {
	[peopleSearchBar release];
	[peopleDictionary release];
	[sectionTitles release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Directory Search";
	// set up operation queue for thread fetching of names
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount:1];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.sectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [self.sectionTitles objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
	// could also loop from A to Z
	return [NSArray arrayWithObjects:UITableViewIndexSearch, @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (index == 0) { // UITableViewIndexSearch
		[tableView scrollRectToVisible:[[tableView tableHeaderView] bounds] animated:NO];
    }
    return index - 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// the section titles are the keys
    return [[self.peopleDictionary objectForKey:[self.sectionTitles objectAtIndex:section]] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	CMPerson *person = [[self.peopleDictionary objectForKey:[self.sectionTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	cell.textLabel.text = person.name;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	CMPerson *person = [[self.peopleDictionary objectForKey:[self.sectionTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];

	DirectoryDetailViewController *directoryDetailViewController = [[DirectoryDetailViewController alloc] initWithNibName:@"DirectoryDetailViewController" bundle:nil];
	directoryDetailViewController.person = person;
	[self.navigationController pushViewController:directoryDetailViewController animated:YES];
	[directoryDetailViewController release];
	
}

#pragma mark -
#pragma mark People search methods

- (void)searchForPersonWithName:(NSString *)name {
	self.peopleSearchBar.text = name;
	[self searchBarSearchButtonClicked:self.peopleSearchBar];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	// limit searches to >= 3 characters to help on db load
	if([searchBar.text length] < 3) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Search String" message:@"Please enter a longer query." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		return;
	}
	
	// loading the names might take a while
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousLoadPeople:) object:searchBar.text];
    [operationQueue addOperation:operation]; // send to background thread
    [operation release];
	
	progressHud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:progressHud];
	progressHud.labelText = [NSString stringWithFormat:@"Finding all %@s...", searchBar.text];
	[progressHud show:YES];
	[searchBar resignFirstResponder];
}

- (void)synchronousLoadPeople:(NSString *)searchString {
	self.peopleDictionary = [NSMutableDictionary dictionary];
	NSSortDescriptor *lastNameSort = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
	NSSortDescriptor *firstNameSort = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
	NSArray *persons = [[[DatabaseHelper sharedInstance] peopleWithNameLike:searchString] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:lastNameSort, firstNameSort, nil]];
	[lastNameSort release];
	[firstNameSort release];
	for(CMPerson *person in persons) {
		if([peopleDictionary objectForKey:person.lastNameInitial] == nil) {
			[peopleDictionary setObject:[NSMutableArray array] forKey:person.lastNameInitial];
		}
		NSMutableArray *mutPeople = [peopleDictionary objectForKey:person.lastNameInitial];
		[mutPeople addObject:person];
	}
	self.sectionTitles = [[self.peopleDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
	[self performSelectorOnMainThread:@selector(didFinishLoadingPeople) withObject:nil waitUntilDone:NO];
}

- (void)didFinishLoadingPeople {
	[self.tableView reloadData];

	[progressHud removeFromSuperview];
	[progressHud release];
}

@end

