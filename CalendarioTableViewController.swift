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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        model.delegate = self
        
        self.organiza.configurar(model.vestibulares)
        
        if model.vestibulares.count == 0 {
            let alert = UIAlertView(title: "Oops, deu ruim!",
                message: "Você não está conectado à rede de dados", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }

    override func didReceiveMemoryWarning()
    {       super.didReceiveMemoryWarning()     }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {       return organiza.getNumeroSecoes()       }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {       return organiza.getNumeroLinhasSecao(section)       }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let diaProva = dateFormatter.stringFromDate(organiza.getDiaProva(section))
        return diaProva
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaCalendario", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = organiza.getNomesVestibulares(indexPath.section, linha: indexPath.row)

        return cell
    }
    
    //MARK: - CloudKitHelper Delegate
    
    func modelUpdated() {
    }
    
    func errorUpdating(error: NSError) {
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let destino = segue.destinationViewController as? DetailViewController {
            let nomeVest = organiza.getNomesVestibulares(tableView.indexPathForSelectedRow()!.section, linha: tableView.indexPathForSelectedRow()!.row)
            destino.vestibular = organiza.getVestibularByNome(nomeVest)
        }
    }

}
