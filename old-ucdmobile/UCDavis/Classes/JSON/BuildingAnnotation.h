//
//  BuildingAnnotation.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/11/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMAnnotation.h"

@class CMBuilding;

@interface BuildingAnnotation : CMAnnotation {
	CMBuilding *building;
}

@property (nonatomic, retain) CMBuilding *building;

- (id)initWithBuilding:(CMBuilding *)aBuilding;

@end
