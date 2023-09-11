//
//  HorizontalTagList.m
//  Messenger
//
//  Created by Mahesh on 29/08/23.
//  Copyright © 2023 Slack Technologies, Inc. All rights reserved.
//

#import "HorizontalTagList.h"
#import "TTGTextTagCollectionView.h"


@interface HorizontalTagList() <TTGTextTagCollectionViewDelegate>
//@property (strong, nonatomic) IBOutlet TTGTextTagCollectionView *oneLineTagView;
@property (nonatomic, strong) TTGTextTagCollectionView *tagView;
@end

@implementation HorizontalTagList
@synthesize visible = _visible;

//- (void)setHorizontalTagList {
////    _oneLineTagView = [TTGTextTagCollectionView new];
//    _oneLineTagView.delegate = self;
//    _oneLineTagView.scrollDirection = TTGTagCollectionScrollDirectionHorizontal;
//    _oneLineTagView.alignment = TTGTagCollectionAlignmentFillByExpandingWidth;
//    _oneLineTagView.numberOfLines = 1;
//
//    [_oneLineTagView addTags:[self generateTags]];
//    [_oneLineTagView reload];
//    self.visible = YES;
//}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)configureView {
    
    _tagView = [TTGTextTagCollectionView new];
    _tagView.alignment = TTGTagCollectionAlignmentFillByExpandingWidth;
    _tagView.scrollDirection = TTGTagCollectionScrollDirectionHorizontal;
    _tagView.horizontalSpacing = 6.0;
    _tagView.verticalSpacing = 8.0;
    _tagView.numberOfLines = 1;
    _tagView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_tagView];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[tagView]-20-|"
                                                                    options:(NSLayoutFormatOptions) 0 metrics:nil
                                                                      views:@{@"tagView": _tagView}];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_tagView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1 constant: -5];
    [self addConstraint:topConstraint];
    [self addConstraints:hConstraints];
    
    [self layoutIfNeeded];
    _tagView.delegate = self;
}
- (void)setHorizontalTagList{

    [_tagView addTags:[self generateTags]];
    [_tagView reload];
    _tagView.delegate = self;
    self.visible = YES;
}

- (NSArray<TTGTextTag *> *)generateTags {
    NSArray *tags = @[@"AutoLayout", @"dynamically", @"calculates", @"the", @"size", @"and", @"position",
                      @"of", @"all", @"the", @"views", @"in", @"your", @"view", @"hierarchy", @"based",
                      @"on", @"constraints", @"placed", @"on", @"those", @"views"];
    
    NSMutableArray *textTags = [NSMutableArray new];
    
    TTGTextTagStringContent *content = [TTGTextTagStringContent new];
    TTGTextTagStringContent *selectedContent = [TTGTextTagStringContent new];
    TTGTextTagStyle *style = [TTGTextTagStyle new];
    TTGTextTagStyle *selectedStyle = [TTGTextTagStyle new];
    
    content.textFont = [UIFont boldSystemFontOfSize:18.0f];
    selectedContent.textFont = content.textFont;
    
    content.textColor = [UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:1.00];
    selectedContent.textColor = [UIColor whiteColor];
    
    style.backgroundColor = [UIColor colorWithRed:0.31 green:0.70 blue:0.80 alpha:1.00];
    selectedStyle.backgroundColor = [UIColor colorWithRed:0.38 green:0.36 blue:0.63 alpha:1.00];
    
    style.borderColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
    style.borderWidth = 1;

    selectedStyle.borderColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
    selectedStyle.borderWidth = 1;
    
    style.shadowColor = [UIColor grayColor];
    style.shadowOffset = CGSizeMake(0, 1);
    style.shadowOpacity = 0.5f;
    style.shadowRadius = 2;

    selectedStyle.shadowColor = [UIColor greenColor];
    selectedStyle.shadowOffset = CGSizeMake(0, 2);
    selectedStyle.shadowOpacity = 0.5f;
    selectedStyle.shadowRadius = 1;

    style.cornerRadius = 2;
    selectedStyle.cornerRadius = 4;
    
    style.extraSpace = CGSizeMake(4, 4);
    selectedStyle.extraSpace = style.extraSpace;
    
    for (NSString *string in tags) {
//        TTGTextTag *textTag = [TTGTextTag tagWithContent:[TTGTextTagStringContent contentWithText:string] style:[TTGTextTagStyle new]];
//        textTag.selectedStyle.backgroundColor = [UIColor greenColor];
//        [textTags addObject:textTag];
        TTGTextTagStringContent *stringContent = [content copy];
        stringContent.text = string;
        TTGTextTagStringContent *selectedStringContent = [selectedContent copy];
        selectedStringContent.text = string;
        TTGTextTag *tag = [TTGTextTag new];
        tag.content = stringContent;
        tag.selectedContent = selectedStringContent;
        tag.style = style;
        tag.selectedStyle = selectedStyle;
        tag.attachment = stringContent;
        [textTags addObject:tag.copy];
    }
    
    return textTags;
}

