//
//  RegisterNameViewController.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 29/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import UIKit

class RegisterNameViewController: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    
    @IBAction func imageNext(_ sender: UIButton) {
        checkEditText ()
    }
    
    
    var pokemons = [Pokemons]()
    var types = [Types]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as! RegisterSelectionPokemonViewController
            destination.name = tfName.text!
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //Fecha teclado dos campos teexfields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfName.resignFirstResponder()
    }
    
    func checkEditText () {
        
        if tfName.text == "" {
            
            let alertController = UIAlertController(title: "Pokemon Finder",
                                                    message: "Please: \n\n* Enter your name",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
           
        } else {
            performSegue(withIdentifier: "segueType", sender: nil)
        }
        
    }
    

}
