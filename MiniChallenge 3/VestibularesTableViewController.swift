//
//  VestibularesTableViewController.swift
//  MiniChallenge 3
//
//  Created by Ana Elisa Pessoa Aguiar on 18/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit


class VestibularesTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    lazy var modelCD:Array<Vestibular> = {
        return VestibularManager.sharedInstance.findVestibular()
        }()
    var resultadoBusca = [Vestibular]()
    var resultadoBuscaController = UISearchController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.resultadoBuscaController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Busca"
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        if modelCD.count == 0 {
            let alert = UIAlertView(title: "Oops, deu ruim!",
                message: "Você não está conectado à rede de dados", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        let modelCD = VestibularManager.sharedInstance.findVestibular()
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
        {       return modelCD.count     }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaVestibulares", forIndexPath: indexPath) as! VestibularTableViewCell

        if self.resultadoBuscaController.active {
            cell.nomeLabel.text = resultadoBusca[indexPath.row].nome
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            var inscString = dateFormatter.stringFromDate(resultadoBusca[indexPath.row].dataFimInsc)
            cell.inscricaoLabel.text = inscString
//            var provaString = dateFormatter.stringFromDate(resultadoBusca[indexPath.row].dataProvas[0])
//            cell.provaLabel.text = provaString
            if resultadoBusca[indexPath.row].favorito == 1 {
                cell.favoritoIcone.image = UIImage(named: "favorito")
            } else {
                cell.favoritoIcone.image = UIImage(named: "naoFavorito")
            }
        }
        else {
            cell.nomeLabel.text = modelCD[indexPath.row].nome
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            var inscString = dateFormatter.stringFromDate(modelCD[indexPath.row].dataFimInsc)
            cell.inscricaoLabel.text = inscString
//            var provaString = dateFormatter.stringFromDate(modelCD[indexPath.row].dataProvas[0])
//            cell.provaLabel.text = provaString
            if modelCD[indexPath.row].favorito == 1 {
                cell.favoritoIcone.image = UIImage(named: "favorito")
            } else {
                cell.favoritoIcone.image = UIImage(named: "naoFavorito")
            }
        }

        return cell
    }
    
    //MARK: - CloudKitHelper Delegate
    
    func modelUpdated(){
    }
    
    func errorUpdating(error: NSError) {
    }
    
    // MARK: - Segue

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let destino = segue.destinationViewController as? DetailViewController {
            if self.resultadoBuscaController.active {
//                destino.vestibular = resultadoBusca[tableView.indexPathForSelectedRow()!.row]
            }
            else {
//                destino.vestibular = modelCD[tableView.indexPathForSelectedRow()!.row]
            }
        }
        self.resultadoBuscaController.active = false
    }
    
    // MARK: - Busca
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        self.resultadoBusca.removeAll(keepCapacity: false)
        var arrayNomes: NSMutableArray = []
        var arrayDetalhes: NSMutableArray = []
        
        for vestibular in modelCD
        {       arrayNomes.addObject(vestibular.nome)       }
        
        let predicado = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
        let array = (arrayNomes as NSArray).filteredArrayUsingPredicate(predicado)
        
        for vest in modelCD {
            for nome in array {
                if vest.nome == nome as! String {
                    self.resultadoBusca.append(vest)
                }
            }
        }
        
        self.tableView.reloadData()
    }

}
