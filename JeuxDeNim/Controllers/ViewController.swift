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
    // Fonction de réactualisation de la pyramide
    
    func réactualisationPyramide (tab: [[Character]]) {
        let newArr = brain.miseAPlat(tab: listeArray)
        pyramide = String(newArr)
        zoneTextView.text = pyramide
    }
    
     func aiPlay(tab: [[Character]], choixAllMax: Int)  {
        
       listeArray = brainIA.choixIA(tab: listeArray, choixAllMax: AllMax)
        
        
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
                
                
                if brain.countAlumettesDansLigne(tab: listeArray, nbrLigneSelect: nbrLigneSelect) >=  nbreAluSelect && nbreAluSelect <= AllMax {
                    listeArray = brain.effaceAlumettes(tab: listeArray, nbrAlumetteSelect: nbreAluSelect,nbrLigneSelect: nbrLigneSelect)
                    réactualisationPyramide(tab: listeArray)

                    var somme = brainIA.totalAll(tab: listeArray)
                    
                       if somme == 1 {
                        print("vous avez gagné")
                        alerte(winner: "vous avez gagné")
                    } else {
                    
                    messageLabel.text = "A moi de jouer ..."
                    

                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        self.aiPlay(tab: self.listeArray, choixAllMax: self.AllMax)
                        self.réactualisationPyramide(tab: self.listeArray)

                        self.messageLabel.text = "A vous de jouer ..."
                        self.lignTextField.text = ""
                        self.nbreAllumetteTextField.text = ""
                        somme = self.brainIA.totalAll(tab: self.listeArray)
                        print("somme:\(somme)")
                        if somme == 1 {
                            print("j'ai gagné")
                            self.alerte(winner: "j'ai gagné")
                        }
                    }
                       
                    }
                   
                } else {
                    messageLabel.text = "Il ne reste pas assez d'alumettes ou le nombre max est dépassé"
                }
            }
        }
       
            
        
    }
    
    

    // Fonction popup Alert fin de jeu
    
    func alerte(winner: String) {
        
        
        
        let alert = UIAlertController(title: "Game Over", message: winner, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }



}

