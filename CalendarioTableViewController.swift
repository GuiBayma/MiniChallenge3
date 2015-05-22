//
//  CalendarioTableViewController.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/21/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit

class CalendarioTableViewController: UITableViewController, CloudKitHelperDelegate {
    
    let model = CloudKitHelper.sharedInstance()
    let organiza = OrganizaDataVestibular()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self
        model.refreshVestibular()
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshVestibular:", name: "CarregandoDados", object: self.model)

        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(model, action: "refreshVestibular", forControlEvents: .ValueChanged)
        
        self.organiza.configurar(model.vestibulares)
      //  self.organiza.configTeste()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return organiza.getNumeroSecoes()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organiza.getNumeroLinhasSecao(section)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        let diaProva = dateFormatter.stringFromDate(organiza.getDiaProva(section))
        return diaProva
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaCalendario", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = organiza.getNomesFaculdades(indexPath.section, linha: indexPath.row)

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

}
