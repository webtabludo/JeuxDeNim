//
//  FirstViewController.swift
//  JeuxDeNim
//
//  Created by ludo iMac on 28/10/2018.
//  Copyright © 2018 ludo iMac. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var msgLigne: UILabel!
    @IBOutlet weak var nbrLigneTextField: UITextField!
    @IBOutlet weak var msgAllMax: UILabel!
    @IBOutlet weak var nbrAllMaxTextField: UITextField!
    
    var nbrLigne = 0
    var nbrAllMax = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        nbrLigneTextField.delegate = self
        nbrAllMaxTextField.delegate = self
    }
    
    
    func testNbrLigne (nbreLigne: Int) {
        nbrLigne = nbreLigne
        if nbreLigne <= 14 {
            //performSegue(withIdentifier: "FirstSegue", sender: nil)
        } else {
            msgLigne.text = "14 lignes maximum !"
            msgLigne.textColor = UIColor.red
        }
    }
    
    
    func testAllMax (nbreAllMax: Int) {
        nbrAllMax = nbreAllMax
        if nbreAllMax <= 27 {
            performSegue(withIdentifier: "FirstSegue", sender: nil)
        } else {
            msgAllMax.text = "Veuillez rentrer un nombre de ligne valide !"
            msgAllMax.textColor = UIColor.red
        }
    }
    
    
    // Faire disparaitre le clavier après appui sur return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // Faire disparaitre le clavier après appui en dehors de la zone de textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func validerAction(_ sender: UIButton) {
        
        
        // Test si un nombre de ligne de type Int est rentré
        if let choixInt = Int(nbrLigneTextField.text!) {
            
            if let choixAll = Int(nbrAllMaxTextField.text!) {
                testNbrLigne(nbreLigne: choixInt)
                testAllMax(nbreAllMax: choixAll)
                
            } else {
                msgAllMax.text = "Veuillez rentrer un nombre d'allumette valide !"
                msgAllMax.textColor = UIColor.red
                
            }
            
        } else {
            msgLigne.text = "Veuillez rentrer un nombre de ligne valide !"
            msgLigne.textColor = UIColor.red
            
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FirstSegue" {
            let destVc = segue.destination as! ViewController
            // print("nombre d'allumettes max3:\(nbrAllMax)")
            // print("nombre de linge3:\(nbrLigne)")
            
            destVc.lignes = nbrLigne
            destVc.AllMax = nbrAllMax
        }
    }
}
