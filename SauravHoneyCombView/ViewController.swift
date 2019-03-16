//
//  ViewController.swift
//  SauravHoneyCombView
//
//  Created by Sourav on 2/20/19.
//  Copyright © 2019 Saurav. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController,HoneyCombViewDelegate{

      //MARK:- @IBoutlets:---
     @IBOutlet weak var skHoneyCombView: SKHoneyCombView!
     //MARK:- Variables.....
     var honeycombObjectsArray: [SKHoneyCombObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createHoneyComb()
    }

    func createHoneyComb() {
        for i in 0..<24 {
            let honeycombObject = SKHoneyCombObject()
            honeycombObject.name = "This Is HoneyComb Object \(i)"
            self.honeycombObjectsArray.append(honeycombObject)
        }
        self.skHoneyCombView.honeyCombObjectsArr = self.honeycombObjectsArray
    }

    //MARK:- Delegate Method...
    
    func didSelectHoneyComb(_ honeyCombObject: SKHoneyCombObject) {
        print(honeyCombObject.name)
    }
    
}//Class

