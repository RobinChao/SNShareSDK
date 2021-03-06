//
//  SNShareModel.h
//  SNShareSDK
//
//  Created by libo on 9/19/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "VDShareParam.h"
#import "SNShareHeaders.h"

@interface SNShareModel : NSObject

/*!
 *  @brief  必选参数: shareType和shareDest
 */
@property (nonatomic,readwrite) SNShareType shareType;
@property (nonatomic, readwrite) SNShareDestination shareDest;

@property (nonatomic, retain) NSString  *title;
@property (nonatomic, retain) NSString  *description;
@property (nonatomic, retain) NSString  *url;
@property (nonatomic, retain) NSString  *imgUrl;
@property (nonatomic, retain) UIImage   *image;

@property (nonatomic,retain)  VDShareVideoParam *videoParams;
@property (nonatomic,retain) VDShareAudioParam *audioParams;
@property (nonatomic, copy)   NSString* videoID;

/*!
*  使用多图接口传多图到新浪微博
*/
@property (nonatomic,retain) VDShareParamAddOn *addOn;
/*!
 *  @brief  允许微博发送多图，默认为NO
 */
@property (nonatomic,readwrite) BOOL supportMutableImgForWeibo;

@end
