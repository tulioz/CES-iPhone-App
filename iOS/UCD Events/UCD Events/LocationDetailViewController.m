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

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.nameLabel.text = self.viewingLocation.name;
	self.typeLabel.text = self.viewingLocation.category;
//	self.imageView = [[UIImageView alloc] initWithImage:self.viewingLocation.imageURL];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	
	
	NSData *previewImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:viewingLocation.imageURL]];

	UIImage *previewImage;
	if (previewImageData) {
		previewImage = [[UIImage alloc] initWithData:previewImageData];
	} else {
		previewImage = [UIImage imageNamed:@"agg2x.png"];
	}

	[self.imageView setImage:previewImage];
	TT_RELEASE_SAFELY(previewImage);
	
	contactTable = [[UITableView alloc] init];
	[contactTable setDelegate:self];
	[contactTable setDataSource:self];
	
	self.title = @"Info";
}

-(id)initWithType:(NSString *)typeId locationId:(NSString *)locationId {
    _typeId = typeId;
    _locationId = locationId;
    
    _locationItemDataModel = [[LocationItemJSONDataModel alloc] initWithTypeId:_typeId locationId:_locationId];
    
    viewingLocation = _locationItemDataModel.location;
    
    return self;
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
		cell.detailTextLabel.text = [self formatPhoneString:self.viewingLocation.phone];
	} else if (indexPath.section == 1) {
		cell.textLabel.text = @"address";
		cell.textLabel.numberOfLines = 3;
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.detailTextLabel.text = self.viewingLocation.address;
	} 

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if (indexPath.section == 0) {
		NSLog(@"Selected Phone!");
		NSString *callString = [@"tel://" stringByAppendingString:self.viewingLocation.phone];
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
