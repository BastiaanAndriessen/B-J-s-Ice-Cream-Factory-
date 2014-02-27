//
//  Ingredient.h
//  B&J
//
//  Created by Bastiaan Andriessen on 23/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject

@property(nonatomic) BOOL isIngredientMixed;

//normal ingredient properties
@property(strong, nonatomic) NSString *ingredientId;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *kind;
@property(strong, nonatomic) NSString *colorCode;
@property(strong, nonatomic) NSString *url;

//additional mixed ingredient properties
@property(strong, nonatomic) NSString *ingredientIds;

@property(strong, nonatomic) NSString *nameComponent1;
@property(strong, nonatomic) NSString *kindComponent1;
@property(strong, nonatomic) NSString *colorCodeComponent1;
@property(strong, nonatomic) NSString *urlComponent1;

@property(strong, nonatomic) NSString *nameComponent2;
@property(strong, nonatomic) NSString *kindComponent2;
@property(strong, nonatomic) NSString *colorCodeComponent2;
@property(strong, nonatomic) NSString *urlComponent2;

- (id)initWithName:(NSString *)name ingredientKind:(NSString *)kind colorCode:(NSString *)colorCode url:(NSString *)url andIngredientId:(NSString*)ingredientId;
- (id)initWithName:(NSString *)name ingredientKind:(NSString *)kind colorCode:(NSString *)colorCode ingredientIds:(NSString*)ingredientIds nameComponent1:(NSString*)nameComponent1 colorCodeComponent1:(NSString*)colorCodeComponent1 urlComponent1:(NSString*)urlComponent1
    nameComponent2:(NSString*)nameComponent2 colorCodeComponent2:(NSString*)colorCodeComponent2 urlComponent2:(NSString*)urlComponent2 andIngredientId:(NSString*)ingredientId;

@end
