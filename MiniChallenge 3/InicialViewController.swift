//
//  InicialViewController.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/24/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit

class InicialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        performSegueWithIdentifier("inicialSegue", sender: self)
    }
    
    
}
