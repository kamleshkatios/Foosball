//
//  RankingCell.m
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "RankingCell.h"

@interface RankingCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalMatchPlayed;
@property (weak, nonatomic) IBOutlet UILabel *totalWon;
@property (weak, nonatomic) IBOutlet UILabel *rankingLbl;
@end

@implementation RankingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setPlayer:(Player *)player {
    self.nameLbl.text = [player.playerName stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    self.totalMatchPlayed.text = [NSString stringWithFormat:@"Total Match Played: %ld",player.totalMatch.integerValue];
    self.totalWon.text = [NSString stringWithFormat:@"Total Won : %ld",player.matchWon.integerValue];
    self.rankingLbl.text = [player.rank stringValue];
}
@end
