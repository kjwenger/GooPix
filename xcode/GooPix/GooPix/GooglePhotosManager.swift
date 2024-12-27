import Foundation

enum PhotosError: Error {
    case authenticationError
    case networkError
    case invalidResponse
    case sessionExpired
}

class GooglePhotosManager {
    // API endpoints
    private let baseURL = "https://photoslibrary.googleapis.com/v1"
    private let pickerBaseURL = "https://photospicker.googleapis.com/v1"
    
    // Session management
    private var currentSession: String?
    private var accessToken: String?
    
    // MARK: - Session Management
    
    func createPickerSession() async throws -> (sessionId: String, pickerUri: String) {
        guard let url = URL(string: "\(pickerBaseURL)/sessions") else {
            throw PhotosError.invalidResponse
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw PhotosError.networkError
        }
        
        // Parse response
        struct SessionResponse: Codable {
            let id: String
            let pickerUri: String
        }
        
        let sessionResponse = try JSONDecoder().decode(SessionResponse.self, from: data)
        currentSession = sessionResponse.id
        
        return (sessionResponse.id, sessionResponse.pickerUri)
    }
    
    // MARK: - Media Items
    
    func getPickedMediaItems() async throws -> [MediaItem] {
        guard let sessionId = currentSession else {
            throw PhotosError.sessionExpired
        }
        
        let url = URL(string: "\(pickerBaseURL)/mediaItems?sessionId=\(sessionId)")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw PhotosError.networkError
        }
        
        // Parse response
        struct MediaItemsResponse: Codable {
            let mediaItems: [MediaItem]
            let nextPageToken: String?
        }
        
        let itemsResponse = try JSONDecoder().decode(MediaItemsResponse.self, from: data)
        return itemsResponse.mediaItems
    }
}

// MARK: - Models

struct MediaItem: Codable, Identifiable {
    let id: String
    let baseUrl: String
    let mimeType: String
    let mediaMetadata: MediaMetadata
    
    struct MediaMetadata: Codable {
        let width: Int
        let height: Int
        let photo: PhotoMetadata?
        let video: VideoMetadata?
    }
    
    struct PhotoMetadata: Codable {
        let cameraMake: String?
        let cameraModel: String?
        let focalLength: Double?
        let apertureFNumber: Double?
        let isoEquivalent: Int?
        let exposureTime: String?
    }
    
    struct VideoMetadata: Codable {
        let cameraMake: String?
        let cameraModel: String?
        let fps: Double?
    }
} 