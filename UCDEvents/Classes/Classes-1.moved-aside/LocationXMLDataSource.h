//
//  LocationXMLDataSource.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
#import "LocationItem.h"
#import "LocationXMLDataModel.h"

@interface LocationXMLDataSource : TTSectionedDataSource {
	LocationXMLDataModel *dataModel;
}

@end
