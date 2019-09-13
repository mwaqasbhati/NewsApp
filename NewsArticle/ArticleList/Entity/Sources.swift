/* 

*/

import Foundation

struct Sources : Codable {
	let id : String?
	let name : String?
	let description : String?
	let url : String?
	let category : String?
	let language : String?
	let country : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case description = "description"
		case url = "url"
		case category = "category"
		case language = "language"
		case country = "country"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		country = try values.decodeIfPresent(String.self, forKey: .country)
	}

}
