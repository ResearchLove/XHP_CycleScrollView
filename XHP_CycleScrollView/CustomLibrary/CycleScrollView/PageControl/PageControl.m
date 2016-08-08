//
//  PageControl.m
//  XHP_CycleScrollView
//
//  Created by xiaohaiping on 16/8/8.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import "PageControl.h"
#import "AbstractDotView.h"
#import "AnimatedDotView.h"
#import "DotView.h"

/**
 *  Default number of pages for initialization
 */
static NSInteger const kDefaultNumberOfPages = 0;

/**
 *  Default current page for initialization
 */
static NSInteger const kDefaultCurrentPage = 0;

/**
 *  Default setting for hide for single page feature. For initialization
 */
static BOOL const kDefaultHideForSinglePage = NO;

/**
 *  Default setting for shouldResizeFromCenter. For initialiation
 */
static BOOL const kDefaultShouldResizeFromCenter = YES;

/**
 *  Default spacing between dots
 */
static NSInteger const kDefaultSpacingBetweenDots = 8;

/**
 *  Default dot size
 */
static CGSize const kDefaultDotSize = {8, 8};

@implementation PageControl

- (id)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}


/**
 *  Default setup when initiating control
 */
- (void)initialization
{
    self.dotViewClass           = [AnimatedDotView class];
    self.spacingBetweenDots     = kDefaultSpacingBetweenDots;
    self.numberOfPages          = kDefaultNumberOfPages;
    self.currentPage            = kDefaultCurrentPage;
    self.hidesForSinglePage     = kDefaultHideForSinglePage;
    self.shouldResizeFromCenter = kDefaultShouldResizeFromCenter;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != self) {
        NSInteger index = [self.dotsAry indexOfObject:touch.view];
        if ([self.delegate respondsToSelector:@selector(PageControl:didSelectPageAtIndex:)]) {
            [self.delegate PageControl:self didSelectPageAtIndex:index];
        }
    }
}

- (void)sizeToFit
{
    [self updateFrame:YES];
}


- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    return CGSizeMake((self.dotSize.width + self.spacingBetweenDots) * pageCount - self.spacingBetweenDots , self.dotSize.height);
}


- (void)updateDots
{
    if (self.numberOfPages == 0) {
        return;
    }
    
    for (NSInteger i = 0; i < self.numberOfPages; i++) {
        
        UIView *dot;
        if (i < self.dotsAry.count) {
            dot = [self.dotsAry objectAtIndex:i];
        } else {
            dot = [self generateDotView];
        }
        
        [self updateDotFrame:dot atIndex:i];
    }
    
    [self changeActivity:YES atIndex:self.currentPage];
    
    [self hideForSinglePage];
}


/**
 *  Update frame control to fit current number of pages. It will apply required size if authorize and required.
 *
 *  @param overrideExistingFrame BOOL to allow frame to be overriden. Meaning the required size will be apply no mattter what.
 */
- (void)updateFrame:(BOOL)overrideExistingFrame
{
    CGPoint center = self.center;
    CGSize requiredSize = [self sizeForNumberOfPages:self.numberOfPages];
    
    // We apply requiredSize only if authorize to and necessary
    if (overrideExistingFrame || ((CGRectGetWidth(self.frame) < requiredSize.width || CGRectGetHeight(self.frame) < requiredSize.height) && !overrideExistingFrame)) {
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), requiredSize.width, requiredSize.height);
        if (self.shouldResizeFromCenter) {
            self.center = center;
        }
    }
    
    [self resetDotViews];
}


/**
 *  Update the frame of a specific dot at a specific index
 *
 *  @param dot   Dot view
 *  @param index Page index of dot
 */
- (void)updateDotFrame:(UIView *)dot atIndex:(NSInteger)index
{
    // Dots are always centered within view
    CGFloat x = (self.dotSize.width + self.spacingBetweenDots) * index + ( (CGRectGetWidth(self.frame) - [self sizeForNumberOfPages:self.numberOfPages].width) / 2);
    CGFloat y = (CGRectGetHeight(self.frame) - self.dotSize.height) / 2;
    
    dot.frame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);
}

