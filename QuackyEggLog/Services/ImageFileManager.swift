import UIKit

final class ImageFileManager {
    
    static let shared = ImageFileManager()
    
    private let folderName = "ProductImages"
    private let fileManager = FileManager.default
    private let storageURL: URL
    
    private init() {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let folderURL = documentsDirectory.appendingPathComponent(folderName, isDirectory: true)
        storageURL = folderURL
        
        createStorageDirectoryIfNeeded()
    }
    
    private func createStorageDirectoryIfNeeded() {
        guard !fileManager.fileExists(atPath: storageURL.path) else { return }
        
        do {
            try fileManager.createDirectory(at: storageURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("⚠️ Failed to create image storage directory: \(error)")
        }
    }
        
    @discardableResult
    func storeImage(_ image: UIImage, for id: UUID) async -> String? {
        let filename = imageFileName(for: id)
        let fileURL = storageURL.appendingPathComponent(filename)
        
        guard let data = image.pngData() else {
            print("❌ Failed to convert UIImage to PNG data.")
            return nil
        }
        
        do {
            try data.write(to: fileURL, options: .atomic)
            return filename
        } catch {
            print("❌ Error writing image to disk: \(error)")
            return nil
        }
    }
    
    func retrieveImage(named filename: String) async -> UIImage? {
        let fileURL = storageURL.appendingPathComponent(filename)
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    func removeImage(for id: UUID) async {
        let fileURL = storageURL.appendingPathComponent(imageFileName(for: id))
        
        guard fileManager.fileExists(atPath: fileURL.path) else { return }
        
        do {
            try fileManager.removeItem(at: fileURL)
        } catch {
            print("⚠️ Failed to delete image file: \(error)")
        }
    }
    
    private func imageFileName(for id: UUID) -> String {
        "\(id.uuidString).png"
    }
}
