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

- (void) createModel {
                        
    NSMutableArray* items = [NSMutableArray array];
    NSMutableArray* sections = [NSMutableArray array];
    
    [sections addObject:@"UC Davis Police Department"];
    [sections addObject:@"UC Davis Fire Department"];
    [sections addObject:@"Sutter Davis Hospital"];
    
    //Basic
    NSArray *UCDPD = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:[self formatPhoneString:UCDPoliceDepartmentPhone] caption:@"phone"],
                      [TTTableCaptionItem itemWithText:UCDPoliceDepartmentAddr caption:@"address"],
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

-(id)init {
    if (self = [super init]) {
        NSLog(@"view loaded!!!!!!!");
        self.tableViewStyle = UITableViewStyleGrouped;
    }
    NSLog(@"Why do you hate me!?!??!");
    return self;
}

-(void)viewDidLoad {
	self.title = @"Info";
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

@end
