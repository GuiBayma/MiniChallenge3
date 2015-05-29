//
//  DetailViewController.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/18/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let model = CloudKitHelper.sharedInstance()
    var vestibular : VestibularCloud!
    var faculdade : FaculdadeCloud!
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var inscInicioLabel: UILabel!
    @IBOutlet weak var inscFimLabel: UILabel!
    @IBOutlet weak var dataProvaLabel: UITextView!
    @IBOutlet weak var detalhesLabel: UITextView!
    @IBOutlet weak var botaoFavorito: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        botaoFavorito.titleLabel?.text = ""
    }

    override func viewWillAppear(animated: Bool)
    {
        self.navigationItem.title = vestibular.nome
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if vestibular.favorito == 1 {
            nomeLabel.text = "\(vestibular.nome) ★"
            botaoFavorito.imageView?.image = UIImage(named: "favorito")
        } else {
            nomeLabel.text = vestibular.nome
            botaoFavorito.imageView?.image = UIImage(named: "naoFavorito")
        }
        inscInicioLabel.text = "Inicio das inscrições: \(dateFormatter.stringFromDate(vestibular.dataInicioInsc))"
        inscFimLabel.text = "Fim das inscrições: \(dateFormatter.stringFromDate(vestibular.dataFimInsc))"
        
        var datas = "Data da(s) prova(s):\n"
        for data in vestibular.dataProvas
        {       datas += "\(dateFormatter.stringFromDate(data)) \n"     }
        
        dataProvaLabel.text = datas
        
        detalhesLabel.text = vestibular.detalhes
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        nomeLabel.text = ""
        inscInicioLabel.text = ""
        inscFimLabel.text = ""
        dataProvaLabel.text = ""
        detalhesLabel.text = ""
    }
    
    func salvarFavorito() {
        if vestibular.favorito == 1 {
            nomeLabel.text = vestibular.nome
            botaoFavorito.imageView?.image = UIImage(named: "naoFavorito")
            
            let vest = VestibularManager.sharedInstance.findVestibularByName(vestibular.nome)
            VestibularManager.sharedInstance.deleteVestibular(vest)
        } else {
            nomeLabel.text = "\(vestibular.nome) ★"
            botaoFavorito.imageView?.image = UIImage(named: "favorito")
            
            // CoreData
            var vestibularCD = VestibularManager.sharedInstance.newVestibular()
            vestibularCD.nome = vestibular.nome
            vestibularCD.detalhes = vestibular.detalhes
            vestibularCD.dataInicioInsc = vestibular.dataInicioInsc
            vestibularCD.dataFimInsc = vestibular.dataFimInsc
            vestibularCD.dataGabarito = vestibular.dataGabarito
            vestibularCD.dataChamada = vestibular.dataChamada as [NSDate]?
            vestibularCD.dataProvas = vestibular.dataProvas as [NSDate]
            VestibularManager.sharedInstance.saveVestibular()
        }
    }
    
    @IBAction func alterarFavorito(sender: UIButton) {
        salvarFavorito()
    }

}
