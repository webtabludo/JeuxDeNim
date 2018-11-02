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
            
            result.append(laLigne.count - 1)
        }
        
        return result
    }
    
    
    
    
    
    // Tester chaque ligne pour savoir si la quantité d'allumette transformée en binaire est pair ou impair
    
    func parité (num: Int) -> Bool {
        
        var isPair = true
        var tabBinaire:[Int] = []
        
        tabBinaire = transformationLigneBinaire(count: num)
        
        
        var n = 0
        for i in tabBinaire {
            n += i
            if n == 0 {
                isPair = true
            }
            else if n % 2 == 0 {
                isPair = true
            } else {
                isPair = false
            }
        }
        return isPair
    }
    
    
    
    
    
    // Fonction efface alumettes
    func effaceAlumettes(tab: [[Character]], choixAllMax: Int, indexDeLigne: Int, nbrAllLigne: Int) -> [[Character]] {
        
        var listeArray: [[Character]] = tab
        var laLigne = tab[indexDeLigne]
        var y = 1
        var x = 1
        
        for (_, char) in laLigne.enumerated() {
            if char == "l" && y <= choixAllMax && x <= nbrAllLigne {
                laLigne.remove(at: 0)
                y += 1
                x += 1
               
            } else {
                  print("plus d'allumettes pour IA")
            }
        }
        listeArray.remove(at: indexDeLigne)
        listeArray.insert(laLigne, at: indexDeLigne)
        
        return listeArray
    }
    
    
    
    
    
    func choixIA (tab: [[Character]], choixAllMax: Int) -> [[Character]] {
        
        let tabQuant = countLignes(tab: tab)
        
        var listeArray: [[Character]] = tab
        var y = 0
        var x = 1
        var isPair = false
        for (i,chiffre) in tabQuant.enumerated() {
            
            isPair = parité(num: chiffre)
          
            
            if isPair == false && y < 1 {
                listeArray = effaceAlumettes(tab: tab, choixAllMax: choixAllMax, indexDeLigne: i, nbrAllLigne: chiffre)
                y += 1
                x += 1
               
                
            } else if (isPair == true && x < tabQuant.count) {
              
                x += 1
                
            }
            
        }
        
        if listeArray == tab {
            for (i,chiffre) in tabQuant.enumerated() {
                listeArray = effaceAlumettes(tab: tab, choixAllMax: 1, indexDeLigne: i, nbrAllLigne: chiffre)
                
            }
            
        }
        return listeArray
    }

}


