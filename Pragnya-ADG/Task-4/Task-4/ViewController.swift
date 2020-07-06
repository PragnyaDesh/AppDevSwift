//
//  ViewController.swift
//  Task-4
//
//  Created by Pragnya Deshpande on 08/02/20.
//  Copyright © 2020 PragnyaDesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
          func even (n:Int) {
               for n in 1...40
              {
                if n%2==0
                {print(n)}
                
               }
            }
    
            func strlen(st1:String, st2:String)
            {
                let length1=st1.count
                let length2=st2.count
                if length1>length2
                {print(st1)}
                else
                {print(st2)}
                
            }
                
            
            func swapCharacters(input: [String], index: Int) {
                    var characters = Array(input)
                let charlen=characters.count
                if charlen>index
                {characters.swapAt(0, index)
                 print(characters)
                }
            }

 override func viewDidLoad() {
 super.viewDidLoad()
    
    do {even(n:40)
      
        strlen(st1:"pragnya deshpande", st2:"nishika agarwal")
      
        let input: [String] = ["Pragnya", "Nishika", "Hemangi"]
        print(swapCharacters(input: input, index:2))
        }

}



}

