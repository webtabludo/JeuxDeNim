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
    
    var AllMax:Int = 0
    var lignes: Int = 0
    var pyramide = ""
    var brain = Brain(unNombreDeLigne: 0, unNombreAlumettes: 0)
    var listeArray:[[Character]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pyramide = brain.creationPyramide(nbreDeLignes: lignes).chaineCaractere
        listeArray = brain.creationPyramide(nbreDeLignes: lignes).tableaux
        zoneTextView.text = pyramide
        print(listeArray)
        
    }
    
    @IBAction func validerAction(_ sender: UIButton) {
        
        messageLabel.text = "Choisir une ligne et un nombre d'alumette"
        
        if let nbrLigneSelect = Int(lignTextField.text!) {
            if let nbreAluSelect = Int(nbreAllumetteTextField.text!) {
                
                // Il faut vérifier qu'il reste assez d'alumettes
                
                if brain.countAlumettesDansLigne(tab: listeArray, nbrLigneSelect: nbrLigneSelect) >=  nbreAluSelect {
                   listeArray = brain.effaceAlumettes(tab: listeArray, nbrAlumetteSelect: nbreAluSelect, nbrLigneSelect: nbrLigneSelect)
                    let newArr = brain.miseAPlat(tab: listeArray)
                   pyramide = String(newArr)
                    zoneTextView.text = pyramide
                    
                    // Faire jouer l'ordinateur
                } else {
                    messageLabel.text = "Il ne reste pas assez d'alumettes"
                }
            }
        }
    }
    
}
