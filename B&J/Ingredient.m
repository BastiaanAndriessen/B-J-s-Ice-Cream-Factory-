//
//  Ingredient.m
//  B&J
//
//  Created by Bastiaan Andriessen on 23/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient

@synthesize isIngredientMixed = _isIngredientMixed;

//normal ingredient properties
@synthesize ingredientId = _ingredientId;
@synthesize name = _name;
@synthesize kind = _kind;
@synthesize colorCode = _colorCode;
@synthesize url = _url;

//additional mixed ingredient properties
@synthesize ingredientIds = _ingredientIds;

@synthesize nameComponent1 = _nameComponent1;
@synthesize colorCodeComponent1 = _colorCodeComponent1;
@synthesize urlComponent1 = _urlComponent1;

@synthesize nameComponent2 = _nameComponent2;
@synthesize colorCodeComponent2 = _colorCodeComponent2;
@synthesize urlComponent2 = _urlComponent2;

- (id)initWithName:(NSString *)name ingredientKind:(NSString *)kind colorCode:(NSString *)colorCode url:(NSString *)url andIngredientId:(NSString*)ingredientId{
    self = [super init];
    if (self) {
        self.isIngredientMixed = NO;
        
        self.name = name;
        self.kind = kind;
        self.colorCode = colorCode;
        self.url = url;
        self.ingredientId = ingredientId;
    }
    return self;
}

- (id)initWithName:(NSString *)name ingredientKind:(NSString *)kind colorCode:(NSString *)colorCode ingredientIds:(NSString*)ingredientIds nameComponent1:(NSString*)nameComponent1 colorCodeComponent1:(NSString*)colorCodeComponent1 urlComponent1:(NSString*)urlComponent1
    nameComponent2:(NSString*)nameComponent2 colorCodeComponent2:(NSString*)colorCodeComponent2 urlComponent2:(NSString*)urlComponent2 andIngredientId:(NSString*)ingredientId{
    self = [super init];
    if (self) {
        self.isIngredientMixed = YES;
        
        self.name = name;
        self.kind = kind;
        self.colorCode = colorCode;
        self.ingredientIds = ingredientIds;
        
        self.nameComponent1 = nameComponent1;
        self.colorCodeComponent1 = colorCodeComponent1;
        self.urlComponent1 = urlComponent1;
        
        self.nameComponent2 = nameComponent2;
        self.colorCodeComponent2 = colorCodeComponent2;
        self.urlComponent2 = urlComponent2;
        
        self.ingredientId = ingredientId;
    }
    return self;
}


@end
