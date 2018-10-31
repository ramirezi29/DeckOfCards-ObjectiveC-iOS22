//
//  RAMPokemonController.m
//  DeckOfCards-ObjectiveC-iOS22
//
//  Created by Ivan Ramirez on 10/30/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

#import "RAMCardController.h"
#import "RAMCard.h"

static NSString * const baseURLAsString = @"https://deckofcardsapi.com/api/deck/new/draw/";
//GOAL: https://deckofcardsapi.com/api/deck/new/draw/?count=1";

@implementation RAMCardController

+ (instancetype)sharedController
{
    static RAMCardController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [RAMCardController new];
    });
    return shared;
}

+ (void)fetchDrawNewCard:(void (^)(NSArray<RAMCard *> * , NSError * ))completion
{
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLAsString];
    
    // NSURLComponents
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    // var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
    
    NSURLQueryItem *querySearchItem = [NSURLQueryItem queryItemWithName:@"count" value:@"1"];
    
    components.queryItems = @[querySearchItem];
    // components.queryItems = [querySearchItem]
    
    NSURL *builtUrl = [components URL];
    // guard let url = components?.url else { return }
    
    NSLog(@"%@", [builtUrl absoluteString]);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:builtUrl completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  error) {
        if (error) {
            NSLog(@"There is an error getting the data from the endpoint %@", [error localizedDescription]);
            completion(nil, error);
            return;
        }
        if (!data)
        {
            NSLog(@"Error: No data returned from data task");
            completion(nil, error);
            return;
        }
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@", jsonDictionary);
        
        if(!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSONDictionary is not a dictionary class");
            completion(nil, error);
            return;
        }
        
        NSArray *cardDataArray = jsonDictionary[@"cards"];
        
        NSDictionary *cardDictionary = [cardDataArray objectAtIndex:0];
        
        // NOTE: - PlaceHolder
        NSMutableArray *cardsArray = [NSMutableArray array];
        RAMCard *card = [[RAMCard alloc] initWithDictionary:cardDictionary];
        [cardsArray addObject:card];
        completion(cardsArray, nil);
        // MARK: - For loop
        //        for (NSDictionary *dataDictionary in cardDictionary) {
        //            RAMCard *card = [[RAMCard alloc] initWithDictionary:dataDictionary];
        //            [cardsArray addObject:card];
        //        }
        //        completion(cardsArray, nil);
    }]resume];
}

+(void)fetchCardImage:(RAMCard *)card completion:(void (^)(UIImage * , NSError * ))completion
{
    NSURL *url= [NSURL URLWithString:card.image];
    
    //TEST: print
    NSLog(@"%@", [url absoluteString]);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            
            NSLog(@"Error in %s, %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            completion(nil, error);
            return;
        }
        if (!data){
            NSLog(@"No Data Avaliable");
            completion(nil, error);
            return;
        }
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage, nil);
    }] resume];
}

@end

