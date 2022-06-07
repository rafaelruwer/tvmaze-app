import Foundation
import SwiftyJSON

class TVMazeResponseDecoder {
    
    private static var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
    
    func decodeShow(json: JSON) -> Show? {
        guard let id = json["id"].int,
              let title = json["name"].string,
              let poster = decodeImageRef(json: json["image"]) else {
            return nil
        }
        
        // some shows come with empty values for both `time` and `days` fields e.g. streaming series
        // for these cases, parse as if the show's schedule is unknown
        let schedule = Schedule(time: json["schedule"]["time"].stringValue,
                                days: json["schedule"]["days"].arrayValue.map(\.stringValue))
        let isValidSchedule = !schedule.time.isEmpty || !schedule.days.isEmpty
        
        let network = json["network"]["name"].string ?? json["webChannel"]["name"].string ?? ""
        let releaseDate = Self.dateFormatter.date(from: json["premiered"].stringValue)
        let endDate = Self.dateFormatter.date(from: json["ended"].stringValue)
        
        return Show(id: id,
                    title: title,
                    summary: json["summary"].stringValue,
                    genres: json["genres"].arrayValue.compactMap(\.string),
                    schedule: isValidSchedule ? schedule : nil,
                    network: network,
                    releaseDate: releaseDate ?? Date(),
                    endDate: endDate,
                    rating: json["rating"]["average"].double,
                    poster: poster)
    }
    
    func decodeImageRef(json: JSON) -> ImageRef? {
        guard let mediumUrl = json["medium"].url, let originalUrl = json["original"].url else {
            return nil
        }
        
        return ImageRef(thumbnail: mediumUrl, original: originalUrl)
    }
    
}
