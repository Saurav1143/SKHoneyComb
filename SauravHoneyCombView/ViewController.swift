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
        skHoneyCombView.delegate = self
    }

    //MARK:- Delegate Method...
    
    func didSelectHoneyComb(_ honeyCombObject: SKHoneyCombObject, _ honeyCombView: HoneyComb) {
        print(honeyCombObject.name)
        if (honeyCombView.backGroundImage.backgroundColor == .red){
            honeyCombView.backGroundImage.backgroundColor = .blue
            honeyCombView.title.text = "UnSelected"
        } else {
            honeyCombView.backGroundImage.backgroundColor = .red
            honeyCombView.title.text = "Selected"
        }
        
    }
    
}//Class

