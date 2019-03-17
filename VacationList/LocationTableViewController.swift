import UIKit

class LocationTableViewController: UITableViewController {
    
    var locationModel: LocationList!
    
    @IBAction func addNewTask(_ sender: Any) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = locationModel.getLocations(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(location!.lat)"
        cell.detailTextLabel?.text = "replace with details"
        return cell
    }
    
}
