//
//  NTESSettingPortraitInfoCell.m
//  NIM
//
//  Created by WZTENG on 2017/6/16.
//  Copyright © 2017年 WZTENG. All rights reserved.
//

#import "NTESSettingPortraitInfoCell.h"
#import "NIMCommonTableData.h"
#import "UIView+NTES.h"
#import "NTESSessionUtil.h"
#import "NIMAvatarImageView.h"

@interface NTESSettingPortraitInfoCell()

@property (nonatomic,strong) NIMAvatarImageView *avatar;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *accountLabel;

@property (nonatomic,strong) UIImageView *qrCodeIV;

@end

@implementation NTESSettingPortraitInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat avatarWidth = 60.f;
        _avatar = [[NIMAvatarImageView alloc] initWithFrame:CGRectMake(0, 0, avatarWidth, avatarWidth)];
        [self addSubview:_avatar];
        _nameLabel      = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont systemFontOfSize:18.f];
        [self addSubview:_nameLabel];
        _accountLabel   = [[UILabel alloc] initWithFrame:CGRectZero];
        _accountLabel.font = [UIFont systemFontOfSize:14.f];
        _accountLabel.textColor = [UIColor grayColor];
        [self addSubview:_accountLabel];
        _qrCodeIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
        _qrCodeIV.image = [UIImage imageNamed:@"profile_qrcode"];
        _qrCodeIV.userInteractionEnabled = YES;//响应触摸事件，否则不会响应
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchQrCode)];
        [_qrCodeIV addGestureRecognizer:singleTap];

        [self addSubview:_qrCodeIV];
    }
    return self;
}

- (void)refreshData:(NIMCommonTableRow *)rowData tableView:(UITableView *)tableView{
    self.textLabel.text       = rowData.title;
    self.detailTextLabel.text = rowData.detailTitle;
    NSString *uid = rowData.extraInfo;
    if ([uid isKindOfClass:[NSString class]]) {
        NIMKitInfo *info = [[NIMKit sharedKit] infoByUser:uid option:nil];
        self.nameLabel.text   = info.showName ;
        [self.nameLabel sizeToFit];
        self.accountLabel.text = [NSString stringWithFormat:@"帐号：%@",uid];
        [self.accountLabel sizeToFit];
        [self.avatar nim_setImageWithURL:[NSURL URLWithString:info.avatarUrlString] placeholderImage:info.avatarImage options:SDWebImageRetryFailed];
    }
}


#define AvatarLeft 15
#define TitleAndAvatarSpacing 12
#define TitleTop 22
#define AccountBottom 22

- (void)layoutSubviews{
    [super layoutSubviews];
    self.avatar.left    = AvatarLeft;
    self.avatar.centerY = self.height * .5f;
    self.nameLabel.left = self.avatar.right + TitleAndAvatarSpacing;
    self.nameLabel.top  = TitleTop;
    self.accountLabel.left    = self.nameLabel.left;
    self.accountLabel.bottom  = self.height - AccountBottom;
    self.qrCodeIV.left = [UIScreen mainScreen].bounds.size.width - 30 - 40;
    self.qrCodeIV.centerY = self.height * .5f;
}

- (void)onTouchQrCode{
    NSLog(@"点击二维码");
}


@end
