//
//  RCTTableViewManager.m
//  RCTTableView
//
//  Created by Pavlo Aksonov on 18.08.15.
//  Copyright (c) 2015 Pavlo Aksonov. All rights reserved.
//

#import "RNTableViewManager.h"
#import "RNTableView.h"
#import "RCTBridge.h"
#import "RCTConvert.h"
#import "RCTUIManager.h"

@implementation RNTableViewManager

RCT_EXPORT_MODULE()
- (UIView *)view
{
    return [[RNTableView alloc] initWithBridge:self.bridge];
}

- (NSArray *)customDirectEventTypes
{
    return @[
             @"onWillDisplayCell",
             @"onEndDisplayingCell",
             @"onItemNotification",
             @"onAccessoryPress",
             @"onLoadMore",
             @"clearSelection",
             ];
}

RCT_EXPORT_VIEW_PROPERTY(sections, NSArray)
RCT_EXPORT_VIEW_PROPERTY(json, NSString)
RCT_EXPORT_VIEW_PROPERTY(editing, BOOL)
RCT_EXPORT_VIEW_PROPERTY(autoFocus, BOOL)
RCT_EXPORT_VIEW_PROPERTY(autoFocusAnimate, BOOL)
RCT_EXPORT_VIEW_PROPERTY(emptyInsets, BOOL)
RCT_EXPORT_VIEW_PROPERTY(filter, NSString)
RCT_EXPORT_VIEW_PROPERTY(selectedValue, id)
RCT_EXPORT_VIEW_PROPERTY(filterArgs, NSArray)
RCT_EXPORT_VIEW_PROPERTY(additionalItems, NSArray)
RCT_EXPORT_VIEW_PROPERTY(selectedIndex, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(selectedSection, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(cellHeight, float)
RCT_EXPORT_VIEW_PROPERTY(footerHeight, float)
RCT_EXPORT_VIEW_PROPERTY(headerHeight, float)
RCT_EXPORT_VIEW_PROPERTY(textColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(tintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(selectedTextColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(selectedBackgroundColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(detailTextColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(separatorColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(moveWithinSectionOnly, BOOL)
RCT_EXPORT_VIEW_PROPERTY(allowsToggle, BOOL)
RCT_EXPORT_VIEW_PROPERTY(allowsMultipleSelection, BOOL)
RCT_EXPORT_VIEW_PROPERTY(alwaysBounceVertical, BOOL)


RCT_CUSTOM_VIEW_PROPERTY(tableViewStyle, UITableViewStyle, RNTableView) {
    [view setTableViewStyle:[RCTConvert NSInteger:json]];
}

RCT_CUSTOM_VIEW_PROPERTY(scrollEnabled, BOOL, RNTableView) {
    [view setScrollEnabled:[RCTConvert BOOL:json]];
}

RCT_EXPORT_VIEW_PROPERTY(cellForRowAtIndexPath, NSArray)

RCT_CUSTOM_VIEW_PROPERTY(tableViewCellStyle, UITableViewStyle, RNTableView) {
    [view setTableViewCellStyle:[RCTConvert NSInteger:json]];
}

RCT_CUSTOM_VIEW_PROPERTY(tableViewCellEditingStyle, UITableViewCellEditingStyle, RNTableView) {
    [view setTableViewCellEditingStyle:[RCTConvert NSInteger:json]];
}

/*Each cell is a separate app, multiple cells share the app/module name*/
RCT_CUSTOM_VIEW_PROPERTY(reactModuleForCell, NSString*, RNTableView) {
    [view setReactModuleForCell:[RCTConvert NSString:json]];
}

RCT_CUSTOM_VIEW_PROPERTY(contentInset, UIEdgeInsets, RNTableView) {
    [view setContentInset:[RCTConvert UIEdgeInsets:json]];
}

RCT_CUSTOM_VIEW_PROPERTY(separatorStyle, UITableViewCellSeparatorStyle, RNTableView) {
    [view setSeparatorStyle:[RCTConvert NSInteger:json]];
}

RCT_CUSTOM_VIEW_PROPERTY(contentOffset, CGPoint, RNTableView) {
    [view setContentOffset:[RCTConvert CGPoint:json]];
}

RCT_CUSTOM_VIEW_PROPERTY(scrollIndicatorInsets, UIEdgeInsets, RNTableView) {
    [view setScrollIndicatorInsets:[RCTConvert UIEdgeInsets:json]];
}

RCT_CUSTOM_VIEW_PROPERTY(showsHorizontalScrollIndicator, BOOL, RNTableView) {
    [view setShowsHorizontalScrollIndicator:[RCTConvert BOOL:json]];
}

RCT_CUSTOM_VIEW_PROPERTY(showsVerticalScrollIndicator, BOOL, RNTableView) {
    [view setShowsVerticalScrollIndicator:[RCTConvert BOOL:json]];
}

- (NSDictionary *)constantsToExport {
    return @{
             @"Style": @{
                     @"Plain": @(UITableViewStylePlain),
                     @"Grouped": @(UITableViewStyleGrouped)
                     },
             @"CellStyle": @{
                     @"Default": @(UITableViewCellStyleDefault),
                     @"Value1": @(UITableViewCellStyleValue1),
                     @"Value2": @(UITableViewCellStyleValue2),
                     @"Subtitle": @(UITableViewCellStyleSubtitle)
                     },
             @"CellEditingStyle": @{
                     @"None": @(UITableViewCellEditingStyleNone),
                     @"Delete": @(UITableViewCellEditingStyleDelete),
                     @"Insert": @(UITableViewCellEditingStyleInsert)
                     },
             @"CellSelectionStyle": @{
                     @"None": @(UITableViewCellSelectionStyleNone),
                     @"Blue": @(UITableViewCellSelectionStyleBlue),
                     @"Gray": @(UITableViewCellSelectionStyleGray),
                     @"Default": @(UITableViewCellSelectionStyleDefault)
                     },
             @"SeparatorStyle": @{
                     @"None": @(UITableViewCellSeparatorStyleNone),
                     @"Line": @(UITableViewCellSeparatorStyleSingleLine),
                     @"LineEtched": @(UITableViewCellSeparatorStyleSingleLineEtched)
                     },
             @"AccessoryType": @{
                     @"None": @(UITableViewCellAccessoryNone),
                     @"DisclosureIndicator": @(UITableViewCellAccessoryDisclosureIndicator),
                     @"DisclosureButton": @(UITableViewCellAccessoryDetailDisclosureButton),
                     @"Checkmark": @(UITableViewCellAccessoryCheckmark),
                     @"DetailButton": @(UITableViewCellAccessoryDetailButton)
                     }
             };
}

RCT_CUSTOM_VIEW_PROPERTY(fontSize, CGFloat, RNTableView)
{
    view.font = [RCTConvert UIFont:view.font withSize:json ?: @(defaultView.font.pointSize)];
}
RCT_CUSTOM_VIEW_PROPERTY(fontWeight, NSString, RNTableView)
{
    view.font = [RCTConvert UIFont:view.font withWeight:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(fontStyle, NSString, RNTableView)
{
    view.font = [RCTConvert UIFont:view.font withStyle:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(fontFamily, NSString, RNTableView)
{
    view.font = [RCTConvert UIFont:view.font withFamily:json ?: defaultView.font.familyName];
}

RCT_CUSTOM_VIEW_PROPERTY(detailFontSize, CGFloat, RNTableView)
{
    view.detailFont = [RCTConvert UIFont:view.detailFont withSize:json ?: @(defaultView.font.pointSize)];
}
RCT_CUSTOM_VIEW_PROPERTY(detailFontWeight, NSString, RNTableView)
{
    view.detailFont = [RCTConvert UIFont:view.detailFont withStyle:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(detailFontStyle, NSString, RNTableView)
{
    view.detailFont = [RCTConvert UIFont:view.detailFont withStyle:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(detailFontFamily, NSString, RNTableView)
{
    view.detailFont = [RCTConvert UIFont:view.detailFont withFamily:json ?: defaultView.font.familyName];
}

RCT_CUSTOM_VIEW_PROPERTY(headerFontSize, CGFloat, RNTableView)
{
    view.headerFont = [RCTConvert UIFont:view.headerFont withSize:json ?: @(defaultView.font.pointSize)];
}
RCT_CUSTOM_VIEW_PROPERTY(headerFontWeight, NSString, RNTableView)
{
    view.headerFont = [RCTConvert UIFont:view.headerFont withWeight:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(headerFontStyle, NSString, RNTableView)
{
    view.headerFont = [RCTConvert UIFont:view.headerFont withStyle:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(headerFontFamily, NSString, RNTableView)
{
    view.headerFont = [RCTConvert UIFont:view.headerFont withFamily:json ?: defaultView.font.familyName];
}


RCT_CUSTOM_VIEW_PROPERTY(footerFontSize, CGFloat, RNTableView)
{
    view.footerFont = [RCTConvert UIFont:view.footerFont withSize:json ?: @(defaultView.font.pointSize)];
}
RCT_CUSTOM_VIEW_PROPERTY(footerFontWeight, NSString, RNTableView)
{
    view.footerFont = [RCTConvert UIFont:view.footerFont withWeight:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(footerFontStyle, NSString, RNTableView)
{
    view.footerFont = [RCTConvert UIFont:view.footerFont withStyle:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(footerFontFamily, NSString, RNTableView)
{
    view.footerFont = [RCTConvert UIFont:view.footerFont withFamily:json ?: defaultView.font.familyName];
}

RCT_EXPORT_METHOD(sendNotification:(NSDictionary *)data)
{
    [self.bridge.eventDispatcher sendInputEventWithName:@"onItemNotification" body:data];
}


RCT_EXPORT_METHOD(scrollTo:(nonnull NSNumber *)reactTag
                  offsetX:(CGFloat)x
                  offsetY:(CGFloat)y
                  animated:(BOOL)animated)
{
    [self.bridge.uiManager addUIBlock:
     ^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry){
         RNTableView *view = viewRegistry[reactTag];
         if (![view isKindOfClass:[RNTableView class]]) {
             RCTLogError(@"Invalid view returned from registry, expecting RNTableView, got: %@", view);
         }
         [view scrollToOffsetX:x offsetY:y animated:animated];
     }];
}


RCT_EXPORT_METHOD(endRefresh:(nonnull NSNumber *)reactTag
                  isHeader:(BOOL)isheader
                  noMoreData:(BOOL)isNoMore)
{
    [self.bridge.uiManager addUIBlock:
     ^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry){
         RNTableView *view = viewRegistry[reactTag];
         if (![view isKindOfClass:[RNTableView class]]) {
             RCTLogError(@"Invalid view returned from registry, expecting RNTableView, got: %@", view);
         }
         [view endRefreshWithHeader:isheader noMoreData:isNoMore];
     }];
}


RCT_EXPORT_METHOD(clearSelection:(nonnull NSNumber *)reactTag)
{
    [self.bridge.uiManager addUIBlock:
     ^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry){
         RNTableView *view = viewRegistry[reactTag];
         if (![view isKindOfClass:[RNTableView class]]) {
             RCTLogError(@"Invalid view returned from registry, expecting RNTableView, got: %@", view);
         }
         [view clearSelection];
     }];
}


//
//- (NSDictionary *)constantsToExport
//{
//    UIPickerView *view = [[UIPickerView alloc] init];
//    return @{
//             @"ComponentHeight": @(view.intrinsicContentSize.height),
//             @"ComponentWidth": @(view.intrinsicContentSize.width)
//             };
//}

@end
