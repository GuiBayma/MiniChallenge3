//
//  VestibularesTableViewController.swift
//  MiniChallenge 3
//
//  Created by Ana Elisa Pessoa Aguiar on 18/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit


class VestibularesTableViewController: UITableViewController, CloudKitHelperDelegate{
    
    let model = CloudKitHelper.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
//        model.refreshVestibular() tem q sair pra n faze sempre direto
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.vestibulares.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaVestibulares", forIndexPath: indexPath) as! VestibularTableViewCell

        cell.nomeLabel.text = model.vestibulares[indexPath.row].nome
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        var inscString = dateFormatter.stringFromDate(model.vestibulares[indexPath.row].dataFimInsc)
        cell.inscricaoLabel.text = inscString
        var provaString = dateFormatter.stringFromDate(model.vestibulares[indexPath.row].dataProvas[0])
        cell.provaLabel.text = provaString

        return cell
    }
    
    //MARK: - CloudKitHelper Delegate
    
    func modelUpdated() {
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func errorUpdating(error: NSError) {
        let message = error.localizedDescription
        let alert = UIAlertView(title: "Oops, deu ruim!",
            message: "Você não está conectado à rede de dados", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    // MARK: - Segue

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destino = segue.destinationViewController as? DetailViewController
    }
    

}
