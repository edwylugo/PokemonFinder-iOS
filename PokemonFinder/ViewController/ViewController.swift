//
//  ViewController.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 29/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func btnLetsGo(_ sender: UIButton) {
        performSegue(withIdentifier: "segueName", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
   


}

