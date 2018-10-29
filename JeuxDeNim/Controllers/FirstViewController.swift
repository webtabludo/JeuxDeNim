//
//  FirstViewController.swift
//  JeuxDeNim
//
//  Created by ludo iMac on 28/10/2018.
//  Copyright © 2018 ludo iMac. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var msgErrorLabel: UILabel!
    @IBOutlet weak var nbrLigneTextField: UITextField!
    
    var nbrLigne = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func validerAction(_ sender: UIButton) {

        
        // Test si un nombre de ligne de type Int est rentré
        if let choixInt = Int(nbrLigneTextField.text!) {
             nbrLigne = choixInt
            // Test si ce nombre est bien inférieur à 200 alumettes
            if choixInt <= 14 {
                performSegue(withIdentifier: "FirstSegue", sender: nil)
            } else {
                msgErrorLabel.text = "14 lignes maximum !"
            }
            
        } else {
            msgErrorLabel.text = "Veuillez rentrer un nombre de ligne valide !" }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FirstSegue" {
            let destVc = segue.destination as! ViewController

            destVc.lignes = nbrLigne
        }
    }
 
}
