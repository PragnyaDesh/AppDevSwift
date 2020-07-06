//
//  PhotoViewController.swift
//  CustomCamera
//
//  Created by Pragnya Deshpande on 03/03/20.
//  Copyright © 2020 PragnyaDesh. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    var TakenPhoto:UIImage?
    
    
    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let availableImage = TakenPhoto{
            ImageView.image = availableImage
        }
        
    }
    
    @IBAction func GoBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
