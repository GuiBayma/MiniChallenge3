//
//  FavoritosTableViewCell.swift
//  MiniChallenge 3
//
//  Created by Ana Elisa Pessoa Aguiar on 26/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit

class FavoritosTableViewCell: UITableViewCell {
    
    override func awakeFromNib()
    {       super.awakeFromNib()        }
    
    override func setSelected(selected: Bool, animated: Bool)
    {       super.setSelected(selected, animated: animated)     }
    
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var imagemFaculdade: UIImageView!
    
}
