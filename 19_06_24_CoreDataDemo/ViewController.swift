//
//  ViewController.swift
//  19_06_24_CoreDataDemo
//
//  Created by Vishal Jagtap on 21/08/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        insertUserRecord()
        retriveUserRecords()
        deleteUserRecord()
        retriveUserRecords()
    }
    
    func insertUserRecord(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        
        let userObject = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        userObject.setValue("Jaideep", forKey: "username")
        userObject.setValue("jaideep@gmail.com", forKey: "useremail")
        
        for i in 1...3{
            let eachUserObject = NSManagedObject(entity: userEntity!, insertInto: managedContext)
            eachUserObject.setValue("Person\(i)", forKey: "username")
            eachUserObject.setValue("person\(i)@gmail.com", forKey: "useremail")
        }
        
        do{
            try managedContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func retriveUserRecords(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let fetchedResults = try! managedContext.fetch(fetchRequest) as! [NSManagedObject]
        for eachObject in fetchedResults{
            print("Username -- \(eachObject.value(forKey: "username")!)")
            print("Useremail -- \(eachObject.value(forKey: "useremail")!)")
        }
        
        try! managedContext.save()
    }
    
    func deleteUserRecord(){
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let predicate = NSPredicate(format: "username = %@", "Jaideep")
        
        fetchRequest.predicate = predicate
        
        let fetchedResults = try! managedContext.fetch(fetchRequest) as! [NSManagedObject]

        for i in 0...fetchedResults.count - 1{
            let objectToBeDeleted = fetchedResults[i]
            managedContext.delete(objectToBeDeleted)
        }
        
        do{
            try managedContext.save()
        }catch{
            
        }
    }
}
