//
//  ViewController.swift
//  Cookies
//
//  Created by Omar Allaham on 1/26/17.
//  Copyright © 2017 Bemaxnet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   @IBOutlet weak var webview: UIWebView!

   let url = URL(string: "https://dashboardgrouping.correadasilva.com")

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.

      if let url = url {
         webview.loadRequest(URLRequest(url:url))
      }
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


}

