//
//  InfoViewController.m
//  UCD Events
//
//  Created by Ofer Goldstein on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import "InfoViewController.h"

@implementation InfoViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tableViewStyle = UITableViewStyleGrouped;
    }

    return self;
}

- (void) createModel {
                        
    NSMutableArray* items = [NSMutableArray array];
    NSMutableArray* sections = [NSMutableArray array];
    
    [sections addObject:@"UC Davis Police Department"];
    [sections addObject:@"UC Davis Fire Department"];
    [sections addObject:@"Sutter Davis Hospital"];
    [sections addObject:@"City of Davis Police Department"];
	[sections addObject:@"City of Davis Fire Department"];
	
    // UC Davis Police Department
    NSArray *UCDPD = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:[self formatPhoneString:UCDPDEmergencyPhone] caption:@"emergency" URL:[NSString stringWithFormat:@"tel:%@", UCDPDEmergencyPhone]],
                      [TTTableCaptionItem itemWithText:[self formatPhoneString:UCDPDNonEmergencyPhone] caption:@"non-emergency" URL:[NSString stringWithFormat:@"tel:%@", UCDPDNonEmergencyPhone]],
					  nil
                      ];
    
    
    // UC Davis Fire Department
	NSString *UCDFDurl = [self openGoogleMapsWithDestinationLatitude:UCDFireLat longitude:UCDFireLong];
    NSArray *UCDFD = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:[self formatPhoneString:UCDFireDepartmentPhone] caption:@"phone" URL:[NSString stringWithFormat:@"tel:%@", UCDFireDepartmentPhone]],                    
					  [TTTableCaptionItem itemWithText:SutterDHSAddr caption:@"address" URL:UCDFDurl],
					  nil
                      ];
	
	// Sutter Davis Hospital
	NSString *SutterDHSurl = [self openGoogleMapsWithDestinationLatitude:SutterDHSLat longitude:SutterDHSLong];
    NSArray *SutterDHS = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:[self formatPhoneString:SutterDHSPhone] caption:@"phone" URL:[NSString stringWithFormat:@"tel:%@", SutterDHSPhone]],
                      [TTTableCaptionItem itemWithText:SutterDHSAddr caption:@"address" URL:SutterDHSurl],
                      nil
                      ];
					  
	// City of Davis Police Dept
	NSString *DavisPDurl = [self openGoogleMapsWithDestinationLatitude:DavisPDLat longitude:DavisPDLong];
    NSArray *DavisPD = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:[self formatPhoneString:DavisPDPhone] caption:@"phone" URL:[NSString stringWithFormat:@"tel:%@", DavisPDPhone]],
                      [TTTableCaptionItem itemWithText:DavisPDAddr caption:@"address" URL:DavisPDurl],
                      nil
                      ];
	
	// City of Davis Fire Dept
	NSString *DavisFDurl = [self openGoogleMapsWithDestinationLatitude:DavisFireLat longitude:DavisFireLong];
    NSArray *DavisFD = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:[self formatPhoneString:DavisPDPhone] caption:@"phone" URL:[NSString stringWithFormat:@"tel:%@", DavisFirePhone]],
                      [TTTableCaptionItem itemWithText:DavisFireAddr caption:@"address" URL:DavisFDurl],
                      nil
                      ];
	
    
    // Description
    [items addObject:UCDPD];
    [items addObject:UCDFD];
    [items addObject:SutterDHS];
	[items addObject:DavisPD];
	[items addObject:DavisFD];
    self.dataSource = [TTSectionedDataSource 
                        dataSourceWithItems:items sections:sections];
}

-(void)viewDidLoad {
	self.title = @"Emergency Information";
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

-(NSString *)openGoogleMapsWithDestinationLatitude:(NSString *)latitude longitude:(NSString *)longitude{
    NSString *formatString = @"http://maps.google.com/maps?saddr=Current+Location&daddr=%@,%@"; 
    
	NSString *url = [NSString stringWithFormat:formatString, latitude, longitude];
    
    return url;
}


-(id<UITableViewDelegate>)createDelegate {
    return [[[TTTableViewVarHeightDelegate alloc] initWithController:self] autorelease];
    //	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end