//
//  Pokemon.swift
//  Pokedex
//
//  Created by 김민지 on 5/5/24.
//


import Foundation

struct PokemonList: Codable{
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct PokemonData: Codable {
    let id: Int
    let types: [PokemonTypeEntry]
}

struct PokemonType: Codable {
    let name: String
    let url: String
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}
