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
//  TKPost.m by Igor Sutton on 7/12/10.
//

#import "TKPost.h"

static struct {
    NSString *name;
    NSString *className;
} TKPostTypeStringToClassName[] = {
    { @"photo", @"TKPostPhoto" },
    { @"conversation", @"TKPostConversation" },
    { @"link", @"TKPostLink" },
    { @"quote", @"TKPostQuote" },
    { @"regular", @"TKPostRegular" },
    { nil, nil }
};

static NSString *TKPostTypeAsString[] = {
    @"",
    @"TKPostTypeRegular",
    @"TKPostTypeLink",
    @"TKPostTypeQuote",
    @"TKPostTypePhoto",
    @"TKPostTypeConversation",
    @"TKPostTypeVideo",
    @"TKPostTypeAudio",
    @"TKPostTypeAnswer"
};

static NSString *TKPostFormatAsString[] = {
    @"TKPostFormatHTML",
    @"TKPostFormatMarkdown"
};

@implementation TKPost

@synthesize postId, url, slug, date, reblogKey, type, format;

- (id)init
{
    if ((self = [super init]) != nil) {
        self.postId = nil;
        self.url = nil;
        self.type = TKPostTypeRegular;
        self.reblogKey = nil;
        self.date = nil;
        self.url = nil;
        self.format = TKPostFormatHTML;
    }

    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributeDict
{
    if ((self = [self init]) != nil) {
        self.postId = [attributeDict objectForKey:@"id"];
        self.url = [attributeDict objectForKey:@"url"];
        self.date = [attributeDict objectForKey:@"date"];
        self.slug = [attributeDict objectForKey:@"slug"];
        self.reblogKey = [attributeDict objectForKey:@"reblog-key"];

        NSString *format_ = [attributeDict objectForKey:@"format"];

        if ([format_ isEqualToString:@"html"])
            self.format = TKPostFormatHTML;
        else
            self.format = TKPostFormatMarkdown;

    }

    return self;
}

- (void)dealloc
{
    [postId release];
    [url release];
    [date release];
    [slug release];
    [reblogKey release];
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Post Id: %@, Date: %@, URL: %@, Slug: %@, Type: %@, Reblog Key: %@, Format: %@", self.postId, self.date, self.url, self.slug, TKPostTypeAsString[self.type], self.reblogKey, TKPostFormatAsString[self.format]];
}

+ (id)postWithAttributes:(NSDictionary *)attributeDict
{
    Class postClass;
    NSString *type_ = [attributeDict objectForKey:@"type"];

    for (int i = 0; TKPostTypeStringToClassName[i].name != nil; i++) {
        if ([TKPostTypeStringToClassName[i].name isEqualToString:type_]) {
            postClass = NSClassFromString(TKPostTypeStringToClassName[i].className);
            break;
        }
    }

    if (postClass) {
        TKPost *post = [(TKPost *)[postClass alloc] initWithAttributes:attributeDict];
        return post;
    }

    return nil;
}

@end

@implementation TKPostRegular

- (id)init
{
    if ((self = [super init]) != nil) {
        self.title = @"";
        self.body = @"";
    }

    return self;
}

- (void)dealloc
{
    [title release];
    [body release];
    [super dealloc];
}

- (NSString *)title
{
    return [title copy];
}

- (void)setTitle:(NSString *)aTitle
{
    if (aTitle != title) {
        [title release];
        title = [aTitle mutableCopy];
    }
}

- (NSString *)body
{
    return [body copy];
}

- (void)setBody:(NSString *)aBody
{
    if (aBody != body) {
        [body release];
        body = [aBody mutableCopy];
    }
}

- (void)appendToBody:(NSString *)string
{
    [body appendString:string];
}

- (void)appendToTitle:(NSString *)string
{
    [title appendString:string];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, Title: %@, Body: %@", [super description], self.title, self.body];
}

@end

@implementation TKPostLink

@synthesize URL;

- (id)init
{
    if ((self = [super init]) != nil) {
        URL = nil;
        type = TKPostTypeLink;
        text = [[NSMutableString alloc] init];
    }

    return self;
}

- (void)dealloc
{
    [URL release];
    [text release];
    [super dealloc];
}

- (NSString *)text
{
    return [text copy];
}

- (void)setText:(NSString *)aText
{
    if (aText != text) {
        [text release];
        text = [aText mutableCopy];
    }
}

- (void)appendToText:(NSString *)string
{
    [text appendString:string];
}

- (void)setURLWithString:(NSString *)URLString
{
    [URL release];
    self.URL = [NSURL URLWithString:URLString];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, Link Text: %@, Link URL: %@", [super description], self.text, self.URL];
}

@end

@implementation TKPostQuote

- (id)init
{
    if ((self = [super init]) != nil) {
        type = TKPostTypeQuote;
        source = [[NSMutableString alloc] init];
        text = [[NSMutableString alloc] init];
    }

    return self;
}

- (void)dealloc
{
    [text release];
    [super dealloc];
}

- (NSString *)text
{
    return [text copy];
}

- (void)setText:(NSString *)aText
{
    if (aText != text) {
        [text release];
        text = [aText mutableCopy];
    }
}

- (NSString *)source
{
    return [source copy];
}

- (void)setSource:(NSString *)aSource
{
    if (aSource != source) {
        [source release];
        text = [aSource mutableCopy];
    }
}

- (void)appendToText:(NSString *)string
{
    [text appendString:string];
}

- (void)appendToSource:(NSString *)string
{
    [source appendString:string];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, Quote Text: %@, Quote Source: %@", [super description], self.text, self.source];
}

@end

@implementation TKPostConversation

- (id)init
{
    if ((self = [super init]) != nil) {
        type = TKPostTypeConversation;
        text = [[NSMutableString alloc] init];
    }

    return self;
}

- (void)dealloc
{
    [text release];
    [super dealloc];
}

- (NSString *)text
{
    return [text copy];
}

- (void)setText:(NSString *)aText
{
    if (aText != text) {
        [text release];
        text = [aText mutableCopy];
    }
}

- (void)appendToText:(NSString *)string
{
    [text appendString:string];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Conversation Text: %@", self.text];
}

@end

@implementation TKPostPhoto

@synthesize width, height;

- (id)init
{
    if ((self = [super init]) != nil) {
        type = TKPostTypePhoto;
        caption = [[NSMutableString alloc] init];
        width = 0;
        height = 0;
    }

    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributeDict
{
    if ((self = [super initWithAttributes:attributeDict]) != nil) {
        width = [[attributeDict objectForKey:@"width"] intValue];
        height = [[attributeDict objectForKey:@"height"] intValue];
    }

    return self;
}

- (void)dealloc
{
    [caption release];
    [super dealloc];
}

- (NSString *)caption
{
    return [caption copy];
}

- (void)setCaption:(NSString *)aCaption
{
    if (aCaption != caption) {
        [caption release];
        caption = [aCaption mutableCopy];
    }
}

- (void)appendToCaption:(NSString *)string
{
    [caption appendString:string];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, Photo Caption: %@, Photo Width: %i, Photo Height: %i", [super description], self.caption, self.width, self.height];
}

@end
