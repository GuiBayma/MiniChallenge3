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
        model.refreshVestibular()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(model, action: "refreshVestibular", forControlEvents: .ValueChanged)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = model.vestibulares[indexPath.row].nome
        cell.detailTextLabel?.text = model.vestibulares[indexPath.row].detalhes

        return cell
    }
    
    //MARK: - CloudKitHelper Delegate
    
    func modelUpdated() {
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func errorUpdating(error: NSError) {
        let message = error.localizedDescription
        let alert = UIAlertView(title: "Error Loading Todos",
            message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    // MARK: - Segue

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destino = segue.destinationViewController as? DetailViewController
    }
    

}
