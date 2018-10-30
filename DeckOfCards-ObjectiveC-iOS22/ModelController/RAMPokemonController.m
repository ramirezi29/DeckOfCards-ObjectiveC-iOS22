//
//  RAMPokemonController.m
//  DeckOfCards-ObjectiveC-iOS22
//
//  Created by Ivan Ramirez on 10/30/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

#import "RAMPokemonController.h"
#import "RAMCard.h"

static NSString * const baseURLAsString = @"https://deckofcardsapi.com/api/deck/new/draw/";
//https://deckofcardsapi.com/api/deck/new/draw/?count=1";

@implementation RAMPokemonController

//+ (RAMCard) shared {
//    static RAMCard *shared = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        shared = [RAMCard new];
//    });
//    return shared;
//}



+ (void)drawNewCard:(id)completion :(void (^)(NSArray<RAMCard *> * _Nonnull, NSError * _Nonnull))completion
{
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLAsString];
    
    // NSURLComponents
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    // var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
    
    NSURLQueryItem *querySearchItem = [NSURLQueryItem queryItemWithName:@"count" value:@"1"];
    
    components.queryItems = @[querySearchItem];
    // components.queryItems = [querySearchItem]
    
    NSURL *url = [components URL];
    // guard let url = components?.url else { return }
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There is an error getting the data from the endpoint %@", [error localizedDescription]);
            completion(nil, error);
            return;
        }
        if (data == nil)
        {
            completion(nil, error);
            return;
        }
    }]resume];
}
    
    @end
    
