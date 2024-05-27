# TaskApp
Demo project for interview


<img width="359" alt="Screenshot 2024-05-09 at 12 21 22 PM" src="https://github.com/mdssaleem/TaskApp/assets/32189409/29fab559-2703-4425-a445-6e2041be9d1f">




Image Grid App
This iOS application efficiently loads and displays images in a scrollable grid without relying on any third-party image loading library.

Tasks
Image Grid: Displays a 3-column square image grid with center-cropped images.
Image Loading: Implements asynchronous image loading using the provided API URL. Constructs image URLs using fields of the thumbnail object.
Display: Allows users to scroll through at least 100 images.
Caching: Develops a caching mechanism to store images retrieved from the API in both memory and disk cache for efficient retrieval.
Error Handling: Handles network errors and image loading failures gracefully, providing informative error messages or placeholders for failed image loads.
Implementation
Implemented in Swift using native technology.
Utilizes lazy loading for images.
Cancels image loading for off-screen cells to optimize performance.
Implements both disk and memory cache. Disk cache is used if an image is missing in memory cache, and memory cache is updated when an image is read from disk.
Evaluation Criteria
Ensures no lag while scrolling the image grid.
Implements lazy loading and cancellation of image loading for optimal performance.
Provides both disk and memory caching mechanisms.
Compiles successfully with the latest Xcode version.
Includes clear step-by-step instructions in the README file for running the code.
Note
Assignments submitted using technologies like Flutter or React Native will be rejected.
Code quality and adherence to the provided requirements are crucial for evaluation.



**Used Technology 
**
Tool - Xcode Version 15.3 (15E204a)
Language - Swift 5

func callAPI() //Used for call API

func loadImage() // Used to load image lazy with asynchronous way


JSONSerialization // To parse json data