- (void)refreshTagsWithArray:(NSArray *)tags {
    NSMutableArray *textTags = [NSMutableArray new];
    
    TTGTextTagStringContent *content = [TTGTextTagStringContent new];
    TTGTextTagStringContent *selectedContent = [TTGTextTagStringContent new];
    TTGTextTagStyle *style = [TTGTextTagStyle new];
    TTGTextTagStyle *selectedStyle = [TTGTextTagStyle new];
    
    content.textFont = [UIFont boldSystemFontOfSize:18.0f];
    selectedContent.textFont = content.textFont;
    
    content.textColor = [UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:1.00];
    selectedContent.textColor = [UIColor whiteColor];
    
    style.backgroundColor = [UIColor colorWithRed:0.31 green:0.70 blue:0.80 alpha:1.00];
    selectedStyle.backgroundColor = [UIColor colorWithRed:0.38 green:0.36 blue:0.63 alpha:1.00];
    
    style.borderColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
    style.borderWidth = 1;

    selectedStyle.borderColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
    selectedStyle.borderWidth = 1;
    
    style.shadowColor = [UIColor grayColor];
    style.shadowOffset = CGSizeMake(0, 1);
    style.shadowOpacity = 0.5f;
    style.shadowRadius = 2;

    selectedStyle.shadowColor = [UIColor greenColor];
    selectedStyle.shadowOffset = CGSizeMake(0, 2);
    selectedStyle.shadowOpacity = 0.5f;
    selectedStyle.shadowRadius = 1;

    style.cornerRadius = 2;
    selectedStyle.cornerRadius = 4;
    
    style.extraSpace = CGSizeMake(4, 4);
    selectedStyle.extraSpace = style.extraSpace;
    
    for (NSString *string in tags) {
//        TTGTextTag *textTag = [TTGTextTag tagWithContent:[TTGTextTagStringContent contentWithText:string] style:[TTGTextTagStyle new]];
//        textTag.selectedStyle.backgroundColor = [UIColor greenColor];
//        [textTags addObject:textTag];
        TTGTextTagStringContent *stringContent = [content copy];
        stringContent.text = string;
        TTGTextTagStringContent *selectedStringContent = [selectedContent copy];
        selectedStringContent.text = string;
        TTGTextTag *tag = [TTGTextTag new];
        tag.content = stringContent;
        tag.selectedContent = selectedStringContent;
        tag.style = style;
        tag.selectedStyle = selectedStyle;
        tag.attachment = stringContent;
        [textTags addObject:tag.copy];
    }
    [_tagView removeAllTags];
    [_tagView addTags:textTags];
    [_tagView reload];
    _tagView.delegate = self;
    self.visible = YES;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - TTGTextTagCollectionViewDelegate

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(TTGTextTag *)tag atIndex:(NSUInteger)index {
    NSString *str = [NSString stringWithFormat:@"Tap tag: %@, at: %ld, selected: %d", tag.content.getContentAttributedString.string, (long) index, tag.selected];
    NSLog(@"STR :: %@",str);
    [self dismissIndicator];
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
#pragma mark - SLKTypingIndicatorProtocol

- (void)dismissIndicator
{
    if (self.isVisible) {
        self.visible = NO;
    }
}

- (void)presentIndicatorWithName:(nonnull NSString *)name image:(nonnull UIImage *)image {
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, [self height]);
}

- (CGFloat)height
{
    CGFloat height = 30.0;
    height += _tagView.frame.size.height;
    
    return height;
}

#pragma mark - Lifeterm

- (void)dealloc
{
    _tagView = nil;
}
- (void)dismissQuickResponseView {
    if(self.isVisible){
        self.visible = NO;
    }
}

@end
