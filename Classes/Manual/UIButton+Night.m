//
//  UIButton+Night.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "UIButton+Night.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UIButton (Night)

- (void)dk_setTitleColorPicker:(DKColorPicker)picker forState:(UIControlState)state {
    [self setTitleColor:picker() forState:state];
    NSString *key = [NSString stringWithFormat:@"%@", @(state)];
    NSMutableDictionary *dictionary = [self.pickers valueForKey:key];
    if (!dictionary) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    [dictionary setValue:[picker copy] forKey:@"setTitleColor:forState:"];
    [self.pickers setValue:dictionary forKey:key];
}

- (void)night_updateColor {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary<NSString *, DKColorPicker> *dictionary = (NSDictionary *)obj;
            [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DKColorPicker  _Nonnull picker, BOOL * _Nonnull stop) {
                UIColor *resultColor = picker();
                UIControlState state = [key integerValue];
                if ([selector isEqualToString:NSStringFromSelector(@selector(setTitleColor:forState:))]) {
                    [self setTitleColor:resultColor forState:state];
                }
            }];
        } else {
            SEL sel = NSSelectorFromString(key);
            DKColorPicker picker = (DKColorPicker)obj;
            UIColor *resultColor = picker();
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:sel withObject:resultColor];
#pragma clang diagnostic pop

        }
    }];
}

@end
