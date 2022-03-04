//
//  QMUIGlobalization.m
//  QMChatUI
//
//  Created by 焦林生 on 2022/2/17.
//

#import "QMUIGlobalization.h"

@implementation QMUIGlobalization

+ (NSString *)g_localizedStringForKey:(NSString *)key bundle:(nonnull NSString *)bundleName
{
    return [self g_localizedStringForKey:key value:nil bundle:bundleName];
}

+ (NSString *)g_localizedStringForKey:(NSString *)key value:(nullable NSString *)value bundle:(nonnull NSString *)bundleName
{
    NSString *language = [self tk_localizableLanguageKey];
    language = [@"Localizable" stringByAppendingPathComponent:language];
    NSBundle *bundle = [NSBundle bundleWithPath:[TUIBundle(bundleName) pathForResource:language ofType:@"lproj"]];
    value = [bundle localizedStringForKey:key value:value table:nil];
    NSString *resultStr = [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
    return resultStr;
}

+ (NSString *)tk_localizableLanguageKey
{
    // 默认跟随系统
    // todo: 外部可配置
    NSString *language = [NSLocale preferredLanguages].firstObject;
    if ([language hasPrefix:@"en"]) {
        language = @"en";
    } else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            language = @"zh-Hans"; // 简体中文
        } else { // zh-Hant\zh-HK\zh-TW
            language = @"zh-Hant"; // 繁體中文
        }
    } else if ([language hasPrefix:@"ko"]) {
        language = @"ko";
    } else if ([language hasPrefix:@"ru"]) {
        language = @"ru";
    } else if ([language hasPrefix:@"uk"]) {
        language = @"uk";
    } else {
        language = @"en";
    }
    return language;
}


@end
