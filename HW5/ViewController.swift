import UIKit

struct Event : Identifiable {
    var id : String = UUID().uuidString
    var name : String
    var dateOfCreation : [String]
    var image : String
    
    static func rawData() -> [[Event]] {
        [
            [
                Event(name: "December", dateOfCreation: ["Demobilizaion", "Searching for a Job"], image: "dec"),
                Event(name: "January", dateOfCreation: ["New Job", "Christmas party", "Learning Swift"], image: "jan"),
                Event(name: "February", dateOfCreation: ["My B-Day", "BF B-Day"], image: "feb"),
                
            ],
            [
                Event(name: "March", dateOfCreation: ["Hanging out", "Buying a Scooter",  "Error=Nil"], image: "mar"),
                Event(name: "April", dateOfCreation: ["Playing the Guitar"], image: "apr"),
            ]
        ]
    }
}

class ViewController: UIViewController {
    
    private var events = Event.rawData()
    
    lazy var tableView : UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "event")
        // $0.backgroundColor = .appYellow
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UITableView(frame: view.frame, style: .insetGrouped))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My Events in 2024\u{1F4DD}"
        
        view.addSubview(tableView)
    }
}

/*
 [
     [
         Event(name: "Demobilization", dateOfCreation: "01.12", image: "soldier"),
         Event(name: "New Job", dateOfCreation: "07.01", image: "job"),
         Event(name: "Christmas party", dateOfCreation: "09.01", image: "dance"),
         Event(name: "I'm gonna be an iOS-developer", dateOfCreation: "21.01", image: "programing")
     ],
     [
         Event(name: "Hanging out with my Friends", dateOfCreation: "15.03", image: "friends"),
         Event(name: "Buying a Scooter", dateOfCreation: "17.03", image: "scooter"),
         Event(name: "Becoming Error=Nil School student", dateOfCreation: "26.03", image: "error"),
         Event(name: "Playing the Guitar", dateOfCreation: "01.04", image: "guitar"),
     ]
 ]
 */

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        events.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath)
        switch indexPath.section {
        case 0: cell.backgroundColor = .appBlue
        case 1: cell.backgroundColor = .appGreen
        default: cell.backgroundColor = .white
        }
        
        var config = cell.defaultContentConfiguration()
        let currentEvent = events[indexPath.section][indexPath.row]
        
        config.text = currentEvent.name
        config.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        config.secondaryText = ""
        for (ind, el) in currentEvent.dateOfCreation.enumerated() {
            config.secondaryText! += ind == currentEvent.dateOfCreation.count - 1 ? el : "\(el), "
        }
        
        config.image = UIImage(named: currentEvent.image)
        config.imageProperties.maximumSize = CGSize(width: 56, height: 56)
        
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = config
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Winter"
        case 1: return "Spring"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
