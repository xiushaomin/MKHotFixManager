//
//  GKDHotFixManager.h
//  sojex
//
//  Created by gkoudai_xsm on 16/8/27.
//  Copyright © 2016年 finance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKHotFixManager : NSObject

+(instancetype)shareManager;

-(void)downloadScriptAndRun;

-(void)runTestScript;
@end
