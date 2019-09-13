/* 

*/

import Foundation

struct NewsResponse : Codable {
	let status : String?
	let totalResults : Int?
	let news : [News]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case totalResults = "totalResults"
		case news = "articles"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
		news = try values.decodeIfPresent([News].self, forKey: .news)
	}

}
