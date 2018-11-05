//
//  ViewController.swift
//  JeuxDeNim
//
//  Created by ludo iMac on 28/10/2018.
//  Copyright © 2018 ludo iMac. All rights reserved.
//


// Faire apparaitre le text en fondu
extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}






import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var zoneTextView: UILabel!
    @IBOutlet weak var lignTextField: UITextField!
    @IBOutlet weak var nbreAllumetteTextField: UITextField!
    @IBOutlet weak var numerotationLabel: UILabel!
    
    var AllMax:Int = 0
    var lignes: Int = 0
    var pyramide = ""
    var brain = Brain(unNombreDeLigne: 0, unNombreAlumettes: 0)
    var listeArray:[[Character]] = []
    var brainIA = BrainIA()
    var listeArrayLate:[[Character]] = []
    var pyramideLate = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lignTextField.delegate = self
        nbreAllumetteTextField.delegate = self
        
        listeArrayLate = listeArray
        
        pyramide = brain.creationPyramide(nbreDeLignes: lignes).chaineCaractere
        listeArray = brain.creationPyramide(nbreDeLignes: lignes).tableaux
        zoneTextView.text = pyramide
        numerotationLabel.text = numérotation(nbreDeLigne: lignes)
    }
 
    
    
    // Fonction création de la numérotation
    
    func numérotation(nbreDeLigne: Int) -> String {
        var str = ""
        for i in 1...nbreDeLigne {
            str.append(String(i) + "\n")
        }
        return str
    }

    // Fonction pour trouver les différences entre deux string
    func findDifference (str1: String, str2: String) -> String {
        
        let strOldArray = str1.components(separatedBy: "\n")
        print("strOldArray:\(strOldArray)")
        let strNewArray = str2.components(separatedBy: "\n")
        print("strNewArray:\(strNewArray)")
        
        var newWorld = ""
        var newArray:[String] = []
        
        
        
        for (val1, val2) in zip(strOldArray, strNewArray) {
            
            if val1 == val2 {
                
                newArray.append(val1)
                
            } else {
                
                let x = val1.count
                let y = val2.count
               
                let ajout = String(repeating: "X", count: (x - y))
                newArray.append(val2 + ajout)
            }
            
        }
        
        newWorld = newArray.joined(separator: "\n")
        print("newWorld:\(newWorld)")
        return newWorld
    }

    
    // Fonction de réactualisation de la pyramide
    
    func réactualisationPyramide (tab: [[Character]]) {
       
        let newArrLate = brain.miseAPlat(tab: listeArrayLate)
        print("newArrLate:\(newArrLate)")
        pyramideLate = String(newArrLate)
     

        let newArr = brain.miseAPlat(tab: listeArray)
        pyramide = String(newArr)
        
        print("pyrlate:\(pyramideLate)")
        print("pyra:\(pyramide)")
        let pyramideTempo = findDifference(str1: pyramideLate, str2: pyramide)
        zoneTextView.fadeTransition(0.4)
        zoneTextView.text = pyramideTempo
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.zoneTextView.fadeTransition(0.4)
            self.zoneTextView.text = self.pyramide
            
        }

        
      
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

        listeArrayLate = listeArray

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

                        listeArrayLate = listeArray

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        
                        self.aiPlay(tab: self.listeArray, choixAllMax: self.AllMax)
                        self.réactualisationPyramide(tab: self.listeArray)
                        self.messageLabel.text = "A vous de jouer ..."
                        self.lignTextField.text = ""
                        self.nbreAllumetteTextField.text = ""
                        somme = self.brainIA.totalAll(tab: self.listeArray)
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

