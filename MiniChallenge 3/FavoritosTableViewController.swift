//
//  FavoritosTableViewController.swift
//  MiniChallenge 3
//
//  Created by Ana Elisa Pessoa Aguiar on 18/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit

class FavoritosTableViewController: UITableViewController, CloudKitHelperDelegate {
    
    let model = CloudKitHelper.sharedInstance()
    var favoritos = [FaculdadeCloud]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        model.delegate = self
        model.refreshFaculdade()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(model, action: "refreshVestibular", forControlEvents: .ValueChanged)
    }
    
    override func viewDidAppear(animated: Bool)
    {       self.reachabilityStatusChanged()        }
    
    func reachabilityStatusChanged()
    {
        if reachabilityStatus == kNotReachable
        {
            //Alerta
            let alerta: UIAlertController = UIAlertController (title: "Atenção", message: "Neste primeiro acesso vc deve estar conectado a alguma rede Wi-fi.", preferredStyle: .Alert)
            
            let acao1: UIAlertAction = UIAlertAction (title: "OK", style: .Default)
                {       action -> Void in println("ok")     }
            alerta.addAction(acao1)
            self.presentViewController(alerta, animated: true, completion: nil)
        }
        else if reachabilityStatus == kReachableWithWifi
        {
            
        }
        else if reachabilityStatus == kReachableWithWwan
        {
            //Alerta
            let alerta: UIAlertController = UIAlertController (title: "Atenção", message: "Vc está prestes a usar uma quantidade muito grande de dados. Deseja se conectar a uma rede Wi-fi? ", preferredStyle: .Alert)
            
            let acao1: UIAlertAction = UIAlertAction (title: "Não", style: .Default)
                {       action -> Void in println("Apareceu!!! ")     }
            alerta.addAction(acao1)
            
            let acao2: UIAlertAction = UIAlertAction (title: "Sim", style: .Default)
                {   action -> Void in println("Apareceu Denovo!!!!! ")      }
            alerta.addAction(acao2)
            
            self.presentViewController(alerta, animated: true, completion: nil)
        }
    }
    
    deinit
    {       NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)      }

    override func didReceiveMemoryWarning()
    {        super.didReceiveMemoryWarning()        }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        var i = 0
        for favs in model.faculdades{
            if model.faculdades[i].favorito == 1{
                favoritos.append(favs)
            }
            i = i+1
        }
        
        return self.favoritos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("favorito", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        
        cell.textLabel?.text = favoritos[indexPath.row].nome

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
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

}
