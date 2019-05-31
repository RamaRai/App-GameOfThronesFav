//
//  JsonController.swift
//  Game Of Throne Favourites
//
//  Created by Rama Rai on 2019-05-20.
//  Copyright © 2019 Rama Rai All rights reserved.
//

import Foundation

//methods in Protocol are mandatory to be called unless optional
protocol charactersDelegateProtocol {
    func charactersProtocolDidFinishWithData(array : NSArray)
    func charactersProtocoleDidFinishWithCharacterDetails(details:NSDictionary) 
}


// Reading from resident Json file inside the bundle for the source
class jsonController {
    var delegate : charactersDelegateProtocol? = nil
    
    func getJsonArray() -> NSArray {
        var charactersArray = NSArray()
        do{
            let path = Bundle.main.path(forResource: "source", ofType: "json")
            let jsonString = try String(contentsOfFile: path!)
            let dataFromJson = jsonString.data(using: .utf8)
            //Json serialization for key value pair
            let jsonObject = try JSONSerialization.jsonObject(with: dataFromJson!, options: []) as! NSDictionary
            //getting value for the Key characters
             charactersArray = jsonObject.value(forKey: "characters") as! NSArray
        }catch{
            
        }
        return charactersArray
    }
    
    //Readson Data from Json
    func readJson()  {
        let charactersArray = getJsonArray()
            if let mydelegate = delegate {
                mydelegate.charactersProtocolDidFinishWithData(array: charactersArray)
            }
    }

    func getSpecificCharacterDetails(characterName : String)  {
        let charactersArray = getJsonArray()
        var result = NSDictionary()
        for item in charactersArray {
            let name = (item as! NSDictionary).value(forKey: "characterName") as! String
            if name == characterName {
                result = item as! NSDictionary
                if let myDelegate = self.delegate {
                    myDelegate.charactersProtocoleDidFinishWithCharacterDetails(details: result)
                    break
                }
            }
        }
        
    }
}
