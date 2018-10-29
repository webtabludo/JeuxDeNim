//
//  ViewController.swift
//  JeuxDeNim
//
//  Created by ludo iMac on 28/10/2018.
//  Copyright © 2018 ludo iMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var zoneTextView: UITextView!
    @IBOutlet weak var lignTextField: UITextField!
    @IBOutlet weak var nbreAllumetteTextField: UITextField!
    
    var coordX: Int = 1
    var coordY: Int = 32
    var lignes: Int = 0
    var pyramide = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...(lignes - 1) {
        
        pyramide.append(String(repeating: " ", count: coordY - i) + String(repeating: "l", count: coordX + (2 * i)) + String(repeating: " ", count: coordY - i) + "\n")
        zoneTextView.text = pyramide
            
            // compte le nombre d'allumette
//        let test = pyramide.components(separatedBy: "l")
//        print(pyramide, test.count-1)
        }
        
        
     
    }

    @IBAction func validerAction(_ sender: UIButton) {
        
        // Trouver la ligne sélectioné ( 65 caractères par lignes)
        // si ligne 3 alors (3-1) * 65 va au début de la ligne
        if let nbrLigneSelect = Int(lignTextField.text!) {
            if let nbreAluSelect = Int(nbreAllumetteTextField.text!) {
            
            // Il faut vérifier qu'il reste assez d'alumettes
            let startLigne = pyramide.index(pyramide.startIndex, offsetBy: ((nbrLigneSelect-1) * 65) + (65 - ((nbrLigneSelect-1) * 2) + 1)/2)
            let endligne = pyramide.index(pyramide.startIndex, offsetBy: nbreAluSelect + ((nbrLigneSelect-1) * 65) + (65 - ((nbrLigneSelect-1) * 2) + 1)/2)
            let laLigne = pyramide[startLigne...endligne]
            let lRestant = laLigne.components(separatedBy: "l")
            print(lRestant.count)
            
                                        if nbreAluSelect <= lRestant.count {
            
                                                    // Revoir la formule mais la solution est la !
                                                    for i in 1...nbreAluSelect {
                
                let start = pyramide.index(pyramide.startIndex, offsetBy: ((nbrLigneSelect-1) * 65) + (65 - ((nbrLigneSelect-1) * 2) - 1)/2)
                let end = pyramide.index(pyramide.startIndex, offsetBy: i + ((nbrLigneSelect-1) * 65) + (65 - ((nbrLigneSelect-1) * 2) - 1)/2)
                
            pyramide.replaceSubrange(start...end, with: " ")
            //print(pyramide)
            zoneTextView.text = pyramide
            
                                                                                }
        // Faire jouer l'ordinateur
                                        } else {
                                            messageLabel.text = "Il ne reste pas assez d'alumettes"
                }
                                                                            }
                                                                }
                                                            }

}
