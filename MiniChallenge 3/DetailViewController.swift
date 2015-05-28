//
//  DetailViewController.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/18/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var faculdade : FaculdadeCloud!
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var inscInicioLabel: UILabel!
    @IBOutlet weak var inscFimLabel: UILabel!
    @IBOutlet weak var dataProvaLabel: UITextView!
    @IBOutlet weak var detalhesLabel: UITextView!
    @IBOutlet weak var favoritoIcone: UIImageView!
    
    override func viewDidLoad()
    {       super.viewDidLoad()     }

    override func viewWillAppear(animated: Bool)
    {
        self.navigationItem.title = faculdade.nome
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        nomeLabel.text = faculdade.nome
        inscInicioLabel.text = "Inicio das inscrições: \(dateFormatter.stringFromDate(faculdade.vestibular!.dataInicioInsc))"
        inscFimLabel.text = "Fim das inscrições: \(dateFormatter.stringFromDate(faculdade.vestibular!.dataFimInsc))"
        
        var datas = "Data das provas:\n"
        for data in faculdade.vestibular!.dataProvas
        {       datas += "\(dateFormatter.stringFromDate(data)) \n"     }
        
        dataProvaLabel.text = datas
        
        detalhesLabel.text = faculdade.vestibular!.detalhes
        
        if faculdade.favorito == 1 {
            favoritoIcone.image = UIImage(named: "favoritosIconeSelecionado")
        }
        else {
           favoritoIcone.image = UIImage(named: "favoritosIcone")
        }
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        nomeLabel.text = ""
        inscInicioLabel.text = ""
        inscFimLabel.text = ""
        dataProvaLabel.text = ""
        detalhesLabel.text = ""
    }

}
