//
//  VestibularTableViewCell.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/20/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit

class VestibularTableViewCell: UITableViewCell {

    override func awakeFromNib()
    {       super.awakeFromNib()        }

    override func setSelected(selected: Bool, animated: Bool)
    {       super.setSelected(selected, animated: animated)     }
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var inscricaoLabel: UILabel!
    @IBOutlet weak var provaLabel: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var favoritoIcone: UIImageView!
    
}
