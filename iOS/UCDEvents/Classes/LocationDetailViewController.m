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
@synthesize locationType;
@synthesize locationPhone;
@synthesize locationImage;

@synthesize locationAddress;
@synthesize locationCity;
@synthesize locationCountry;

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.nameLabel.text = self.locationName;
	self.typeLabel.text = self.locationType;
	self.imageView = [[UIImageView alloc] initWithImage:self.locationImage];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	
	self.locationName = viewingLocation.name;
	self.locationType = viewingLocation.type;
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

-(id) initWithLocation:(LocationItem *) theLocation {
	self = [super init];
	if (nil != self) {
		viewingLocation = theLocation;
	}
	
	return self;
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
