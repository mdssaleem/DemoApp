import SwiftUI
import Combine
import Foundation

// MARK: - Models

struct PokemonResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    let url: String
    var details: PokemonDetail?

    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PokemonDetail: Codable {
    let id: Int
    let base_experience: Int
    let height: Int
    let weight: Int
    let sprites: Sprites
    let abilities: [Ability]

    struct Ability: Codable {
        let ability: AbilityDetail
    }

    struct AbilityDetail: Codable {
        let name: String
    }
}

struct Sprites: Codable {
    let front_default: String
}

// MARK: - View Model

class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var selectedPokemon: Pokemon?
    @Published var sortOption: SortOption = .id

    private var cancellables = Set<AnyCancellable>()

    enum SortOption: String, CaseIterable {
        case id = "ID"
        case name = "Name"
    }

    init() {
        fetchPokemon()
    }

    func fetchPokemon() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PokemonResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching Pokémon: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.pokemonList = response.results
                self?.sortPokemonList()
            })
            .store(in: &cancellables)
    }

    func fetchPokemonDetail(for pokemon: Pokemon) {
        guard let url = URL(string: pokemon.url) else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PokemonDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching Pokémon details: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] detail in
                if let index = self?.pokemonList.firstIndex(where: { $0.id == pokemon.id }) {
                    self?.pokemonList[index].details = detail
                    self?.selectedPokemon = self?.pokemonList[index]
                }
            })
            .store(in: &cancellables)
    }

    func sortPokemonList() {
        switch sortOption {
        case .id:
            pokemonList.sort { $0.id.uuidString < $1.id.uuidString }
        case .name:
            pokemonList.sort { $0.name < $1.name }
        }
    }
}

// MARK: - Views

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()

    var body: some View {
        NavigationSplitView {
            VStack {
                Picker("Sort by", selection: $viewModel.sortOption) {
                    ForEach(PokemonViewModel.SortOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List(viewModel.pokemonList, id: \.self) { pokemon in
                    NavigationLink(
                        destination: DetailView(pokemon: pokemon)
                            .onAppear {
                                viewModel.fetchPokemonDetail(for: pokemon)
                            },
                        tag: pokemon,
                        selection: $viewModel.selectedPokemon
                    ) {
                        Text(pokemon.name.capitalized)
                    }
                }
                .navigationTitle("Pokémon List")
            }
        } detail: {
            if let selectedPokemon = viewModel.selectedPokemon {
                DetailView(pokemon: selectedPokemon)
            } else {
                Text("Select a Pokémon")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
        }
        .onChange(of: viewModel.sortOption) { _ in
            viewModel.sortPokemonList()
        }
    }
}

struct DetailView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    let pokemon: Pokemon

    var body: some View {
        VStack {
            if let details = pokemon.details {
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .padding()

                if let imageUrl = URL(string: details.sprites.front_default) {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        case .failure(_):
                            Image(systemName: "xmark.circle")
                        @unknown default:
                            ProgressView()
                        }
                    }
                }

                Text("ID: \(details.id)")
                    .padding()
                Text("Base Experience: \(details.base_experience)")
                    .padding()
                Text("Height: \(details.height)")
                    .padding()
                Text("Weight: \(details.weight)")
                    .padding()
                Text("Abilities:")
                    .font(.headline)
                    .padding(.top)
                ForEach(details.abilities, id: \.ability.name) { ability in
                    Text(ability.ability.name.capitalized)
                        .padding(.vertical, 2)
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(pokemon.name.capitalized)
        .onAppear {
            viewModel.fetchPokemonDetail(for: pokemon)
        }
    }
}

