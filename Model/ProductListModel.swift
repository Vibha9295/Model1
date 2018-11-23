
import Foundation
struct ProductListModel : Codable {
	let status : Int?
	let message : String?
	let total_page : Int?
	let totalProducts : Int?
	let dataProductList : [DataProductListModel]?
	let filters : FilterModel?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case total_page = "total_page"
		case totalProducts = "totalProducts"
		case dataProductList = "data"
		case filters = "filters"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		total_page = try values.decodeIfPresent(Int.self, forKey: .total_page)
		totalProducts = try values.decodeIfPresent(Int.self, forKey: .totalProducts)
		dataProductList = try values.decodeIfPresent([DataProductListModel].self, forKey: .dataProductList)
		filters = try values.decodeIfPresent(FilterModel.self, forKey: .filters)
	}

}
struct DataProductListModel : Codable {
    let prod_id : Int?
    let name : String?
    let sku : String?
    let price : Float?
    let discount_price : Float?
//    let in_stock : Int?
    let description : String?
    let image_url : String?
    let thumbnail_imageurl : String?
    let prod_in_cart : Int?
    let multiple_images : [MultipleImageModel]?
    var wishlist : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case prod_id = "prod_id"
        case name = "name"
        case sku = "sku"
        case price = "price"
        case discount_price = "discount_price"
//        case in_stock = "in_stock"
        case description = "description"
        case image_url = "image_url"
        case thumbnail_imageurl = "thumbnail_imageurl"
        case prod_in_cart = "prod_in_cart"
        case multiple_images = "multiple_images"
        case wishlist = "wishlist"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        prod_id = try values.decodeIfPresent(Int.self, forKey: .prod_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        price = try values.decodeIfPresent(Float.self, forKey: .price)
        discount_price = try values.decodeIfPresent(Float.self, forKey: .discount_price)
//        in_stock = try values.decodeIfPresent(Int.self, forKey: .in_stock)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        thumbnail_imageurl = try values.decodeIfPresent(String.self, forKey: .thumbnail_imageurl)
        prod_in_cart = try values.decodeIfPresent(Int.self, forKey: .prod_in_cart)
        multiple_images = try values.decodeIfPresent([MultipleImageModel].self, forKey: .multiple_images)
        wishlist = try values.decodeIfPresent(Bool.self, forKey: .wishlist)
    }
    
}
struct MultipleImageModel : Codable {
    let multiple : String?
    
    enum CodingKeys: String, CodingKey {
        
        case multiple = "multiple"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        multiple = try values.decodeIfPresent(String.self, forKey: .multiple)
    }
    
}
struct FilterModel : Codable {
    let priceRange : PriceRangeModel?
    let priceRangeApplied : PriceRangeAppliedModel?
    let attributes : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case priceRange = "priceRange"
        case priceRangeApplied = "priceRangeApplied"
        case attributes = "attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        priceRange = try values.decodeIfPresent(PriceRangeModel.self, forKey: .priceRange)
        priceRangeApplied = try values.decodeIfPresent(PriceRangeAppliedModel.self, forKey: .priceRangeApplied)
        attributes = try values.decodeIfPresent([String].self, forKey: .attributes)
    }
    
}
struct PriceRangeModel : Codable {
    let minPrice : Int?
    let maxPrice : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case minPrice = "minPrice"
        case maxPrice = "maxPrice"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        minPrice = try values.decodeIfPresent(Int.self, forKey: .minPrice)
        maxPrice = try values.decodeIfPresent(Int.self, forKey: .maxPrice)
    }
    
}
struct PriceRangeAppliedModel : Codable {
    let minPrice : Int?
    let maxPrice : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case minPrice = "minPrice"
        case maxPrice = "maxPrice"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        minPrice = try values.decodeIfPresent(Int.self, forKey: .minPrice)
        maxPrice = try values.decodeIfPresent(Int.self, forKey: .maxPrice)
    }
    
}
