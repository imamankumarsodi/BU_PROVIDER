//
//	Service.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Service : NSObject, NSCoding{

	var amount : AnyObject?
	var date : String?
	var id : Int?
	var serviceId : Int?
	var serviceName : String?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		amount = dictionary["amount"] as? AnyObject
		date = dictionary["date"] as? String
		id = dictionary["id"] as? Int
		serviceId = dictionary["service_id"] as? Int
		serviceName = dictionary["service_name"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if amount != nil{
			dictionary["amount"] = amount
		}
		if date != nil{
			dictionary["date"] = date
		}
		if id != nil{
			dictionary["id"] = id
		}
		if serviceId != nil{
			dictionary["service_id"] = serviceId
		}
		if serviceName != nil{
			dictionary["service_name"] = serviceName
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         amount = aDecoder.decodeObject(forKey: "amount") as? AnyObject
         date = aDecoder.decodeObject(forKey: "date") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         serviceId = aDecoder.decodeObject(forKey: "service_id") as? Int
         serviceName = aDecoder.decodeObject(forKey: "service_name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if amount != nil{
			aCoder.encode(amount, forKey: "amount")
		}
		if date != nil{
			aCoder.encode(date, forKey: "date")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if serviceId != nil{
			aCoder.encode(serviceId, forKey: "service_id")
		}
		if serviceName != nil{
			aCoder.encode(serviceName, forKey: "service_name")
		}

	}

}
