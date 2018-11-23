

import Foundation
struct WishListAddRemoveModel : Codable {
	let status : Int?
	let datawishlist : [DataWishlistModel]?
	let msg : String?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case datawishlist = "data"
		case msg = "msg"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		datawishlist = try values.decodeIfPresent([DataWishlistModel].self, forKey: .datawishlist)
		msg = try values.decodeIfPresent(String.self, forKey: .msg)
	}

}
struct DataWishlistModel : Codable {
    let id : String?
    let name : String?
    let sku : String?
    let price : String?
    //let discountPrice : Int?
    let qty : Int?
    let image : String?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case sku = "sku"
        case price = "price"
       // case discountPrice = "discount_price"
        case qty = "qty"
        case image = "image"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        //discountPrice = try values.decodeIfPresent(Int.self, forKey: .discountPrice)
       // discount_price = String((try values.decodeIfPresent(Int.self, forKey: .discount_price)) ?? 0)
        qty = try values.decodeIfPresent(Int.self, forKey: .qty)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
    
}
