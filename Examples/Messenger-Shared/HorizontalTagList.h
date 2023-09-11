//
//  HorizontalTagList.h
//  Messenger
//
//  Created by Mahesh on 29/08/23.
//  Copyright © 2023 Slack Technologies, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLKQuickResponseProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface HorizontalTagList : UIView<SLKQuickResponseProtocol>

- (void)setHorizontalTagList;
- (void)refreshTagsWithArray:(NSArray *)tags;
- (void)dismissQuickResponseView;
@end

NS_ASSUME_NONNULL_END
