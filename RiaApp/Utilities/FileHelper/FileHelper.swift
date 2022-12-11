//
//  FileManager.swift
//  RiaApp
//
//  Created by Admin on 11.12.2022.
//

import Foundation
import UIKit

class FileHelper {
    
    static let share = FileHelper()
    
    func loadImage(fileName: String) -> UIImage? {
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
    func save(image: UIImage, filename: String) -> String? {
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        let fileURL = documentsUrl.appendingPathComponent(filename)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            return filename // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }
    
    func saveImage(data: Data) -> String? {
        let newImage = UIImage(data: data)
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return "" }
        
        let fileName = UUID().uuidString
        let fileURL = documentsDirectory.appendingPathComponent("\(fileName).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        let nameImage = FileHelper().save(image: newImage!, filename: "\(fileName).jpg")!
        return nameImage
    }
}
