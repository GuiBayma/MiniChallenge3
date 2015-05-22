//
//  OrganizaDataVestibular.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/21/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import Foundation
import CloudKit

class OrganizaDataVestibular {

    private var dias = [NSDate]()
    private var vestibulares = [VestibularCloud]()
    private var diasEProvas = [String : [String]]()
    
    func configurar(vest : [VestibularCloud]) {
        self.vestibulares = vest
        self.geraArrayDias()
        self.geraDicionario()
    }
    
    private func geraArrayDias() {
        var diaSet = Set(self.dias)
        for vest in vestibulares {
            for dia in vest.dataProvas {
                if !diaSet.contains(dia) {
                    diaSet.insert(dia)
                }
            }
        }
        self.dias = Array(diaSet)
        self.dias.sort() { $0.compare( $1 ) == NSComparisonResult.OrderedAscending }
    }
    
    private func geraDicionario() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        for vestibular in self.vestibulares {
            for dia in vestibular.dataProvas {
                let stringDia = dateFormatter.stringFromDate(dia)
                self.diasEProvas[stringDia]? = []
            }
        }
        for vestibular in self.vestibulares {
            for dia in vestibular.dataProvas {
                let stringDia = dateFormatter.stringFromDate(dia)
                self.diasEProvas[stringDia]?.append(vestibular.nome)
            }
        }
        
    }
    
    func getNumeroSecoes() -> Int{
        return self.dias.count
    }
    
    func getNumeroLinhasSecao( secao: Int) -> Int {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        let dia = self.dias[secao]
        let stringDia = dateFormatter.stringFromDate(dia)
        return self.diasEProvas[stringDia]!.count
    }
    
    func getDiaProva(secao : Int) -> NSDate {
        return self.dias[secao]
    }
    
    func getNomesFaculdades(secao : Int, linha : Int) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        let dia = self.dias[secao]
        let stringDia = dateFormatter.stringFromDate(dia)
        return self.diasEProvas[stringDia]![linha]
    }
}