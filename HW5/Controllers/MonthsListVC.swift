import UIKit


class ViewController: UIViewController {
    
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
        navigationItem.title = "My Events in 2024\u{1F4DD}"
        navigationItem.backButtonTitle = ""
        
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
        case 0: cell.backgroundColor = .appYellow
        case 1: cell.backgroundColor = .appGreen
        default: cell.backgroundColor = .white
        }
        
        let currentMonth = months[indexPath.section][indexPath.row]
        
        var secondaryText = ""
        for (ind, el) in currentMonth.notes.enumerated() {
            secondaryText += ind == currentMonth.notes.count - 1 ? el : "\(el), "
        }
        
        var config = cell.defaultContentConfiguration()
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = config.setGetConfigBy(text: currentMonth.name, secondaryText: secondaryText, image: currentMonth.image)
        
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
        notesListVC.names = curMonth.notes
        
        switch indexPath.section {
        case 1:
            notesListVC.sectionNumber = indexPath.row + 3
            notesListVC.imageName = "spring"
        default:
            notesListVC.sectionNumber = indexPath.row
            notesListVC.imageName = "winter"
        }
        
        navigationController?.pushViewController(notesListVC, animated: true)
    }
}
