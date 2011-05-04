//
//  OffersViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OffersViewController.h"

@interface OffersStyledTextLabel : TTStyledTextLabel
@end
    
@implementation OffersStyledTextLabel 
    -(id)initWithFrame:(CGRect)frame {
        if(self = [super initWithFrame:frame]) {
            self.font = TTSTYLEVAR(offerFrameFont);
            self.textColor = TTSTYLEVAR(offerFrameColor);
            self.backgroundColor = TTSTYLEVAR(offerFrameBackgroundColor);
        }
        
        return self;
    }
@end


@implementation OffersViewController

-(void)dealloc {
    _scrollView.delegate = nil;
    _scrollView.dataSource = nil;
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_pageControl);
    TT_RELEASE_SAFELY(_offersDataModel);
    [super dealloc];
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nil bundle:nil]) {    
        [self createModel];
        [self reload];
    }
    
    return self;
}

-(id<TTModel>)model {
    return _offersDataModel;
}

-(BOOL)shouldLoad {
    return YES;
}

-(void)viewDidLoad {
    self.title = @"Offers";
}

-(void)loadView {
    CGRect appFrame = [UIScreen mainScreen].applicationFrame;
    CGRect frame = CGRectMake(0, 0, appFrame.size.width, appFrame.size.height - 44);
    
    self.view = [[[UIView alloc] initWithFrame:frame] autorelease];
    
    _scrollView = [[TTScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.bounds.size.height - 20)];
    
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _scrollView.dataSource = self;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = TTSTYLEVAR(backgroundColor);
    _scrollView.zoomEnabled = NO;
    [self.view addSubview:_scrollView];
    
    _pageControl = [[TTPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.bottom, self.view.width, 20)];
    _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _pageControl.currentPage = 0;
    _pageControl.backgroundColor = TTSTYLEVAR(backgroundColor);
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    

}

-(void)createModel {
    //    From http://stackoverflow.com/questions/3790957/reachability-guide-for-ios-4
    Reachability *reachable = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachable currentReachabilityStatus];
    if (status == NotReachable) {
        TTErrorView* errorView = [[[TTErrorView alloc] initWithTitle:@"Connection Error."
                                                            subtitle:@"Please try again."
                                                               image:nil] autorelease];
        errorView.backgroundColor = _scrollView.backgroundColor;
        errorView.frame = CGRectMake(0, _scrollView.height / 2 , self.view.width, errorView.height);
        [_scrollView addSubview:errorView];
    } else {
        TTActivityLabel* label = [[[TTActivityLabel alloc] initWithStyle:TTActivityLabelStyleWhite] autorelease];
        label.text = @"Loading...";
        [label sizeToFit];
        label.frame = CGRectMake(0, _scrollView.height / 2 , self.view.width, label.height);
        [_scrollView addSubview:label];
        _offersDataModel = [[OffersJSONDataModel alloc] init]; 
        self.model = _offersDataModel;
    }
}



-(void)modelDidFinishLoad:(id<TTModel>)model {
    NSLog(@"Model back!");
    _pageControl.numberOfPages = [_offersDataModel.offers count];
    [_scrollView removeAllSubviews];
//    if (_offersDataModel.size < 1) {
//        TTLabel *label = [[TTLabel alloc] initWithText:@"Error!"];
//        label.backgroundColor = [UIColor whiteColor];
//        [label sizeToFit];
//        label.frame = CGRectMake(0, _scrollView.height / 2 , self.view.width, label.height);
//        [_scrollView addSubview:label];
//    }
    [_scrollView reloadData];
}

- (NSInteger)numberOfPagesInScrollView:(TTScrollView*)scrollView {
    return [_offersDataModel.offers count];
}

- (UIView*)scrollView:(TTScrollView*)scrollView pageAtIndex:(NSInteger)pageIndex {
    TTView* pageView = nil;
    if (!pageView) {
        pageView = [[[TTView alloc] init] autorelease];
        pageView.backgroundColor = [UIColor clearColor];
        pageView.userInteractionEnabled = NO;
    }

    NSString* kText = @"\
    <span class=\"floated\"><img src=\"http://farm6.static.flickr.com/5222/5644882930_5261f80b13_m.jpg\" width=\"160\" height=\"120\"/></span>This \
    is a test of floats. This is still a test of floats.  This text will wrap itself around \
    the image that is being floated on the left.  I repeat, this is a test of floats.";
    
    NSString *mytext = @"Hello!";
    
    OffersStyledTextLabel* label = [[[OffersStyledTextLabel alloc] initWithFrame:CGRectMake(20, 20, 265, 300)] autorelease];
    OfferItem *currentOffer = [_offersDataModel.offers objectAtIndex:pageIndex];

    label.html = currentOffer.description;
    
    [pageView addSubview:label];
    
    TTButton *emergencyInfoButton = [TTButton buttonWithStyle:@"embossedButton:" title:@"Location Information"];
    NSString *targetURL = [[NSString alloc] initWithFormat:@"ucde://types/1/locations/%@", currentOffer.locationId];
    [emergencyInfoButton addTarget:targetURL action:@selector(openURLFromButton:) forControlEvents:UIControlEventTouchUpInside];
    [emergencyInfoButton setFrame:CGRectMake(20, 330, 265, 50)];
    
    [pageView addSubview:emergencyInfoButton];

    pageView.style = TTSTYLEVAR(offerCard);
    
    return pageView;
}

- (CGSize)scrollView:(TTScrollView*)scrollView sizeOfPageAtIndex:(NSInteger)pageIndex {
    return CGSizeMake(320, 416);
}

#pragma mark -
#pragma mark TTScrollViewDelegate

- (void)scrollView:(TTScrollView*)scrollView didMoveToPageAtIndex:(NSInteger)pageIndex {
    _pageControl.currentPage = pageIndex;
}

#pragma mark -
#pragma mark UIViewController overrides
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark -
#pragma mark TTPageControl

- (IBAction)changePage:(id)sender {
    int page = _pageControl.currentPage;
    [_scrollView setCenterPageIndex:page];
}

@end
