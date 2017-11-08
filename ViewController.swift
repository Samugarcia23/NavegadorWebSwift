//  Created by usuario1 on 3/11/17.
//  Copyright © 2017 usuario1. All rights reserved.


import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var btnRR: UIButton!
    @IBOutlet weak var btnL: UIButton!
    
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var lblBajo: UILabel!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var web: UIWebView!
    
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref=Database.database().reference()
        url.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        btnGo.isEnabled=false
        btnL.isEnabled=false
        btnRR.isEnabled=false
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if web.canGoBack {
            btnL.isEnabled=true
            
        }
        else {
            btnL.isEnabled=false
        }
        
        if web.canGoForward {
            btnRR.isEnabled=true
            
        }
        else {
            btnRR.isEnabled=true
        }
        
        if (url.text?.characters.count)! > 0 {
            btnGo.isEnabled=true
        }
        else {
            btnGo.isEnabled=false
            
        }
        
    }
    @IBAction func btnLeft(_ sender: Any) {
        web.goBack()
    }
    
    @IBAction func btnRight(_ sender: Any) {
        web.goForward()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        lblBajo.text=web.request?.description
        ref?.child("url").childByAutoId().setValue(lblBajo.text)
        url.text=""
        
        
        
    }
    
    
    
    
    @IBAction func go(_ sender: Any) {
        
        if url.text != "" {
            if url.text?.contains(".") != true {

                    url.text=url.text?.replacingOccurrences(of: " ", with: "+")
     
                url.text="https://www.google.com/search?q="+url.text!
            }else if (url.text?.characters.count)! > 7 {
                let index1 = url.text?.index((url.text?.startIndex)!, offsetBy: 7)
 
                let substring1 = url.text?.substring(to: index1!)
                if substring1?.uppercased() != "http://"  {
                        url.text="http://"+url.text!
                }
            }
            
            
            
        }else if url.text == ""{
            
            url.text="https://www.google.com"
        }
        web.loadRequest(URLRequest(url: URL(string: url.text!)!))
        
    }
}



