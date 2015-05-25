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
    var resultadoBusca = [VestibularCloud]()
    var resultadoBuscaController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
//        model.refreshVestibular()       
//        refreshControl = UIRefreshControl()
//        refreshControl?.addTarget(model, action: "refreshVestibular", forControlEvents: .ValueChanged) //atualiza a tabela puxando para baixo
        
        self.resultadoBuscaController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Busca"
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultadoBuscaController.active) {
            return self.resultadoBusca.count
        }
        else {
            return model.vestibulares.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaVestibulares", forIndexPath: indexPath) as! VestibularTableViewCell

        if self.resultadoBuscaController.active {
            cell.nomeLabel.text = resultadoBusca[indexPath.row].nome
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            var inscString = dateFormatter.stringFromDate(resultadoBusca[indexPath.row].dataFimInsc)
            cell.inscricaoLabel.text = inscString
            var provaString = dateFormatter.stringFromDate(resultadoBusca[indexPath.row].dataProvas[0])
            cell.provaLabel.text = provaString
        }
        else {
            cell.nomeLabel.text = model.vestibulares[indexPath.row].nome
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            var inscString = dateFormatter.stringFromDate(model.vestibulares[indexPath.row].dataFimInsc)
            cell.inscricaoLabel.text = inscString
            var provaString = dateFormatter.stringFromDate(model.vestibulares[indexPath.row].dataProvas[0])
            cell.provaLabel.text = provaString
        }

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
        self.resultadoBuscaController.active = false
        if let destino = segue.destinationViewController as? DetailViewController {
            destino.vestibular = model.vestibulares[tableView.indexPathForSelectedRow()!.row]
        }
    }
    
    // MARK: - Busca
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.resultadoBusca.removeAll(keepCapacity: false)
        var arrayNomes: NSMutableArray = []
        var arrayDetalhes: NSMutableArray = []
        
        for vestibular in model.vestibulares {
            arrayNomes.addObject(vestibular.nome)
        }
        
        let predicado = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
        let array = (arrayNomes as NSArray).filteredArrayUsingPredicate(predicado)
        
        for vest in model.vestibulares {
            for nome in array {
                if vest.nome == nome as! String {
                    self.resultadoBusca.append(vest)
                }
            }
        }
        
        self.tableView.reloadData()
    }

}
