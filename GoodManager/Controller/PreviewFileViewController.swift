//
//  PreviewFileViewController.swift
//  GoodManager
//
//  Created by KevinZhao on 2018/12/29.
//  Copyright © 2018 GoodManager. All rights reserved.
//

import UIKit
import SnapKit
import WebKit
import QuickLook

class PreviewFileViewController: QLPreviewController {
    
    
    var backBtn = UIButton()
    var webView = WKWebView()
    var path:String = ""
   
    init(Path:String){
        super.init(nibName: nil, bundle: nil)
        self.path = Path
    }
    init(){
        super.init(nibName: nil, bundle: nil)
        
    }
    @objc func setPath(Path:String) {
       self.path = Path
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "文件预览"
        self.delegate = self
        self.dataSource = self
//        setWebView(path: path)
//        showCloseButton()
        // Do any additional setup after loading the view.
    }

//    func setWebView(path:String){
//        self.view.addSubview(webView)
//        self.webView.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalTo(0)
//            make.top.equalTo(self.view).offset(20)
//        }
//        let documentPath = NSHomeDirectory() + "/Documents/localDocuments"
//        let fileUrl = URL(fileURLWithPath: documentPath + path)
//
//        webView.load(URLRequest(url: fileUrl))
////        webView.scalesPageToFit = true
//    }
    
    func showCloseButton(){
        let barButton = UIBarButtonItem.init(title: "返回", style: .done, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
}

extension PreviewFileViewController: QLPreviewControllerDelegate, QLPreviewControllerDataSource{
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
//        let documentPath = NSHomeDirectory() + "/Documents"
        print("%@",path);
        let fileUrl = URL(fileURLWithPath:  path)
        return fileUrl as QLPreviewItem
    }
}
