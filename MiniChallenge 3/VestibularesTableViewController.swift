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
//        model.refreshVestibular() tem q sair pra n faze sempre direto
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshVestibular:", name: "CarregandoDados", object: self.model)
        
//        refreshControl = UIRefreshControl()
//        refreshControl?.addTarget(model, action: "refreshVestibular", forControlEvents: .ValueChanged) //atualiza a tabela puxando para baixo
        
        self.resultadoBuscaController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
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
        return model.vestibulares.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaVestibulares", forIndexPath: indexPath) as! VestibularTableViewCell

        if self.resultadoBuscaController.active {
            
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
        let destino = segue.destinationViewController as? DetailViewController
    }
    
    // MARK: - Busca
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.tableView.reloadData()
    }

}
