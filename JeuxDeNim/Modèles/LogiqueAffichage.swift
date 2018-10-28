//
//  LogiqueAffichage.swift
//  JeuxDeNim
//
//  Created by ludo iMac on 28/10/2018.
//  Copyright © 2018 ludo iMac. All rights reserved.
//

import UIKit

class LogiqueAffichage {
    
    func logiqueAffichageX (nombreDeLigne:Int) -> Int {
        
            let x = 1 + ( nombreDeLigne - 1) * 2
            return x
         }
    
    func logiqueAffichageY (nombreDeLigne:Int) -> Int {
        
            let y = 29 - nombreDeLigne
           return y
    }
}
