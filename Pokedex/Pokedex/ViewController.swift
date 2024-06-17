//
//  ViewController.swift
//  Pokedex
//
//  Created by 김민지 on 5/5/24.
//

import UIKit

class ViewController: UITableViewController {
    // how many sections ?
    var pokemon: [Pokemon] = []
    
    // text.dropFirst() = 첫 번째 문자를 제외하고 나머지 문자열 반환
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    // view가 처음 load될 때마다 생성
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")
        // URL? 을 확인하기 위함
        guard let u = url else {
            return
        }
        
        // dataTask가 완료될시 클로저 내부에서 분리해 처리
        URLSession.shared.dataTask(with: u) {(data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                // JSON 데이터를 Swift 객체로 변환
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                self.pokemon = pokemonList.results
                
                // 가져온 데이터를 메인스레드에서 UI로 업데이트
                // 네트워크 요청은 백그라운드 스레드에서 수행되기에 UI업데이트 하기 위해 메인 스레드로 이동
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let error {
                print("\(error)")
            }
        }.resume()
    }
    
    // how many rows?
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }

    // what do we do?
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        // cell 이 필요할 때마다 tableview는 재사용큐에서 cell을 가져오거나 새로운 cell을 만듦 (메모리 사용을 최적화), dequeueReusableCell = 재사용가능한 셀을 큐에서 가져오는 것
        // indexPath : section과 행의 정보를 모두 담음
        
        cell.textLabel?.text = capitalize(text: pokemon[indexPath.row].name)
        // indexPath.row 행의 위치정보로를 가지고, textLabel에 대한 text를 포켓몬 이름으로 (문자열의 첫글자는 대문자로) 설정
        return cell
    }
    
    // PokemonViewController의 pokemon property에게 데이터 전달 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSegue" {
            if let destination = segue.destination as? PokemonViewController {
                destination.pokemon = pokemon[tableView.indexPathForSelectedRow!.row]
            
            }
        }
    }
}
