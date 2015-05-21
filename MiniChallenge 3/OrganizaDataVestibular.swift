//
//  OrganizaDataVestibular.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/21/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import Foundation

class OrganizaDataVestibular {

    var dias : [NSDate]!
    let vestibulares = [VestibularCloud]()
    
    init() {
        self.dias = []
    }
    
    func numeroDeSecoes(vestibulares: [VestibularCloud]) -> Int {
        var diaSet = Set(self.dias)
        
        for vest in vestibulares {
            for dia in vest.dataProvas {
                if !diaSet.contains(dia) {
                    diaSet.insert(dia)
                }
            }
        }
        
        return diaSet.count
    }
    
    func numeroDeCelulasPorSection(section: Int, vestibulares: [VestibularCloud]) -> Int {
        var arrayDias = Array(self.dias)
        arrayDias.sort { $0.compare( $1 ) == NSComparisonResult.OrderedAscending }
        var numeroProvas = 0
        
        for vestibular in vestibulares {
            for data in vestibular.dataProvas {
                if arrayDias[section].compare(data) == NSComparisonResult.OrderedSame {
                    numeroProvas++
                }
            }
        }
        
        return numeroProvas
    }
    
}