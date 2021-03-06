//
//  ABPeoplePickerController.swift
//  GoodManager
//
//  Created by KevinZhao on 2019/1/5.
//  Copyright © 2019 GoodManager. All rights reserved.
//

import UIKit
import ContactsUI
import SwiftyJSON

typealias ContactsString = (String) -> Void
class ContactPickerController: CNContactPickerViewController {
    var maxNum:Int = 0
    var contactArray:Array<String> = []
    var backClosure: ContactsString?// 数据回调闭包
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func alert(){
        let alertVC = UIAlertController(title:nil, message:"选择联系人超过最大数量: \(maxNum)", preferredStyle: .alert)
//        let alertAction1 = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler:nil)
//        alertVC.addAction(alertAction1)
        self.present(alertVC, animated:true, completion:nil)
    }
}

extension ContactPickerController:CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]){
        contactArray = []
        if(contacts.count > maxNum){
            alert()
        }else{
            for contact in contacts {
                //获取联系人的姓名
                let lastName = contact.familyName
                let firstName = contact.givenName
                
                //获取联系人电话号码
                let phones = contact.phoneNumbers
                var phoneValue = ""
                var contactModel = TelBookModel(Phonenumber: phoneValue, Name: lastName + firstName)
                if (phones.first != nil){
                    phoneValue = phones.first!.value.stringValue
                    contactModel = TelBookModel(Phonenumber: phoneValue, Name: lastName + firstName)
                }else{
                    contactModel = TelBookModel(Phonenumber: "暂无号码", Name: lastName + firstName)
                }
                contactArray.append(contactModel.toJSONString()!)
            }
            self.backClosure!(contactArray.getJSONStringFromArray())
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        contactArray = []
        self.backClosure!(contactArray.getJSONStringFromArray())
    }
    
}
