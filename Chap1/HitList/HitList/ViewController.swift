//
//  ViewController.swift
//  HitList
//
//  Created by sungnni on 2018. 5. 23..
//  Copyright © 2018년 sungeun. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // model for the table view
    
    // 초기 테스트 버전.
    // var names: [String] = []
    
    // -> Saving Core Data
    var people: [NSManagedObject] = []
    
    // -> Fetching From Core Data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1. fetch 할때도 managed object context가 필요.
        // -. 애플리케이션 위임자를 끌어와 영구 컨테이너에 대한 참조를 가져 와서 NSManagedObjectContext를 사용
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2. NSFetchRequest<ResultType>은 Core Data에서 가져 오는 작업을 담당하는 클래스
        // -. Generic Type. return <ResultType>
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //3. fetch (_ :)는 fetch 요청에 의해 지정된 기준을 충족하는 managed objects의 배열을 반환
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    
    @IBAction private func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default)
        { [unowned self] action in
            
        guard let textField = alert.textFields?.first,
            let nameToSave = textField.text else {
                return
            }
            
//            self.people.append(nameToSave)
            self.save(name: nameToSave)
            
            self.tableView.reloadData()
        }
        
        let cancleAction = UIAlertAction(title: "Cancle", style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancleAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func save(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // ** 코어데이터에 새로운 managed object를 저장하는 2가지 step
        // (a) managed object context에 새로운 managed object를 삽입
        // (b) managed object context의 변화를 디스크에 저장하기 위해 commit.
        
        // -. NSPersistentContainer - 코어 데이터에 저장하거나 검색하기 위해서 사용.
        let managedContext = appDelegate.persistentContainer.viewContext // viewContext - NSManagedObjectContext
        
        // (a) 새로운 managed object를 만들어 managed object context에 삽입하는데
        // NSManagedObject의 static method: entity(forEntityName:in:) 를 사용
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // -. NSManagedObject, key-value를 사용, name 속성을 설정
        person.setValue(name, forKey: "name")
        
        // (b) save를 호출하여 commit
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell
    }
}
