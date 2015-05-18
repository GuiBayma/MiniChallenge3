//
//  BuscaViewController.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/15/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit

class BuscaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func buscar(sender: UIButton) {
        self.performSegueWithIdentifier("resultadoBusca", sender: self)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        textField.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
