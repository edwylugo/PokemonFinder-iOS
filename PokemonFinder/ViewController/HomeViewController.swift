//
//  HomeViewController.swift
//  PokemonFinder
//
//  Created by Edwy Lugo on 31/05/19.
//  Copyright © 2019 Edwy Lugo. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func btnOrderBy(_ sender: UIButton) {
        sender.addTarget(self, action: #selector(sortPokemonsAlphabeticallyAndReload(_sender:)), for: .touchUpInside)
    }
    
    
    let urlTypes = URL(string: URL_TYPES)
    let urlPokemons = URL(string: URL_POKEMONS)
    private var resultsTypes = [Type]()
    private var resultsPokemons = [Pokemons]()
    var filteredName = [Pokemons]()
    var searchName = [Pokemons]()
    var teste = [Pokemons]()
    
    var searchController = UISearchController(searchResultsController: nil)
    var collectiveSelection = [IndexPath]()
    var arrName = [String]()
    var typeSelect = String()
    var selectedIndexPath: IndexPath?
    var stringArray: [String] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        getJsonFromUrlTypes()
        getJsonFromUrlPokemons()
    
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.title = "Pokemon Finder"
        
    
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        collectionView.reloadData()

        filteredName = filteredName.filter { $0.type.contains("\(typeSelect)") }
        
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        

        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.white
        
        searchController.searchBar.placeholder = "Search Pokemons"
        searchController.searchBar.barStyle = .default
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = false

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        

    }
    
    func getJsonFromUrlTypes(){
        
        guard let downloadURL = urlTypes else {
            return
        }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                return
            }
            print("download Types")
            do {
                let decoder = JSONDecoder()
                let downloadedTypes = try decoder.decode(Types.self, from: data)
                self.resultsTypes = downloadedTypes.results
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch {
                print("something wrong after downloaded")
            }
            }.resume()
        
    }
    
    func getJsonFromUrlPokemons() {
        
        guard let downloadURL = urlPokemons else {
            return
        }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                return
            }
            print("download Pokemons ")
            do {
                
                self.arrName.removeAll()
                
                let decoder = JSONDecoder()
                let downloadedPokemons = try decoder.decode([Pokemons].self, from: data)
                self.resultsPokemons = downloadedPokemons
                self.filteredName = downloadedPokemons
                self.searchName = downloadedPokemons
                self.teste = downloadedPokemons
                
                DispatchQueue.main.async {
                    self.filteredName = self.resultsPokemons.filter { $0.type.contains("\(self.typeSelect)") }
                    self.tableView.reloadData()
                }
                
            } catch {
                print("something wrong after downloaded")
            }
            }.resume()
        
    }
    
    
    
    @objc private func sortPokemonsAlphabeticallyAndReload(_sender: Any) {
        filteredName.sort { $0.name < $1.name }
        tableView.reloadData()
    }
    
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredName = searchName.filter({( pokemon : Pokemons) -> Bool in
            return pokemon.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
   

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredName.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listPokemonCell") as? PokemonsTableViewCell else { return UITableViewCell() }
        
        cell.lbNamePokemon.text = filteredName[indexPath.row].name
        if let url = URL(string: filteredName[indexPath.row].thumbnailImage){
            cell.ivPokemon.af_setImage(withURL: url)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        return resultsTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listTypeCell", for: indexPath) as? TypesCollectionViewCell else {
            return UICollectionViewCell() }
    
        
            cell.lbTitleType.text = resultsTypes[indexPath.row].name
                if let url = URL(string: resultsTypes[indexPath.row].thumbnailImage){
                    cell.ivType.af_setImage(withURL: url)
                }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filteredName = searchName.filter { $0.type.contains(resultsTypes[indexPath.row].name) }
        tableView.reloadData()
    }
    

}

extension HomeViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


