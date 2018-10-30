//
//  RAMCard.h
//  DeckOfCards-ObjectiveC-iOS22
//
//  Created by Ivan Ramirez on 10/30/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RAMCard : NSObject

@property (nonatomic, copy, readonly) NSString *suit;
@property (nonatomic, copy, readonly) NSString *image;

-(instancetype)initWithSuit:(NSString *)suit image:(NSString *)image;


@end

@interface RAMCard (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
