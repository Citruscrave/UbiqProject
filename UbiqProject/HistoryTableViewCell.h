//
//  HistoryTableViewCell.h
//  UbiqProject
//
//  Created by chris ly on 12/8/15.
//  Copyright © 2015 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *firstPersonImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondPersonImage;
@property (weak, nonatomic) IBOutlet UIImageView *mapImage;
@property (weak, nonatomic) IBOutlet UILabel *firstPersonName;
@property (weak, nonatomic) IBOutlet UILabel *secondPersonName;

@end
