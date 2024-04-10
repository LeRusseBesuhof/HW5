import UIKit

struct Event : Identifiable {
    var id : String = UUID().uuidString
    var name : String
    var dateOfCreation : String
    var image : String
    
    static func rawData() -> [[Event]] {
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
    }
}

class ViewController: UIViewController {
    
    private var events = Event.rawData()
    
    lazy var tableView : UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "event")
        $0.backgroundColor = .appYellow
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

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        events.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath)
        cell.backgroundColor = .appEvent
        
        var config = cell.defaultContentConfiguration()
        let currentEvent = events[indexPath.section][indexPath.row]
        
        config.text = currentEvent.name
        config.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        config.secondaryText = currentEvent.dateOfCreation
        
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
