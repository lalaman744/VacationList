import Foundation

class Location: NSObject {
    
    var lat: Double
    var long: Double
    var visited: Bool
    
    init(lat: Double, long: Double, visited: Bool) {
        self.lat = lat
        self.long = long
        self.visited = visited
    }
    
    
}
