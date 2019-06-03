//
//  ListTypesViewController.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 30/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ListTypesViewControllerDelegate: AnyObject {
    func update(value: String, url: String, validType: Bool)
}


class ListTypesViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: ListTypesViewControllerDelegate?
    
    let url = URL(string: URL_TYPES)
    private var results = [Type]()
    var lastSelection: IndexPath!
    var indexNumber: Int = -1
    var testValue: String = ""
    var validType: Bool = false
    var urlType: String = ""
    var validTypePokemon:  Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonFromUrl()
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    func getJsonFromUrl(){
        guard let downloadURL = url else {
            return
        }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                return
            }
            print("download")
            do {
                let decoder = JSONDecoder()
                let downloadedTypes = try decoder.decode(Types.self, from: data)
                self.results = downloadedTypes.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("something wrong after downloaded")
            }
        }.resume()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return results.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        return "Select your favorite pokémon type:"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white

        let headerLabel = UILabel(frame: CGRect(x: 20, y: 20, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))

        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)

        headerLabel.textColor = UIColor.darkGray
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerLabel.numberOfLines = 0
        headerView.addSubview(headerLabel)

        return headerView
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "typeCell") as? TypesTableViewCell else { return UITableViewCell() }

        cell.titleType.text = results[indexPath.row].name
        if let url = URL(string: results[indexPath.row].thumbnailImage){
                                   cell.iconType.af_setImage(withURL: url)
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: url)
//                if let data = data {
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.async {
//                       cell.iconType.image = image
//                    }
//                }
//            }
        }
        
        if indexNumber == indexPath.row{
            cell.radioCheckMark.image = UIImage(named: "radio-on")
        }else{
            cell.radioCheckMark.image = UIImage(named: "radio-off")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        let cell = tableView.cellForRow(at: indexPath) as! TypesTableViewCell
        cell.radioCheckMark.image = UIImage(named: "radio-on")
        indexNumber = indexPath.row
        
        testValue = "\(results[indexPath.row].name)"
        urlType = "\(results[indexPath.row].thumbnailImage)"
        validTypePokemon = true
    }

    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TypesTableViewCell {
            cell.radioCheckMark.image = UIImage(named: "radio-off")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    @IBAction func btnConfirm(_ sender: UIButton) {
    
        checkSelectType()

    }
    
    func checkSelectType () {
        
        if validTypePokemon != true {
            
            let alertController = UIAlertController(title: "Pokemon Finder",
                                                    message: "Please: \n\n* Select your favorite pokemon type",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            delegate?.update(value: testValue, url: urlType, validType: true)
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }


}
