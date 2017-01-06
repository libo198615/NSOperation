//
//  ViewController.swift
//  LBOperation
//
//  Created by boli on 16/11/23.
//  Copyright © 2016年 boli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let queue = MyOperationQueue()
//        queue.dependencyAction()
//        queue.operationCompletion()
//        queue.queueTest()
        queue.test10()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

