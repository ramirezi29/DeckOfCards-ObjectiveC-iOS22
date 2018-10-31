//
//  RAMCardViewController.m
//  DeckOfCards-ObjectiveC-iOS22
//
//  Created by Ivan Ramirez on 10/30/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

#import "RAMCardViewController.h"
#import "RAMCardController.h"
#import "RAMCard.h"

@interface RAMCardViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;
@property (weak, nonatomic) IBOutlet UIButton *drawButton;

@end

@implementation RAMCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (IBAction)drawButtonTapped:(UIButton *)sender {
    [RAMCardController fetchDrawNewCard:^(NSArray<RAMCard *> * _Nonnull cards, NSError * _Nonnull error) {
        [RAMCardController fetchCardImage:cards completion:^(UIImage * _Nonnull cardImage, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cardImageView.image = cardImage;
            });
        }];
    }];}



@end
