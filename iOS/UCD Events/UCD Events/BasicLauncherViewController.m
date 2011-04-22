//
//  BasicLauncherViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicLauncherViewController.h"
#import "Three20UI/UIViewAdditions.h"

@interface BasicLauncherViewController(Private)
- (TTLauncherItem *)launcherItemWithTitle:(NSString *)pTitle image:(NSString *)image URL:(NSString *)url;
@end

@implementation BasicLauncherViewController

- (TTStyle*)embossedButton:(UIControlState)state {
    if (state == UIControlStateNormal) {
        return
        [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
         [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
          [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0) blur:1 offset:CGSizeMake(0, 1) next:
           [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(255, 255, 255)
                                               color2:RGBCOLOR(216, 221, 231) next:
            [TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
             [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
              [TTTextStyle styleWithFont:nil color:TTSTYLEVAR(linkTextColor)
                             shadowColor:[UIColor colorWithWhite:255 alpha:0.4]
                            shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
    } else if (state == UIControlStateHighlighted) {
        return
        [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
         [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
          [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0.9) blur:1 offset:CGSizeMake(0, 1) next:
           [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(225, 225, 225)
                                               color2:RGBCOLOR(196, 201, 221) next:
            [TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
             [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
              [TTTextStyle styleWithFont:nil color:[UIColor whiteColor]
                             shadowColor:[UIColor colorWithWhite:255 alpha:0.4]
                            shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
    } else {
        return nil;
    }
}

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
    
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [self.navigationItem setRightBarButtonItem:modalButton animated:YES];
    [modalButton release];
	
	launcherView = [[TTLauncherView alloc] initWithFrame:CGRectMake(0, 0, 320, 385)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title.png"]];
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
                           [self launcherItemWithTitle:@"Info" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@""
                            ],
						   [self launcherItemWithTitle:@"UCD The Button" 
                                                 image:@"bundle://agg.png" 
                                                   URL:@""
                            ],
                           nil],
                          nil];
	launcherView.delegate = self;
   
    TTStyleSheet *globalStyleSheet = [TTStyleSheet globalStyleSheet];
//    [globalStyleSheet 
    
    TTButton *emergencyInfoButton = [TTButton buttonWithStyle:@"embossedButton:"];
    [emergencyInfoButton addTarget:@"ucde://navbarInfoButton" action:@selector(openURLFromButton:) forControlEvents:UIControlEventTouchUpInside];
    [emergencyInfoButton setFrame:CGRectMake(0, 372, 320, 50)];
    [emergencyInfoButton setBackgroundColor:[UIColor yellowColor]];
//    [emergencyInfoButton setBackgroundColor:[[TTStyleSheet globalStyleSheet] ]];
    [emergencyInfoButton setTitle:@"Emergency Information" forState:UIControlStateNormal];
//    [_myButton setImage:@"bundle://title.png" forState:UIControlStateNormal];
    
	[self.view addSubview:launcherView];
    [self.view addSubview:emergencyInfoButton];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    NSLog(@"viewdidload called on launcherview");
    [super viewDidLoad];
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

- (void)infoButtonAction {
    [[TTNavigator navigator] openURLAction:
     [[TTURLAction actionWithURLPath:@"ucde://navbarInfoButton"] applyAnimated:YES]];
}

@end
