//
//  VestibularesTableViewController.swift
//  MiniChallenge 3
//
//  Created by Ana Elisa Pessoa Aguiar on 18/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit


class VestibularesTableViewController: UITableViewController, UISearchResultsUpdating, CloudKitHelperDelegate{
    
    let model = CloudKitHelper.sharedInstance()
    var resultadoBusca = [FaculdadeCloud]()
    var resultadoBuscaController = UISearchController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        model.delegate = self
        
        self.resultadoBuscaController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Busca"
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        if model.faculdades.count == 0 {
            let alert = UIAlertView(title: "Oops, deu ruim!",
                message: "Você não está conectado à rede de dados", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

    }

    override func didReceiveMemoryWarning()
    {       super.didReceiveMemoryWarning()     }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {       return 1        }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultadoBuscaController.active) {
            return self.resultadoBusca.count
        }
        else
        {       return model.faculdades.count     }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaVestibulares", forIndexPath: indexPath) as! VestibularTableViewCell

        if self.resultadoBuscaController.active {
            cell.nomeLabel.text = resultadoBusca[indexPath.row].nome
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            var inscString = dateFormatter.stringFromDate(resultadoBusca[indexPath.row].vestibular!.dataFimInsc)
            cell.inscricaoLabel.text = inscString
            var provaString = dateFormatter.stringFromDate(resultadoBusca[indexPath.row].vestibular!.dataProvas[0])
            cell.provaLabel.text = provaString
        }
        else {
            cell.nomeLabel.text = model.faculdades[indexPath.row].nome
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            var inscString = dateFormatter.stringFromDate(model.faculdades[indexPath.row].vestibular!.dataFimInsc)
            cell.inscricaoLabel.text = inscString
            var provaString = dateFormatter.stringFromDate(model.faculdades[indexPath.row].vestibular!.dataProvas[0])
            cell.provaLabel.text = provaString
        }

        return cell
    }
    
    //MARK: - CloudKitHelper Delegate
    
    func modelUpdated(){
    }
    
    func errorUpdating(error: NSError)
    {
        let message = error.localizedDescription
        let alert = UIAlertView(title: "Oops, deu ruim!",
            message: "Você não está conectado à rede de dados", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    // MARK: - Segue

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let destino = segue.destinationViewController as? DetailViewController {
            if self.resultadoBuscaController.active {
                destino.faculdade = resultadoBusca[tableView.indexPathForSelectedRow()!.row]
            }
            else {
                destino.faculdade = model.faculdades[tableView.indexPathForSelectedRow()!.row]
            }
        }
    }
    
    // MARK: - Busca
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        self.resultadoBusca.removeAll(keepCapacity: false)
        var arrayNomes: NSMutableArray = []
        var arrayDetalhes: NSMutableArray = []
        
        for faculdade in model.faculdades
        {       arrayNomes.addObject(faculdade.nome)       }
        
        let predicado = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
        let array = (arrayNomes as NSArray).filteredArrayUsingPredicate(predicado)
        
        for fac in model.faculdades {
            for nome in array {
                if fac.nome == nome as! String {
                    self.resultadoBusca.append(fac)
                }
            }
        }
        
        self.tableView.reloadData()
    }

}
