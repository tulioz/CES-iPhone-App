//
//  AthleticsRootListController.m
//  UCDavis
//
//  Created by Fei Li on 11/21/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "AthleticsRootListController.h"
#import "AthleticsListViewController.h"
#import "ArticleWebViewController.h"
#import "CMWebBrowserViewController.h"

/**
 * Constant NSStrings for the root list cell titles.
 */
#define kTopEventsAndScores @"Top Events & Scores"
#define kTopStories @"Top Stories"
#define kSwimmingAndDiving @"Swimming & Diving"
#define kTrack @"Track"
#define kCrossCountry @"Cross Country"
#define kBaseball @"Baseball"
#define kBasketballMen @"Men's Basketball"
#define kFootball @"Football"
#define kGolfMen @"Men's Golf"
#define kSoccerMen @"Men's Soccer"
#define kTennisMen @"Men's Tennis"
#define kWaterPoloMen @"Men's Water Polo"
#define kWrestling @"Wrestling"
#define kBasketballWomen @"Women's Basketball"
#define kGolfWomen @"Women's Golf"
#define kGymnasticsWomen @"Women's Gymnastics"
#define kLacrosseWomen @"Women's Lacrosse"
#define kRowingWomen @"Women's Rowing"
#define kSoccerWomen @"Women's Soccer"
#define kSoftball @"Softball"
#define kTennisWomen @"Women's Tennis"
#define kVolleyballWomen @"Women's Volleyball"
#define kWaterPoloWomen @"Women's Water Polo"
#define kFieldHockey @"Field Hockey"

/**
 * Constant NSStrings for the appropriate feed URLs.
 *//*
#define fTopEventsAndScores @"http://www.ucdavisaggies.com/event-toolbar-rss.xml"
#define fTopStories @"http://www.ucdavisaggies.com/headline-rss.xml"
#define fSwimmingAndDiving @"http://www.ucdavisaggies.com/sports/c-swim/headline-rss.xml"
#define fTrack @"http://www.ucdavisaggies.com/sports/c-track/headline-rss.xml"
#define fCrossCountry @"http://www.ucdavisaggies.com/sports/c-xc/headline-rss.xml"
#define fBaseball @"http://www.ucdavisaggies.com/sports/m-basebl/headline-rss.xml"
#define fBasketballMen @"http://www.ucdavisaggies.com/sports/m-baskbl/headline-rss.xml"
#define fFootball @"http://www.ucdavisaggies.com/sports/m-footbl/headline-rss.xml"
#define fGolfMen @"http://www.ucdavisaggies.com/sports/m-golf/headline-rss.xml"
#define fSoccerMen @"http://www.ucdavisaggies.com/sports/m-soccer/headline-rss.xml"
#define fTennisMen @"http://www.ucdavisaggies.com/sports/m-tennis/headline-rss.xml"
#define fWaterPoloMen @"http://www.ucdavisaggies.com/sports/m-wpolo/headline-rss.xml"
#define fWrestling @"http://www.ucdavisaggies.com/sports/m-wrestl/headline-rss.xml"
#define fBasketballWomen @"http://www.ucdavisaggies.com/sports/w-baskbl/headline-rss.xml"
#define fGolfWomen @"http://www.ucdavisaggies.com/sports/w-golf/headline-rss.xml"
#define fGymnasticsWomen @"http://www.ucdavisaggies.com/sports/w-gym/headline-rss.xml"
#define fLacrosseWomen @"http://www.ucdavisaggies.com/sports/w-lacros/headline-rss.xml"
#define fRowingWomen @"http://www.ucdavisaggies.com/sports/w-rowing/headline-rss.xml"
#define fSoccerWomen @"http://www.ucdavisaggies.com/sports/w-soccer/headline-rss.xml"
#define fSoftball @"http://www.ucdavisaggies.com/sports/w-softbl/headline-rss.xml"
#define fTennisWomen @"http://www.ucdavisaggies.com/sports/w-tennis/headline-rss.xml"
#define fVolleyballWomen @"http://www.ucdavisaggies.com/sports/w-volley/headline-rss.xml"
#define fWaterPoloWomen @"http://www.ucdavisaggies.com/sports/w-wpolo/headline-rss.xml"
#define fFieldHockey @"http://www.ucdavisaggies.com/sports/w-fieldh/headline-rss.xml"*/


@implementation AthleticsRootListController
@synthesize rows;
@synthesize feedDictionary;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.rows = [[NSArray alloc] initWithObjects:kTopEventsAndScores, kTopStories, kSwimmingAndDiving, kTrack, 
			kCrossCountry, kBaseball, kFootball, kWrestling, kSoftball, kFieldHockey, kBasketballMen, kBasketballWomen,
			kWaterPoloMen, kWaterPoloWomen, kGolfMen, kGolfWomen, kSoccerMen, kSoccerWomen, kTennisMen, kTennisWomen,
			kGymnasticsWomen, kLacrosseWomen, kRowingWomen, kVolleyballWomen, nil];
	
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:@"RSSFeeds" ofType:@"plist"];
	NSDictionary *RSSFeeds = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
	self.feedDictionary = RSSFeeds;
	[RSSFeeds release];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rows count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	cell.textLabel.text = [self.rows objectAtIndex:indexPath.row];
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon.png", cell.textLabel.text]];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSString *feed = [self.rows objectAtIndex:indexPath.row];
	NSString *macReader = @"http://reader.mac.com/mobile/v1/";
	NSString *urlString = [macReader stringByAppendingString:[feedDictionary objectForKey:feed]];
	
	CMWebBrowserViewController *webBrowserViewController = [[CMWebBrowserViewController alloc] initWithNibName:@"CMWebBrowserViewController" bundle:nil];
	
	webBrowserViewController.websiteURL = [NSURL URLWithString:urlString];
	webBrowserViewController.title = feed;
	
	[self.navigationController pushViewController:webBrowserViewController animated:YES];
	[webBrowserViewController release];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

