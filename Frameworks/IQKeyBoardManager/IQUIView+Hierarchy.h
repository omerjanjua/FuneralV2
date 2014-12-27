//
//  UIView+Hierarchy.h
// https://github.com/hackiftekhar/IQKeyboardManager
// Copyright (c) 2013-14 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIView.h>

@class UIScrollView, UITableView, NSArray;

@interface UIView (IQ_UIView_Hierarchy)

/*!
    @method viewController:
 
    @return Returns the UIViewController object that manages the receiver.
 */
-(UIViewController*)viewController;

/*!
    @method superScrollView:
 
    @return Returns the UIScrollView object if any found in view's upper hierarchy.
 */
- (UIScrollView*)superScrollView;

/*!
    @method superTableView:
 
    @return Returns the UITableView object if any found in view's upper hierarchy.
 */
- (UITableView*)superTableView;

/*!
    @method responderSiblings:
 
    @return returns all siblings of the receiver which canBecomeFirstResponder.
 */
- (NSArray*)responderSiblings;

/*!
    @method deepResponderViews:
 
    @return returns all deep subViews of the receiver which canBecomeFirstResponder.
 */
- (NSArray*)deepResponderViews;

/*!
    @method isInsideSearchBar:
 
    @return returns YES if the receiver object is UISearchBarTextField, otherwise return NO.
 */
-(BOOL)isSearchBarTextField;

/*!
    @method isAlertViewTextField:
 
    @return returns YES if the receiver object is UIAlertSheetTextField, otherwise return NO.
 */
-(BOOL)isAlertViewTextField;

/*!
    @method isEventKitTextView:
 
    @return returns YES if the receiver object is EKPlaceholderTextView, otherwise return NO.
 */
-(BOOL)isEventKitTextView;

/*!
    @method convertTransformToView::
 
    @return returns current view transform with respect to the 'toView'.
 */
-(CGAffineTransform)convertTransformToView:(UIView*)toView;

/*!
    @method subHierarchy:
 
    @return Returns a string that represent the information about it's subview's hierarchy. You can use this method to debug the subview's positions.
 */
- (NSString *)subHierarchy;

/*!
    @method superHierarchy:
 
    @return Returns an string that represent the information about it's upper hierarchy. You can use this method to debug the superview's positions.
 */
- (NSString *)superHierarchy;

@end


@interface UIView (IQ_UIView_Frame)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat x, y, width, height;
@property (nonatomic, assign) CGFloat left, right, top, bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, readonly) CGPoint boundsCenter;

@end
