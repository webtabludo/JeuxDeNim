//
//  BrainNim.swift
//  JeuxDeNim
//
//  Created by ludo iMac on 29/10/2018.
//  Copyright © 2018 ludo iMac. All rights reserved.
//

import UIKit

class Brain {
    //var viewController = ViewController()
    private var _unNombreDeLigne: Int
    private var _unNombreAlumettes: Int
    
    init(unNombreDeLigne: Int, unNombreAlumettes: Int) {
        _unNombreDeLigne = unNombreDeLigne
        _unNombreAlumettes = unNombreAlumettes
    }
    
    var unNombreDeLigne: Int {
        return _unNombreDeLigne
    }
    
    var unNombreAlumette: Int {
        return _unNombreAlumettes
    }
    
    
    //  Fonction création de la pyramide
    
    func creationPyramide (nbreDeLignes: Int) -> (chaineCaractere: String, tableaux: [[Character]]) {
        
        var listeArray :[[Character]] = []
        var pyramide = ""
        var pyramide2 = ""
        var array:[Character] = []
        
        for i in 0...(nbreDeLignes - 1) {
            
            pyramide.append(String(repeating: "l", count: (1 + (2 * i))) + "\n")
            pyramide2.append(String(repeating: "l", count: (1 + (2 * i))) + "\n")
            array = Array(pyramide2)
            
            listeArray.append(array)
            array.removeAll()
            pyramide2 = ""
        }
        
        return (pyramide, listeArray)
    }
    
    
    
    
    // Compte le nombre d'alumettes restantes dans une ligne
    func countAlumettesDansLigne (tab: [[Character]], nbrLigneSelect: Int) -> Int {
        
        let laLigne = tab[nbrLigneSelect - 1]
        
        var counter = 0
        for l in laLigne {
            if l == "l" {
                counter += 1
            } else {
                print("vide")
            }
        }
        return counter
    }
    
    
    // Fonction efface alumettes
    func effaceAlumettes(tab: [[Character]], nbrAlumetteSelect: Int, nbrLigneSelect: Int) -> [[Character]] {
        
        var listeArray: [[Character]] = tab
        var laLigne = tab[nbrLigneSelect - 1]
        var y = 1
        
        for (_, char) in laLigne.enumerated() {
            if char == "l" && y <= nbrAlumetteSelect {
                
                laLigne.remove(at: 0)
                y += 1
                
            } else {
                print("pas d'allumettes")
            }
        }
        listeArray.remove(at: nbrLigneSelect - 1)
        listeArray.insert(laLigne, at: nbrLigneSelect - 1)
        
        return listeArray
    }
    
    // Fonction develloper mon array de array de charactère
    
    func miseAPlat (tab: [[Character]]) -> [Character] {
        var newArr = [Character] ()
        for i in tab {
            for j in i {
                newArr.append(j)
            }
            
        }
        return newArr
    }
   
    
 

    
}
