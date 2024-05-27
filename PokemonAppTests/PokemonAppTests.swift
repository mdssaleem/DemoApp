//
//  PokemonAppTests.swift
//  PokemonAppTests
//
//  Created by MOHD SALEEM on 27/05/24.
//

import XCTest
import Combine
@testable import PokemonApp

class PokemonAppTests: XCTestCase {

    var viewModel: PokemonViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        viewModel = PokemonViewModel()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = nil
    }

    // Test to verify fetching Pokémon list
    func testFetchPokemon() throws {
        let expectation = XCTestExpectation(description: "Fetch Pokémon list")

        viewModel.$pokemonList
            .dropFirst()
            .sink { pokemonList in
                XCTAssertFalse(pokemonList.isEmpty, "The Pokémon list should not be empty.")
                XCTAssertEqual(pokemonList.count, 100, "The Pokémon list should contain 100 Pokémon.")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchPokemon()

        wait(for: [expectation], timeout: 5.0)
    }

    // Test to verify sorting Pokémon list by name
    func testSortPokemonListByName() throws {
        // Mock Pokémon data
        let pokemon1 = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1")
        let pokemon2 = Pokemon(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4")
        let pokemon3 = Pokemon(name: "squirtle", url: "https://pokeapi.co/api/v2/pokemon/7")

        viewModel.pokemonList = [pokemon3, pokemon1, pokemon2]
        viewModel.sortOption = .name

        viewModel.sortPokemonList()

        XCTAssertEqual(viewModel.pokemonList.map { $0.name }, ["bulbasaur", "charmander", "squirtle"], "Pokémon list should be sorted alphabetically by name.")
    }
}
