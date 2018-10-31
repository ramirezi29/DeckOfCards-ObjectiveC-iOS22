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
//https://deckofcardsapi.com/api/deck/new/draw/?count=1";

@implementation RAMCardController

+ (void)fetchDrawNewCard:(void (^)(NSArray<RAMCard *> * _Nonnull, NSError * _Nonnull))completion
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
    
    NSLog(@"%@", [url absoluteString]);
    
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

+(void)fetchCardImage:(RAMCard *)card completion:(void (^)(UIImage * _Nonnull, NSError * _Nonnull))completion
{
    NSURL *url= [NSURL URLWithString:card.image];
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
//
//+ (void)fetchDrawNewCard:(id)completion :(void (^)(NSArray<RAMCard *> * _Nonnull, NSError * _Nonnull))completion
//{
//    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLAsString];
//
//    // NSURLComponents
//    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
//    // var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
//
//    NSURLQueryItem *querySearchItem = [NSURLQueryItem queryItemWithName:@"count" value:@"1"];
//
//    components.queryItems = @[querySearchItem];
//    // components.queryItems = [querySearchItem]
//
//    NSURL *url = [components URL];
//    // guard let url = components?.url else { return }
//
//    NSLog(@"%@", [url absoluteString]);
//
//    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"There is an error getting the data from the endpoint %@", [error localizedDescription]);
//            completion(nil, error);
//            return;
//        }
//        if (data == nil)
//        {
//            completion(nil, error);
//            return;
//        }
//    }]resume];
//}
//
//+(void)fetchCardImage:(RAMCard *)card completion:(void (^)(UIImage * _Nonnull, NSError * _Nonnull))completion
//{
//    NSURL *url= [NSURL URLWithString:card.image];
//    NSLog(@"%@", [url absoluteString]);
//
//    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error){
//
//            NSLog(@"Error in %s, %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
//            completion(nil, error);
//            return;
//        }
//        if (!data){
//            NSLog(@"No Data Avaliable");
//            completion(nil, error);
//            return;
//        }
//        UIImage *cardImage = [UIImage imageWithData:data];
//        completion(cardImage, nil);
//    }] resume];
//}



    @end
    
