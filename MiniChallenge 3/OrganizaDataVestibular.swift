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
    private var diasEProvas = [NSDate : [String]]()
    
    func configurar(vest : [VestibularCloud])
    {
        self.vestibulares = vest
        self.geraArrayDias()
        self.geraDicionario()
    }
    
    private func geraArrayDias()
    {
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
    
    private func geraDicionario()
    {
        for vestibular in self.vestibulares {
            for dia in vestibular.dataProvas {
                self.diasEProvas[dia] = []
            }
        }
        for vestibular in self.vestibulares {
            for dia in vestibular.dataProvas {
                var arrayNomes = self.diasEProvas[dia]
                arrayNomes!.append(vestibular.nome)
                self.diasEProvas[dia] = arrayNomes
            }
        }
        
    }
    
    func getNumeroSecoes() -> Int
    {       return self.dias.count      }
    
    func getNumeroLinhasSecao( secao: Int) -> Int
    {
        let dia = self.dias[secao]
        return self.diasEProvas[dia]!.count
    }
    
    func getDiaProva(secao : Int) -> NSDate
    {       return self.dias[secao]     }
    
    func getNomesVestibulares(secao : Int, linha : Int) -> String
    {
        let dia = self.dias[secao]
        return self.diasEProvas[dia]![linha]
    }
    
    func getVestibularByNome(nome: String) -> VestibularCloud? {
        for vestibular in vestibulares {
            if vestibular.nome == nome {
                return vestibular
            }
        }
        return nil
    }
}