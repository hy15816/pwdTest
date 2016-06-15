//
//  PwdTest-Prefix.h
//  PwdTest
//
//  Created by Lost_souls on 16/4/29.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//


//#ifdef DEBUG
#define MMLog( s, ... ) NSLog( @"L:%d [%@: - %@]  %@",__LINE__, [[NSString stringWithUTF8String:__FILE__] lastPathComponent],NSStringFromSelector(_cmd),  [NSString stringWithFormat:(s), ##__VA_ARGS__] ); //分别是文件名，在文件的第几行，自定义输出内容
//#else
//#define MMLog( s, ... );
//#endif

#ifdef __OBJC__

    #import <UIKit/UIKit.h>
    #import <Foundation/Foundation.h>
    #import "Common.h"
    #import "LSNavigationController.h"

    #import <BmobIMSDK/BmobIMSDK.h>     //bmob im
    #import <BmobSDK/Bmob.h>            //bmob base

#endif