//
//  BasicLauncherViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicLauncherViewController.h"

@interface BasicLauncherViewController(Private)
- (TTLauncherItem *)launcherItemWithTitle:(NSString *)pTitle image:(NSString *)image URL:(NSString *)url;
@end

@implementation BasicLauncherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"UCD Events";

    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    NSLog(@"did loadview on launcher");
    [super loadView];
	
	launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
	launcherView.backgroundColor = [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:1];
	self.navigationBarTintColor = [UIColor colorWithRed:.92 green:.76 blue:0 alpha:1];
	self.navigationBarStyle = UIStatusBarStyleDefault;
	launcherView.columnCount = 3;
    //	launcherView.rowCount = 4;
	launcherView.pages = [NSArray arrayWithObjects:
						  [NSArray arrayWithObjects:
						   [self launcherItemWithTitle:@"Weather" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@"http://www.accuweather.com/m/en-us/US/CA/Davis/Quick-Look.aspx"
                            ],
						   [self launcherItemWithTitle:@"Map" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@""
                            ],
						   [self launcherItemWithTitle:@"Events" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@"ucde://events/"
                            ],
						   [self launcherItemWithTitle:@"Special Deals" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@"ucde://ticketpicker/"
                            ],
						   [self launcherItemWithTitle:@"Restaurants" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@"ucde://locationList/Restaurants/1"
                            ],
						   [self launcherItemWithTitle:@"Shopping" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@"http://maps.google.com/maps/place?cid=9237992642497654431&q=panda+express+davis+ca&hl=en&sll=38.560978,-121.766971&sspn=0.035357,0.058199&ie=UTF8&ll=38.686582,-121.81057&spn=0,0&z=12"
                            ],
						   [self launcherItemWithTitle:@"Hotels" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@""
                            ],
                           [self launcherItemWithTitle:@"Banks" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@""
                            ],
						   [self launcherItemWithTitle:@"Hospitals" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@"ucde://locationList/Hospitals/hospitals"
                            ],
                           nil],
                          nil];
	launcherView.delegate = self;
    
	
	[self.view addSubview:launcherView];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    NSLog(@"viewdidload called on launcherview");
    [super viewDidLoad];
    
    self.title = @"UCD Events";
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark launcherView methods

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:launcherView action:@selector(endEditing)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:launcherView action:@selector(endEditing)];
	self.navigationItem.rightBarButtonItem = editButton;
	[editButton release];
}

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
	[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:item.URL] applyAnimated:YES]];
}

-(TTLauncherItem *)launcherItemWithTitle:(NSString *)pTitle image:(NSString *)image URL:(NSString *)url {
	TTLauncherItem *launcherItem = [[TTLauncherItem alloc] initWithTitle:pTitle 
																   image:image 
																	 URL:url	
															   canDelete:NO];
	return [launcherItem autorelease];
}

@end
