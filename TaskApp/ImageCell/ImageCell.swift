//
//  Imageswift
//  TaskApp
//
//  Created by MOHD SALEEM on 08/05/24.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 0.6
        imageView.layer.cornerRadius = 10
    }

}
