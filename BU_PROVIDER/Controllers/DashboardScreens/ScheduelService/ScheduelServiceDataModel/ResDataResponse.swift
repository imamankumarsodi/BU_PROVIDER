//
//	ResDataResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ResDataResponse : NSObject, NSCoding{

	var additionalNote : AnyObject?
	var address : String?
	var addressId : String?
	var amount : AnyObject?
	var contactNumber : AnyObject?
	var createdAt : String?
	var deletedAt : AnyObject?
	var email : String?
	var firstName : String?
	var id : Int?
	var lastName : String?
	var mobile : String?
	var providerId : String?
	var serviceDate : String?
	var serviceId : String?
	var serviceName : String?
	var serviceNumber : String?
	var status : String?
	var statuses : [ResDataStatuse]?
	var updatedAt : String?
	var userId : String?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		additionalNote = dictionary["additional_note"] as? AnyObject
		address = dictionary["address"] as? String
		addressId = dictionary["address_id"] as? String
		amount = dictionary["amount"] as? AnyObject
		contactNumber = dictionary["contact_number"] as? AnyObject
		createdAt = dictionary["created_at"] as? String
		deletedAt = dictionary["deleted_at"] as? AnyObject
		email = dictionary["email"] as? String
		firstName = dictionary["first_name"] as? String
		id = dictionary["id"] as? Int
		lastName = dictionary["last_name"] as? String
		mobile = dictionary["mobile"] as? String
		providerId = dictionary["provider_id"] as? String
		serviceDate = dictionary["service_date"] as? String
		serviceId = dictionary["service_id"] as? String
		serviceName = dictionary["service_name"] as? String
		serviceNumber = dictionary["service_number"] as? String
		status = dictionary["status"] as? String
		statuses = [ResDataStatuse]()
		if let statusesArray = dictionary["statuses"] as? [[String:Any]]{
			for dic in statusesArray{
				let value = ResDataStatuse(fromDictionary: dic)
				statuses?.append(value)
			}
		}
		updatedAt = dictionary["updated_at"] as? String
		userId = dictionary["user_id"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if additionalNote != nil{
			dictionary["additional_note"] = additionalNote
		}
		if address != nil{
			dictionary["address"] = address
		}
		if addressId != nil{
			dictionary["address_id"] = addressId
		}
		if amount != nil{
			dictionary["amount"] = amount
		}
		if contactNumber != nil{
			dictionary["contact_number"] = contactNumber
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if deletedAt != nil{
			dictionary["deleted_at"] = deletedAt
		}
		if email != nil{
			dictionary["email"] = email
		}
		if firstName != nil{
			dictionary["first_name"] = firstName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if lastName != nil{
			dictionary["last_name"] = lastName
		}
		if mobile != nil{
			dictionary["mobile"] = mobile
		}
		if providerId != nil{
			dictionary["provider_id"] = providerId
		}
		if serviceDate != nil{
			dictionary["service_date"] = serviceDate
		}
		if serviceId != nil{
			dictionary["service_id"] = serviceId
		}
		if serviceName != nil{
			dictionary["service_name"] = serviceName
		}
		if serviceNumber != nil{
			dictionary["service_number"] = serviceNumber
		}
		if status != nil{
			dictionary["status"] = status
		}
		if statuses != nil{
			var dictionaryElements = [[String:Any]]()
			for statusesElement in statuses! {
				dictionaryElements.append(statusesElement.toDictionary())
			}
			dictionary["statuses"] = dictionaryElements
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         additionalNote = aDecoder.decodeObject(forKey: "additional_note") as? AnyObject
         address = aDecoder.decodeObject(forKey: "address") as? String
         addressId = aDecoder.decodeObject(forKey: "address_id") as? String
         amount = aDecoder.decodeObject(forKey: "amount") as? AnyObject
         contactNumber = aDecoder.decodeObject(forKey: "contact_number") as? AnyObject
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         deletedAt = aDecoder.decodeObject(forKey: "deleted_at") as? AnyObject
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstName = aDecoder.decodeObject(forKey: "first_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lastName = aDecoder.decodeObject(forKey: "last_name") as? String
         mobile = aDecoder.decodeObject(forKey: "mobile") as? String
         providerId = aDecoder.decodeObject(forKey: "provider_id") as? String
         serviceDate = aDecoder.decodeObject(forKey: "service_date") as? String
         serviceId = aDecoder.decodeObject(forKey: "service_id") as? String
         serviceName = aDecoder.decodeObject(forKey: "service_name") as? String
         serviceNumber = aDecoder.decodeObject(forKey: "service_number") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         statuses = aDecoder.decodeObject(forKey :"statuses") as? [ResDataStatuse]
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if additionalNote != nil{
			aCoder.encode(additionalNote, forKey: "additional_note")
		}
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if addressId != nil{
			aCoder.encode(addressId, forKey: "address_id")
		}
		if amount != nil{
			aCoder.encode(amount, forKey: "amount")
		}
		if contactNumber != nil{
			aCoder.encode(contactNumber, forKey: "contact_number")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deleted_at")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "first_name")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "last_name")
		}
		if mobile != nil{
			aCoder.encode(mobile, forKey: "mobile")
		}
		if providerId != nil{
			aCoder.encode(providerId, forKey: "provider_id")
		}
		if serviceDate != nil{
			aCoder.encode(serviceDate, forKey: "service_date")
		}
		if serviceId != nil{
			aCoder.encode(serviceId, forKey: "service_id")
		}
		if serviceName != nil{
			aCoder.encode(serviceName, forKey: "service_name")
		}
		if serviceNumber != nil{
			aCoder.encode(serviceNumber, forKey: "service_number")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if statuses != nil{
			aCoder.encode(statuses, forKey: "statuses")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}

	}

}
