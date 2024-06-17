//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by 김민지 on 5/5/24.
//

import Foundation
import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    
    var pokemon: Pokemon! // PokemonViewController로 화면 전환시 포켓몬 정보 전달
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        type1Label.text = ""
        type2Label.text = ""
        
        let url = URL(string: pokemon.url)
        guard let u = url else {
            return
        }
        
        URLSession.shared.dataTask(with: u) {(data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                
                DispatchQueue.main.async {
                    self.nameLabel.text = self.pokemon.name
                    self.numberLabel.text = String(format: "#%03d", pokemonData.id)
                    
                    // 포켓몬 타입 정보 저장할 때, 각 타입에 대한 순서 부여
                    for typeEntry in pokemonData.types {
                        // 첫 번째 type
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        }
                        // 두 번째 type
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }
                }
            }
            catch let error {
                print("\(error)")
            }
        }.resume()
        
        // nameLabel.text = pokemon.name
        // numberLabel.text = String(format: "#%03d", pokemon.number)
        // int -> string 으로 강제 형변환 시킨다
    }
}
