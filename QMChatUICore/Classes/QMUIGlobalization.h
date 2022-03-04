//
//  QMUIGlobalization.h
//  QMChatUI
//
//  Created by 焦林生 on 2022/2/17.
//

#import <Foundation/Foundation.h>
#import "QMCommonDef.h"

// TUIKit 字符串国际化
#define QMUILocalizableString(key) [QMUIGlobalization g_localizedStringForKey:@""#key"" bundle:QMChatUIResourceBundle]

@interface QMUIGlobalization : NSObject
//字符串国际化
+ (NSString *)g_localizedStringForKey:(NSString *)key bundle:(NSString *)bundleName;

@end


