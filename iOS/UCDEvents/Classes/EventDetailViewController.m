//
//  EventDetailViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventDetailViewController.h"


@implementation EventDetailViewController

@synthesize nameLabel;
@synthesize dateLabel;
@synthesize timeLabel;
@synthesize descriptionScrollView;
@synthesize eventImageView;

@synthesize theEvent;

-(id)initWithEvent:(EventItem *)event {
	if (self = [super init]) {
		self.theEvent = event;
//		NSLog(@"Event is now %@", self.theEvent.name);
	}
	

	
	return self;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.nameLabel.text = theEvent.name;
	self.timeLabel.text = theEvent.time;
	self.descriptionScrollView.text = theEvent.description;
	self.descriptionScrollView.editable = NO;
	
	NSData *previewImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.theEvent.imageURL]];
	
	UIImage *previewImage;
	if (previewImageData) {
		previewImage = [[UIImage alloc] initWithData:previewImageData];
	} else {
		previewImage = [UIImage imageNamed:@"agg2x.png"];
	}
	
	[self.eventImageView setImage:previewImage];
	
//	TT_RELEASE_SAFELY(previewImageData);
	TT_RELEASE_SAFELY(previewImage);
	
	
	NSDate *eventDate = self.theEvent.date;
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM d, YYYY"];
	self.dateLabel.text = [dateFormatter stringFromDate:eventDate];	
	TT_RELEASE_SAFELY(dateFormatter);
}

-(void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = self.theEvent.name;
}

-(IBAction)viewLocation {
	if (theEvent.eventLocation) {
		LocationDetailViewController *locationDetail = [[LocationDetailViewController alloc] initWithLocation:theEvent.eventLocation];
		[self.navigationController pushViewController:locationDetail animated:YES];
	}
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
//	TT_RELEASE_SAFELY(self.eventImageView);
    [super dealloc];
}


@end
