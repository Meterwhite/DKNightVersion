//
//  UINavigationBar+TintColor.m
//  UINavigationBar+TintColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UINavigationBar+TintColor.h"
#import "DKNightVersionManager.h"
#import "objc/runtime.h"

@interface UINavigationBar ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation UINavigationBar (TintColor)

- (DKColorPicker)dk_tintColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_tintColorPicker));
}

- (void)setDk_tintColorPicker:(DKColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_tintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.tintColor = picker();
    [self.pickers setValue:[picker copy] forKey:@"setTintColor:"];
}


@end
