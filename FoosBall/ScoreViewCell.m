//
//  ScoreViewCell.m
//  FoosBall
//
//  Created by kamlesh on 5/25/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "ScoreViewCell.h"

@interface ScoreViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *matchIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *player1ScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *player2ScoreLbl;
@end

@implementation ScoreViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setMatch:(Match *)match {
    self.matchIdLbl.text = [match.matchId stringValue];
    NSDateFormatter *dateForematter = [[NSDateFormatter alloc] init];
    [dateForematter setDateFormat:@"yyyy'-'MM'-'dd HH':'mm"];
    //'\n'HH':'mm
    self.matchDateLbl.text = [dateForematter stringFromDate:match.matchDate];
    self.player1ScoreLbl.text = [NSString stringWithFormat:@"%@ %@",match.player1Id, match.player1Points.stringValue];
    self.player2ScoreLbl.text = [NSString stringWithFormat:@"%@ %@",match.player2Id, match.player2Points.stringValue];
}
@end
