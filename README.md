# TaskApp
Pokemon project for interview


<img width="359" alt="Screenshot 2024-05-09 at 12 21 22 PM" src="https://github.com/mdssaleem/TaskApp/assets/32189409/29fab559-2703-4425-a445-6e2041be9d1f">




Overview
PokemonApp is a simple SwiftUI-based list-detail application that fetches and displays a list of 100 Pokémon using the PokéAPI. It provides a sidebar to display Pokémon names and a detail view that shows more information about the selected Pokémon. Users can toggle between sorting the list alphabetically and by ID number. This project demonstrates the integration of SwiftUI with Combine for asynchronous data fetching, navigation, and basic unit testing.

Features
Fetches and displays a list of 100 Pokémon using the PokéAPI.
Displays Pokémon names in a list in the left sidebar, which collapses in compact mode.
Allows users to toggle between sorting the list alphabetically and by ID number.
When selecting a name from the sidebar, the app fetches and displays additional information about the Pokémon, including their name, ID, base experience, and abilities.
Includes working previews for each SwiftUI view.
Provides unit tests to ensure core functionality.
Requirements
iOS 14.0+
Xcode 12.0+
Swift 5.3+
Installation
Clone the repository:
bash
Copy code
git clone https://github.com/yourusername/PokemonApp.git
Open the project in Xcode:
bash
Copy code
cd PokemonApp
open PokemonApp.xcodeproj
Build and run the project on your preferred simulator or device.
Usage
Launch the app.
The left sidebar displays a list of 100 Pokémon names fetched from the PokéAPI.
Toggle the sorting order using the provided sort option (Alphabetically or by ID).
Select a Pokémon name from the sidebar to view detailed information about the selected Pokémon on the right side of the screen.
Code Structure
Models
Pokemon: Represents a Pokémon with basic details.
PokemonDetail: Represents detailed information about a Pokémon.
Sprites: Represents the sprite URLs for a Pokémon.
ViewModels
PokemonViewModel: Manages the fetching, sorting, and selection of Pokémon.
Views
ContentView: The main view containing the sidebar and detail view.
DetailView: Displays detailed information about a selected Pokémon.
Code Documentation
The code is documented with comments explaining key functionalities and logic. Refer to the inline comments for detailed explanations.

Unit Tests
The project includes unit tests to verify the following functionalities:

Fetching the Pokémon list.
Sorting the Pokémon list by name.


