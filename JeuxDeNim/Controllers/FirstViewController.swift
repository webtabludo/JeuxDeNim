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
    var choixNbreLigne = LogiqueAffichage()
    var resultX = 0
    var resultY = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func validerAction(_ sender: UIButton) {

        if let choixInt = Int(nbrLigneTextField.text!) {
             resultX = choixNbreLigne.logiqueAffichageX(nombreDeLigne: choixInt)
             resultY = choixNbreLigne.logiqueAffichageY(nombreDeLigne: choixInt)
            performSegue(withIdentifier: "FirstSegue", sender: nil)
   
        } else {
            msgErrorLabel.text = "Veuillez rentrer un nombre de ligne valide !" }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FirstSegue" {
            let destVc = segue.destination as! ViewController
            destVc.coordX = resultX
            destVc.coordY = resultY
        }
    }
 
}
