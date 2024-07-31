//
//  DataBaseHelper.swift
//  NeoStoreApp
//
//  Created by Neosoft on 06/07/24.
//


import UIKit
import CoreData
class DataBaseHelper{
    
    static let sharedInstance = DataBaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveDataToCoreData(addressEntity : [String : String]){
        let address = NSEntityDescription.insertNewObject(forEntityName: "AddressEntity", into: context) as! AddressEntity
        
        address.city = addressEntity["city"]
        address.contry = addressEntity["contry"]
        address.state = addressEntity["state"]
        address.zipCode = addressEntity["zipCode"]
        do{
            try context.save()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    func getAllAddressDetails() -> [AddressEntity]{
        var addressArray = [AddressEntity]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AddressEntity")
        do{
            addressArray = try context.fetch(fetchRequest) as! [AddressEntity]
        }catch let error {
            print("Fetch address Details error\(error.localizedDescription)")
        }
        return addressArray
    }
    func deleteAddressData(index : Int,CompletionHandler:@escaping(([AddressEntity])->Void)) {
        var addressData = getAllAddressDetails()
        context.delete(addressData[index])
        addressData.remove(at: index)
        do{
            try context.save()
        }catch let error{
            print(error.localizedDescription)
        }
        CompletionHandler(addressData)
    }
}
