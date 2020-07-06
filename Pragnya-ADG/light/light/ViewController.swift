//
//  ViewController.swift
//  light
//
//  Created by Pragnya Deshpande on 19/02/20.
//  Copyright © 2020 PragnyaDesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var LightOn = true
    
    
    @IBOutlet weak var lightButton: UIButton!
    
    override func viewDidLoad() {
           super.viewDidLoad()
        UpdateUI()
        // Do any additional setup after loading the view.
    }

    @IBAction func ButtonPressed(_ sender: AnyObject) {
        LightOn = !LightOn
        UpdateUI()
    }
    
    func UpdateUI()
    {
        if LightOn {
            view.backgroundColor = .white
            lightButton.setTitle("Off", for: .normal)
        }else{
            view.backgroundColor = .black
            lightButton.setTitle("On", for: .normal)
        }
    }
}

