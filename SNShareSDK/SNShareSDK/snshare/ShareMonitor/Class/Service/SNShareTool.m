//
//  SNShareTool.m
//  SNShareSDK
//
//  Created by libo on 10/27/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "SNShareTool.h"

@implementation SNShareTool

+(NSError *)checkDataModel:(SNShareModel *)model
{
    NSMutableString *errorMsg = [[NSMutableString alloc] init];
    if (model.shareType == SNShareTypeUnknown) {
        [errorMsg appendString:@"\nshareType不能为空"];
    }
    if (model.shareDest == SNShareDestinationUnknown) {
        [errorMsg appendString:@"\nshareDest不能为空"];
    }
    if (model.title.length == 0) {
        [errorMsg appendString:@"\ntitle不能为空"];
    }
    if (model.description.length == 0) {
        [errorMsg appendString:@"\ndescription不能为空"];
    }
    if (model.supportMutableImgForWeibo == YES && model.addOn == nil) {
        DLog(@"警告:分享设置了supportMutableImgForWeibo但model.addOn字段为空！");
    }
    
    if (errorMsg.length > 0) {
         NSError *error = [NSError errorWithDomain:@"SNSCheckModelError" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:errorMsg, NSLocalizedDescriptionKey,nil]];
        return error;
    }else {
        return nil;
    }
}

+(VDShareParam *)getShareParam:(SNShareModel *)model
{
    VDShareParam *params = [[VDShareParam alloc] init];
    params.title = model.title;
    params.description = model.description;
    params.image = model.image;
    params.imgUrl = model.imgUrl;
    params.url = model.url;
    
    if (model.shareType == SNShareTypeVideo) {
        params.videoUrl = model.videoParams;
        params.videoID = model.videoID;
    }
    
    if (model.shareType == SNShareTypeVideo) {
        params.audioUrl = model.audioParams;
    }
    
    return params;

}

+(NSString *)parseResponseCode:(VDShareErrCode)errCode
{
    
    DLog(@"分享Code:%d",errCode);
    
    NSString *msg = nil;
    switch (errCode) {
        case VDShareErrCodeNoErr:
        {
            msg = @"分享成功";
            break;
        }
        case VDShareErrCodeCommonErr:
        {
            msg = @"未知错误";
            break;
        }
        case VDShareErrCodeUserCancel:
        {
            msg = @"取消分享";
            break;
            
        }
        case VDShareErrCodeSendErr:
        {
            msg = @"分享失败";
            break;
        }
        case VDShareErrCodeAuthDeny:
        {
            msg = @"请重新登录";
            break;
        }
        case VDShareErrCodeUnsupport:
        {
            msg = @"客户端不支持";
            break;
            
        }
        case VDShareErrCodeImgIsNil:
        {
            msg = @"图片为空";
            break;
            
        }
        case VDShareErrCodeAttachmentOversize:
        {
            msg = @"附件过大";
            break;
            
        }
        case VDShareErrCodeAPPNotInstalled:
        {
            msg = @"请安装客户端";
            break;
            
        }
        default:
            break;
    }
    return msg;
}

+(SNShareDestination)getShareDest:(NSString *)dest
{
    SNShareDestination d = SNShareDestinationUnknown;
    if (dest.length > 0) {
        if ([dest isEqualToString:@"SNShareDestinationQQFriend"]) {
            d = SNShareDestinationQQFriend;
        }else if([dest isEqualToString:@"SNShareDestinationQQZone"])
        {
            d = SNShareDestinationQQZone;
        }
        else if([dest isEqualToString:@"SNShareDestinationWeixinFriend"])
        {
            d = SNShareDestinationWeixinFriend;
        }
        else if([dest isEqualToString:@"SNShareDestinationWeixinMoments"])
        {
            d = SNShareDestinationWeixinMoments;
        }
        else if([dest isEqualToString:@"SNShareDestinationWeibo"])
        {
            d = SNShareDestinationWeibo;
        }
    }
    return d;
}


@end