/**
 *  Generate a dot view and add it to the collection
 *
 *  @return The UIView object representing a dot
 */
- (UIView *)generateDotView
{
    UIView *dotView;
    
    if (self.dotViewClass) {
        dotView = [[self.dotViewClass alloc] initWithFrame:CGRectMake(0, 0, self.dotSize.width, self.dotSize.height)];
        if ([dotView isKindOfClass:[AnimatedDotView class]] && self.dotColor) {
            ((AnimatedDotView *)dotView).dotColor = self.dotColor;
        }
    } else {
        dotView = [[UIImageView alloc] initWithImage:self.dotImage];
        dotView.frame = CGRectMake(0, 0, self.dotSize.width, self.dotSize.height);
    }
    if (dotView) {
        [self addSubview:dotView];
        [self.dotsAry addObject:dotView];
    }
    dotView.userInteractionEnabled = YES;
    return dotView;
}


/**
 *  Change activity state of a dot view. Current/not currrent.
 *
 *  @param active Active state to apply
 *  @param index  Index of dot for state update
 */
- (void)changeActivity:(BOOL)active atIndex:(NSInteger)index
{
    if (self.dotViewClass) {
        AbstractDotView *abstractDotView = (AbstractDotView *)[self.dotsAry objectAtIndex:index];
        if ([abstractDotView respondsToSelector:@selector(changeActivityState:)]) {
            [abstractDotView changeActivityState:active];
        } else {
            NSLog(@"Custom view : %@ must implement an 'changeActivityState' method or you can subclass %@ to help you.", self.dotViewClass, [AbstractDotView class]);
        }
    } else if (self.dotImage && self.currentDotImage) {
        UIImageView *dotView = (UIImageView *)[self.dotsAry objectAtIndex:index];
        dotView.image = (active) ? self.currentDotImage : self.dotImage;
    }
}


- (void)resetDotViews
{
    for (UIView *dotView in self.dotsAry) {
        [dotView removeFromSuperview];
    }
    
    [self.dotsAry removeAllObjects];
    [self updateDots];
}


- (void)hideForSinglePage
{
    if (self.dotsAry.count == 1 && self.hidesForSinglePage) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
}

#pragma mark - Setters
- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    [self resetDotViews];
}


- (void)setSpacingBetweenDots:(NSInteger)spacingBetweenDots
{
    _spacingBetweenDots = spacingBetweenDots;
    [self resetDotViews];
}


- (void)setCurrentPage:(NSInteger)currentPage
{
    if (self.numberOfPages == 0 || currentPage == _currentPage) {
        _currentPage = currentPage;
        return;
    }
    [self changeActivity:NO atIndex:_currentPage];
    _currentPage = currentPage;
    [self changeActivity:YES atIndex:_currentPage];
}


- (void)setDotImage:(UIImage *)dotImage
{
    _dotImage = dotImage;
    [self resetDotViews];
    self.dotViewClass = nil;
}


- (void)setCurrentDotImage:(UIImage *)currentDotimage
{
    _currentDotImage = currentDotimage;
    [self resetDotViews];
    self.dotViewClass = nil;
}


- (void)setDotViewClass:(Class)dotViewClass
{
    _dotViewClass = dotViewClass;
    self.dotSize = CGSizeZero;
    [self resetDotViews];
}


- (NSMutableArray *)dotsAry
{
    if (!_dotsAry) {
        _dotsAry = [[NSMutableArray alloc] init];
    }
    return _dotsAry;
}


- (CGSize)dotSize
{
    if (self.dotImage && CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = self.dotImage.size;
    } else if (self.dotViewClass && CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = kDefaultDotSize;
        return _dotSize;
    }
    return _dotSize;
}


@end
