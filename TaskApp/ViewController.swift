//
//  ViewController.swift
//  TaskApp
//
//  Created by MOHD SALEEM on 08/05/24.
//

import UIKit

struct Thumbnail: Codable {
    let id: String
    let version: Int
    let domain: String
    let basePath: String
    let key: String
    let qualities: [Int]
    let aspectRatio: Int
}

struct BackupDetails: Codable {
    let pdfLink: String
    let screenshotURL: String
}

struct Coverage: Codable {
    let id: String
    let title: String
    let language: String
    let thumbnail: Thumbnail
    let mediaType: Int
    let coverageURL: String
    let publishedAt: String
    let publishedBy: String
    let backupDetails: BackupDetails?
}

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var mainCollectionView: UICollectionView!
    
    
    let imageLoadQueue = DispatchQueue(label: "com.iDeveloper.TaskApp", attributes: .concurrent)
    var loadedImages = [String: UIImage]()
    
    var imageArray = [""]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainCollectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")

        callAPI()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell)!
        
        cell.imageView.frame = CGRect(x: 5, y: 5, width: cell.contentView.frame.size.width-10, height: cell.contentView.frame.size.height-10)
        let imageURL =  self.imageArray[indexPath.item] // Replace 'images' with your array of image URLs
                
                // Check if image is already loaded
                if let image = loadedImages[imageURL] {
                    // Image is loaded, set it directly
                    cell.imageView.image = image
                } else {
                    // Image is not loaded, set placeholder and start loading asynchronously
                    cell.imageView.image = UIImage(named: "placeholder")
                    loadImage(from: imageURL, for: indexPath)
                }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }

    func callAPI() {
        // Create URL
        guard let url = URL(string: "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100") else {
            print("Error: Invalid URL")
            return
        }
        
        // Create URLRequest
        var request = URLRequest(url: url)
        
        // Configure request
        request.httpMethod = "GET" // HTTP method
        // Add headers if needed
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create URLSession
        let session = URLSession.shared
        
        // Create data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            // Handle response and errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Invalid response")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Error: Invalid status code: \(httpResponse.statusCode)")
                return
            }
            
            // Check if data is nil
            guard let responseData = data else {
                print("Error: No data received")
                return
            }
            
            // Parse JSON response if needed
            do {
                let jsonString = try JSONSerialization.jsonObject(with: responseData, options: [])
                //print("Response: \(jsonString)")
                
                // Check if the JSON object is an array of dictionaries
                if let jsonArray = jsonString as? [[String: Any]] {
                    // Parse each dictionary in the array
                    self.imageArray.removeAll()
                    for jsonDict in jsonArray {
                        // Parse the JSON dictionary into a Coverage object
                        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict),
                           let coverage = try? JSONDecoder().decode(Coverage.self, from: jsonData) {
                           
                            let imageURL = coverage.thumbnail.domain + "/" + coverage.thumbnail.basePath + "/0/" + coverage.thumbnail.key
                            self.imageArray.append(imageURL)
                            
                            if let backupDetails = coverage.backupDetails {
                               
                            }
                            
                        }
                    }
                }
                DispatchQueue.main.async {
                       self.mainCollectionView.reloadData()
                   }
            } catch {
                print("Error parsing JSON: \(error)")
            }

                }
        
        // Resume data task to initiate the API call
        dataTask.resume()
    }
    
    
   
    func loadImage(from imageURL: String, for indexPath: IndexPath) {
            // Perform image loading asynchronously
            imageLoadQueue.async {
                if let url = URL(string: imageURL),
                   let imageData = try? Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    // Update loadedImages dictionary with loaded image
                    self.loadedImages[imageURL] = image
                    
                    DispatchQueue.main.async {
                        // Reload the corresponding cell
                        self.mainCollectionView.reloadItems(at: [indexPath])
                    }
                }
            }
        }
    
}

