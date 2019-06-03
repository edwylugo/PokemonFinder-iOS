//
//  RegisterSelectionPokemonViewController.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 29/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import UIKit




class RegisterSelectionPokemonViewController: UIViewController {
    
    @IBOutlet weak var textTitleType: UILabel!
    @IBOutlet weak var textTitleName: UILabel!
    @IBOutlet weak var ivType: UIImageView!
    var name = String()
    var type = [Types]()
    var setNameTitle: String = ""
    var validTypePokemon: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //APIManager.shared.fetchTypesFromApi()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        initializeViews()
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func initializeViews() {
        textTitleName.text = "Hello, \(name)!"
        print("\(type.count)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "segueSelectType") {
            let secondController  = segue.destination as? ListTypesViewController
            secondController?.testValue = setNameTitle
            secondController?.validType = validTypePokemon
            secondController?.delegate = self
        }
        
        if (segue.identifier == "segueHome") {
            
            let view = segue.destination as! UINavigationController
            let vc = view.viewControllers[0] as! HomeViewController
            vc.typeSelect = "\(setNameTitle)"
            print("homeController: \(setNameTitle)")
            
        }
        
    }
    
    func checkSelectType () {
        
        if validTypePokemon != true {
            
            let alertController = UIAlertController(title: "Pokemon Finder",
                                                    message: "Please: \n\n* Select your favorite pokemon type",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            performSegue(withIdentifier: "segueHome", sender: nil)
        }
        
    }
    
    
    @IBAction func btnSelectType(_ sender: UIButton) {
        performSegue(withIdentifier: "segueSelectType", sender: nil)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        checkSelectType ()
    }
    
}

extension RegisterSelectionPokemonViewController: ListTypesViewControllerDelegate {
    func update(value: String, url: String, validType: Bool) {
        
        setNameTitle = value
        validTypePokemon = validType
        self.textTitleType.text = setNameTitle
        print("setNameTitle: \(setNameTitle)")
    
        if let url = URL(string: url) {
            self.ivType.af_setImage(withURL: url)
        }
        
    }
    
    
    
    
}





