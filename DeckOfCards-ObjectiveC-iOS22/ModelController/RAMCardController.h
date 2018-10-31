//
//  RAMPokemonController.h
//  DeckOfCards-ObjectiveC-iOS22
//
//  Created by Ivan Ramirez on 10/30/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class RAMCard;


@interface RAMCardController : NSObject
NS_ASSUME_NONNULL_BEGIN

+(instancetype)sharedController;

//+(void)fetchDrawNewCard: (NSInteger *) numberOfCards
//        completion: (void(^)(NSArray<RAMCard *>*cards, NSError *error))completion;
//
//+(void)fetchCardImage: (RAMCard *)card
//           completion: (void(^)(UIImage *cardImage, NSError *error))completion;
//

+(void)fetchDrawNewCard:(void(^)(NSArray<RAMCard *>*cards, NSError *error))completion;

+(void)fetchCardImage: (RAMCard *)card
           completion: (void(^)(UIImage *cardImage, NSError *error))completion;


NS_ASSUME_NONNULL_END
@end
