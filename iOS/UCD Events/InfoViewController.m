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
    
    //Basic
//    NSString *url = [self openGoogleMapsWithDestinationLatitude:UDPDlat longitude:UCDPDlong];
    NSArray *UCDPD = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:[self formatPhoneString:UCDPoliceDepartmentPhone] caption:@"phone" URL:[NSString stringWithFormat:@"tel:%@", UCDPoliceDepartmentPhone]],
//                      [TTTableCaptionItem itemWithText:UCDPoliceDepartmentAddr caption:@"address" URL:url],
                      nil
                      ];
    
    
    // Contact
    NSArray *UCDFD = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:[self formatPhoneString:UCDFireDepartmentPhone] caption:@"phone"],
                      [TTTableCaptionItem itemWithText:UCDFireDepartmentAddr caption:@"address"],
                      nil
                      ];
    NSArray *SutterDHS = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:[self formatPhoneString:SutterDHSPhone] caption:@"phone"],
                      [TTTableCaptionItem itemWithText:SutterDHSAddr caption:@"address"],
                      nil
                      ];
    
    // Description
    [items addObject:UCDPD];
    [items addObject:UCDFD];
    [items addObject:SutterDHS];
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
