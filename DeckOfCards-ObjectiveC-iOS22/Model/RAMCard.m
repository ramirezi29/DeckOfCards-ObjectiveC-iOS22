//
//  RAMCard.m
//  DeckOfCards-ObjectiveC-iOS22
//
//  Created by Ivan Ramirez on 10/30/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

#import "RAMCard.h"

@implementation RAMCard

- (instancetype)initWithSuit:(NSString *)suit image:(NSString *)image
{
    self = [super init];
    if (self) {
        _suit = suit;
        _image = image;
    }
    return self;
}

@end

@implementation RAMCard (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
{
    NSString *suit = [dictionary valueForKey:@"name"];
    
    NSString *image = [dictionary valueForKey:@"image"];
    
    return [self initWithSuit:suit image:image];
}

@end
