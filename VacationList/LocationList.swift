import Foundation

class LocationList {
    
    var locations = [Location]()
    
    func add (_ location: Location) -> Int {
        locations.append(location)
        return locations.endIndex
    }
    
    func getLocations(at index: Int) -> Location? {
        if locations.indices.contains(index) {
            return locations[index]
        }
        return nil
    }
    
    func count() -> Int {
        return locations.count
    }
}
