//
//  BrainIA.swift
//  JeuxDeNim
//
//  Created by ludo iMac on 31/10/2018.
//  Copyright © 2018 ludo iMac. All rights reserved.
//

import UIKit

class BrainIA {
    
    
    var brain = Brain(unNombreDeLigne: 0, unNombreAlumettes: 0)
    
    // Transforme chaque quantité d'allumettes par ligne en binaire
    func transformationLigneBinaire (count:Int) -> [Int]{
        var str = count
        var tab:[Int] = []
        
        while str > 0 {
            
            if str % 2 == 0 {
                str = str / 2
                tab.append(0)
            } else {
                str = str / 2
                tab.append(1)
            }
        }
        return tab
    }
    
    // Fonction qui renvoie un tableau avec la quantité d'allumettes de chaque ligne
    func countLignes (tab: [[Character]]) -> [Int] {
        
        var result:[Int] = []
        var laLigne:[Character] = []
        
        for index in 1...tab.count {
            laLigne = tab[index - 1]
            result.append(laLigne.count)
        }
        
        return result
    }
    

    
    
    
    // Tester chaque ligne pour savoir si la quantité d'allumette transformée en binaire est pair ou impair
    
    func parité (num: Int) -> Bool {
        
        var isPair = false
        var tabBinaire:[Int] = []
        
        tabBinaire = transformationLigneBinaire(count: num)
        print(transformationLigneBinaire(count: num))
        
        var n = 0
        for i in tabBinaire {
            n += i
            if n % 2 == 0 {
                isPair = true
            } else {
                isPair = false
            }
        }
        return isPair
    }
    
    func removeAi (tab:[Int], choixAllMax: Int) {
        
        
        
    }
    
    func choixIA (tab: [[Character]], choixAllMax: Int) -> [[Character]] {
        
        let tabQuant = countLignes(tab: tab)
        print("tabQuant:\(tabQuant)")
        
        var listeArray: [[Character]] = tab
        var y = 1
        for (i,chiffre) in tabQuant.enumerated() {
            let isPair = parité(num: chiffre)
            print("isPair:\(isPair)")
            if isPair == false {
                var laLigne = tab[i]
                print("laLigne:\(laLigne)")
                for (index, char) in laLigne.enumerated() {
                    if char == "l" && y <= choixAllMax {
                        laLigne.remove(at: index)
                        print("laligneapresremove:\(laLigne)")
                        y += 1
                        print("y:\(y)")
                        
                    }
                    
                    listeArray.remove(at: i)
                    listeArray.insert(laLigne, at: i)
                }
                
                
            } else {
                print("ça merde !!!!!")
                
            }
            
        }
        
        return listeArray
    }
    
    
}




