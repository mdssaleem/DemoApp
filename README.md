# TaskApp
Pokemon project for interview


<img width="356" alt="Screenshot 2024-05-27 at 6 20 05 AM" src="https://github.com/mdssaleem/DemoApp/assets/32189409/3cbad643-e887-4d35-9b65-bd1a6d5f73be">
<img width="359" alt="Screenshot 2024-05-27 at 6 20 15 AM" src="https://github.com/mdssaleem/DemoApp/assets/32189409/42157c5b-dfdd-42e2-8782-ed990c7bdb4c">
<img width="355" alt="Screenshot 2024-05-27 at 6 20 31 AM" src="https://github.com/mdssaleem/DemoApp/assets/32189409/964d8a97-ccb4-4a20-bffd-f42044485754">




# PokemonApp

## Overview

PokemonApp is a simple SwiftUI-based list-detail application that fetches and displays a list of 100 Pokémon using the PokéAPI. It provides a sidebar to display Pokémon names and a detail view that shows more information about the selected Pokémon. Users can toggle between sorting the list alphabetically and by ID number. This project demonstrates the integration of SwiftUI with Combine for asynchronous data fetching, navigation, and basic unit testing.

## Features

- Fetches and displays a list of 100 Pokémon using the PokéAPI.
- Displays Pokémon names in a list in the left sidebar, which collapses in compact mode.
- Allows users to toggle between sorting the list alphabetically and by ID number.
- When selecting a name from the sidebar, the app fetches and displays additional information about the Pokémon, including their name, ID, base experience, and abilities.
- Includes working previews for each SwiftUI view.
- Provides unit tests to ensure core functionality.

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/PokemonApp.git



## Usage
- Launch the app.
- The left sidebar displays a list of 100 Pokémon names fetched from the PokéAPI.
- Toggle the sorting order using the provided sort option (Alphabetically or by ID).
- Select a Pokémon name from the sidebar to view detailed information about the selected Pokémon on the right side of the screen.


## Code Structure
   ## Models
- Pokemon: Represents a Pokémon with basic details.
- PokemonDetail: Represents detailed information about a Pokémon.
- Sprites: Represents the sprite URLs for a Pokémon.

   ## ViewModels
- PokemonViewModel: Manages the fetching, sorting, and selection of Pokémon.

   ## Views
- ContentView: The main view containing the sidebar and detail view.
- DetailView: Displays detailed information about a selected Pokémon.

## Code Documentation
- The code is documented with comments explaining key functionalities and logic. Refer to the inline comments for detailed explanations.

## Unit Tests
   ## The project includes unit tests to verify the following functionalities:

- Fetching the Pokémon list.
- Sorting the Pokémon list by name.

