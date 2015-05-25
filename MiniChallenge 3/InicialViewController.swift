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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.reachabilityStatusChanged() 
        performSegueWithIdentifier("inicialSegue", sender: self)
    }
    
    func reachabilityStatusChanged(){
        if reachabilityStatus == kNotReachable{
            /*já tem um método q tem um alerta*/
        }else if reachabilityStatus == kReachableWithWifi{
            /*não precisa de um alerta pq já vai direto*/
            NSNotificationCenter.defaultCenter().postNotificationName("CarregandoDados", object: self)
        }else if reachabilityStatus == kReachableWithWwan{
            //Alerta
            let alerta: UIAlertController = UIAlertController (title: "Atenção", message: "Vc está prestes a usar uma quantidade muito grande de dados. Deseja continuar mesmo assim? ", preferredStyle: .Alert)
            
            let acao1: UIAlertAction = UIAlertAction (title: "Não", style: .Default){       action -> Void in
                /* nao vai acontecer nada, tem q colocar notificação */
                
            }
            alerta.addAction(acao1)
            
            let acao2: UIAlertAction = UIAlertAction (title: "Sim", style: .Default){       action -> Void in
                
            }
            alerta.addAction(acao2)
            
            self.presentViewController(alerta, animated: true, completion: nil)
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
}
