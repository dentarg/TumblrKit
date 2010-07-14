//
//
//  This file is part of TumblrKit
//
//  TumblrKit is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Foobar is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with TumblrKit.  If not, see <http://www.gnu.org/licenses/>.
//
//  TKTumblrRequest.h by Igor Sutton on 7/13/10.
//

#import <Cocoa/Cocoa.h>
#import "TKPost.h"

@interface TKTumblrRequest : NSObject
{
    NSURL *URL;
    NSUInteger startIndex;
    NSUInteger numberOfPosts;
    NSUInteger postId;
    TKPostFilter postFilter;
    TKPostType postType;
    TKPost *post;
}

@property (copy)   NSURL *URL;
@property (assign) NSUInteger startIndex;
@property (assign) NSUInteger numberOfPosts;
@property (assign) NSUInteger postId;
@property (assign) TKPostFilter postFilter;
@property (assign) TKPostType postType;
@property (assign) TKPost *post;

+ (id)requestWithURL:(NSURL *)theURL;

- (id)initWithURL:(NSURL *)theURL;
- (BOOL)isWrite;
- (NSURL *)URLForRead;
- (NSURL *)URLForWrite;

@end
