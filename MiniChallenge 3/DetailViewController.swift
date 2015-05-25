//
//  DetailViewController.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/18/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var vestibular : VestibularCloud!
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var inscInicioLabel: UILabel!
    @IBOutlet weak var inscFimLabel: UILabel!
    @IBOutlet weak var dataProvaLabel: UITextView!
    @IBOutlet weak var detalhesLabel: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = vestibular.nome
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        nomeLabel.text = vestibular.nome
        inscInicioLabel.text = "Inicio das inscrições: \(dateFormatter.stringFromDate(vestibular.dataInicioInsc))"
        inscFimLabel.text = "Fim das inscrições: \(dateFormatter.stringFromDate(vestibular.dataFimInsc))"
        
        var datas = "Data das provas:\n"
        for data in vestibular.dataProvas {
            datas += "\(dateFormatter.stringFromDate(data)) \n"
        }
        dataProvaLabel.text = datas
        
        detalhesLabel.text = vestibular.detalhes
    }
    
    override func viewWillDisappear(animated: Bool) {
        nomeLabel.text = ""
        inscInicioLabel.text = ""
        inscFimLabel.text = ""
        dataProvaLabel.text = ""
        detalhesLabel.text = ""
    }

}
