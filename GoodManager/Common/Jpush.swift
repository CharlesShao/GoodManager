//
//  JpushViewController.swift
//  GoodManager
//
//  Created by charles on 2019/2/21.
//  Copyright © 2019 GoodManager. All rights reserved.
//

import Foundation


func APPPushSetAlias(_ alias:String)  {
    let Main = getLastMainViewController()
    let checkNetObject = checkNet()
    let isReach = checkNetObject.isReach()
    print(isReach)
    if(isReach){
        
    }else{
        Main.nonetLoad()
        return ;
    }
    JPUSHService.setAlias(alias, completion: { (seq, alias, res) in
        print("\(seq)---\(alias)---\(res)");
    }, seq: 110);
}
//    取消极光账号
func APPPushCancelAlias()  {
    let Main = getLastMainViewController()
    let checkNetObject = checkNet()
    let isReach = checkNetObject.isReach()
    print(isReach)
    if(isReach){
        
    }else{
        Main.nonetLoad()
        return ;
    }
    JPUSHService.deleteAlias({ (iResCode, iAlias, seq) in
        
    }, seq: 110)
}
//    设置新消息提醒方式接口
func APPPushMsgRemindType(_ ifOpenVoice:Int,ifOpenVibration:Int)  {
    let Main = getLastMainViewController()
    let checkNetObject = checkNet()
    let isReach = checkNetObject.isReach()
    print(isReach)
    if(isReach){
        
    }else{
        Main.nonetLoad()
        return ;
    }
    let entity:JPUSHRegisterEntity = JPUSHRegisterEntity();
    if ifOpenVoice == 0 {
        
        entity.types = Int(JPAuthorizationOptions.alert.rawValue);
    }else
    {
        entity.types = Int(JPAuthorizationOptions.alert.rawValue)|Int(JPAuthorizationOptions.sound.rawValue);
    }
    let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate;
    JPUSHService.register(forRemoteNotificationConfig: entity, delegate: delegate);
    
}




