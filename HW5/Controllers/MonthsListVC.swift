import UIKit

struct Month : Identifiable {
    var id : String = UUID().uuidString
    var name : String
    var notes : [String]
    var image : String
    
    static func rawData() -> [[Month]] {
        [
            [
                Month(name: "December", notes: ["Demobilizaion", "Searching for a Job"], image: "dec"),
                Month(name: "January", notes: ["New Job", "Christmas party", "Learning Swift"], image: "jan"),
                Month(name: "February", notes: ["My B-Day", "BF B-Day"], image: "feb")
                
            ],
            [
                Month(name: "March", notes: ["Hanging out", "Buying a Scooter",  "Error=Nil"], image: "mar"),
                Month(name: "April", notes: ["Playing the Guitar"], image: "apr")
            ]
        ]
    }
}

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private var months = Month.rawData()
    
    lazy var tableView : UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "Month")
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UITableView(frame: view.frame, style: .insetGrouped))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My Months in 2024\u{1F4DD}"
        
        view.addSubview(tableView)
    }
}

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        months.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        months[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Month", for: indexPath)
        switch indexPath.section {
        case 0: cell.backgroundColor = .appBlue
        case 1: cell.backgroundColor = .appGreen
        default: cell.backgroundColor = .white
        }
        
        var config = cell.defaultContentConfiguration()
        let currentMonth = months[indexPath.section][indexPath.row]
        
        config.text = currentMonth.name
        config.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        config.secondaryText = ""
        for (ind, el) in currentMonth.notes.enumerated() {
            config.secondaryText! += ind == currentMonth.notes.count - 1 ? el : "\(el), "
        }
        
        config.image = UIImage(named: currentMonth.image)
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
        let notesListVC = NotesListVC()
        let curMonth = months[indexPath.section][indexPath.row]
        
        notesListVC.imageName = curMonth.image
        notesListVC.seasonName = curMonth.name
        notesListVC.sectionNumber = indexPath.section == 0 ? indexPath.row : indexPath.row + 3
        notesListVC.names = curMonth.notes
        
        // let text = tableView.dataSource?.tableView?(tableView, titleForHeaderInSection: indexPath.section) ?? "no data"
        // notesListVC.seasonName = text
        
        navigationController?.pushViewController(notesListVC, animated: true)
    }
}

// а как создать универсальные расширения для всего проекта?
// а где вызываются все эти функции?

