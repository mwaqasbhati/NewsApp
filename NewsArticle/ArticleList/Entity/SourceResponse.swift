/* 


*/

import Foundation

struct SourceResponse : Codable {
	let status : String?
	let sources : [Sources]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case sources = "sources"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		sources = try values.decodeIfPresent([Sources].self, forKey: .sources)
	}

}
