//
//  ViewController.swift
//  JeuxDeNim
//
//  Created by ludo iMac on 28/10/2018.
//  Copyright © 2018 ludo iMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var zoneTextView: UILabel!
    @IBOutlet weak var lignTextField: UITextField!
    @IBOutlet weak var nbreAllumetteTextField: UITextField!
    
    var AllMax:Int = 0
    var lignes: Int = 0
    var pyramide = ""
    var brain = Brain(unNombreDeLigne: 0, unNombreAlumettes: 0)
    var listeArray:[[Character]] = []
    var brainIA = BrainIA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lignTextField.delegate = self
        nbreAllumetteTextField.delegate = self
        
        pyramide = brain.creationPyramide(nbreDeLignes: lignes).chaineCaractere
        listeArray = brain.creationPyramide(nbreDeLignes: lignes).tableaux
        zoneTextView.text = pyramide
        
        

    }
    
     func aiPlay(tab: [[Character]], choixAllMax: Int)  {
        
       listeArray = brainIA.choixIA(tab: listeArray, choixAllMax: AllMax)
        
        let newArr = brain.miseAPlat(tab: listeArray)
        pyramide = String(newArr)
        zoneTextView.text = pyramide
    }
    
    
    // Faire disparaitre le clavier après appui sur return
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // Faire disparaitre le clavier après appui en dehors de la zone de textField
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.zoneTextView.endEditing(true)
    }
    
    @IBAction func validerAction(_ sender: UIButton) {
        
        messageLabel.text = "Choisir une ligne et un nombre d'alumette"
        
        if let nbrLigneSelect = Int(lignTextField.text!) {
            if let nbreAluSelect = Int(nbreAllumetteTextField.text!) {
                
                // Il faut vérifier qu'il reste assez d'alumettes
                
                if brain.countAlumettesDansLigne(tab: listeArray, nbrLigneSelect: nbrLigneSelect) >=  nbreAluSelect && nbreAluSelect <= AllMax {
                    listeArray = brain.effaceAlumettes(tab: listeArray, nbrAlumetteSelect: nbreAluSelect,nbrLigneSelect: nbrLigneSelect)
                    messageLabel.text = "A moi de jouer ..."

                    let newArr = brain.miseAPlat(tab: listeArray)
                   pyramide = String(newArr)
                    zoneTextView.text = pyramide
                    
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

                        self.aiPlay(tab: self.listeArray, choixAllMax: self.AllMax)
                        self.messageLabel.text = "A vous de jouer ..."

                    }
                    
                   
                } else {
                    messageLabel.text = "Il ne reste pas assez d'alumettes ou le nombre max est dépassé"
                }
            }
        }
    }
    
     // Fonction retour à la first view
//    func reload() {
//        let viewControllerYouWantToPresent = storyboard?.instantiateViewController(withIdentifier: "FirstViewController")
//        self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
//    }
}
