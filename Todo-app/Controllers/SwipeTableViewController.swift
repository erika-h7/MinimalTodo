//
//  SwipeViewController.swift
//  Todo-app
//
//  Created by Infinity Code on 10/20/22.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
    
                
                cell.delegate = self
                
                print("This is the cell >>>>>>>>> \(cell)")
                
                return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
            print("Item deleted cell")

            self.updateModel(at: indexPath)

        }
        
        // customize the action appearance
        deleteAction.transitionDelegate = ScaleTransition.default
        deleteAction.textColor = UIColor(.red)
        deleteAction.backgroundColor = UIColor(.white)
        
        let imageIcon = self.resizeImage(image: UIImage(named: "trash")!, targetSize: CGSizeMake(40.0, 40.0))
        //        let imageIcon = UIImage(named: "trash")
        deleteAction.image = imageIcon
        
        return [deleteAction]
    }
    
    
    // Mark: - Update Model Function
    func updateModel(at indexPath: IndexPath) {
        // Update our data model.
    }
    
    
    
    
    // Mark: - Image Resize Function
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}
