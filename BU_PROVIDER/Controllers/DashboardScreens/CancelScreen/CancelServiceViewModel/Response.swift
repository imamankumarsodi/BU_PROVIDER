//
//	Response.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Response : NSObject, NSCoding{

	var services : [Service]?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		services = [Service]()
		if let servicesArray = dictionary["services"] as? [[String:Any]]{
			for dic in servicesArray{
				let value = Service(fromDictionary: dic)
				services?.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if services != nil{
			var dictionaryElements = [[String:Any]]()
			for servicesElement in services! {
				dictionaryElements.append(servicesElement.toDictionary())
			}
			dictionary["services"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         services = aDecoder.decodeObject(forKey :"services") as? [Service]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if services != nil{
			aCoder.encode(services, forKey: "services")
		}

	}

}
