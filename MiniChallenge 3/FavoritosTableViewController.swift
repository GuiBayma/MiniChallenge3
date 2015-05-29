//
//  FavoritosTableViewController.swift
//  MiniChallenge 3
//
//  Created by Ana Elisa Pessoa Aguiar on 18/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit

class FavoritosTableViewController: UITableViewController {
    
    lazy var modelCD:Array<Faculdade> = {
        return FaculdadeManager.sharedInstance.findFaculdade()
        }()
    
    var favoritos = [Faculdade]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.reloadData()

    }
    
    override func viewDidAppear(animated: Bool){
        modelCD = FaculdadeManager.sharedInstance.findFaculdade()
        self.tableView.reloadData()
        tabBarController?.tabBar.tintColor = UIColor(red: 230.0/255.0, green: 39.0/255.0, blue: 45.0/255.0, alpha: 1)
    }
    
    
    override func didReceiveMemoryWarning()
    {        super.didReceiveMemoryWarning()        }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {       return 1        }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.favoritos.removeAll(keepCapacity: true)
        var i = 0
        for favs in modelCD{
            if modelCD[i].favorito == 1{
                self.favoritos.append(favs)
            }
            i = i+1
        }
        
        return self.favoritos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaFavoritos", forIndexPath: indexPath) as! FavoritosTableViewCell
    
        cell.nome.text = favoritos[indexPath.row].nome
        

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

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let destino = segue.destinationViewController as? DetailViewController {
            //destino.vestibular = model.vestibulares[tableView.indexPathForSelectedRow()!.row]
        }
    }

}
