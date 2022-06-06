import SwiftyJSON

class TVMazeResponseDecoder {
    
    func decodeShow(json: JSON) -> Show? {
        guard let id = json["id"].int, let title = json["name"].string else {
            return nil
        }
        
        // some shows come with empty values for both `time` and `days` fields e.g. streaming series
        // for these cases, parse as if the show's schedule is unknown
        let schedule = Schedule(time: json["schedule"]["time"].stringValue,
                                days: json["schedule"]["days"].arrayValue.map(\.stringValue))
        let isValidSchedule = !schedule.time.isEmpty || !schedule.days.isEmpty
        
        guard let poster = decodeImageRef(json: json["image"]) else {
            return nil
        }
        
        return Show(id: id,
                    title: title,
                    summary: json["summary"].stringValue,
                    genres: json["genres"].arrayValue.compactMap(\.string),
                    schedule: isValidSchedule ? schedule : nil,
                    poster: poster)
    }
    
    func decodeImageRef(json: JSON) -> ImageRef? {
        guard let mediumUrl = json["medium"].url, let originalUrl = json["original"].url else {
            return nil
        }
        
        return ImageRef(thumbnail: mediumUrl, original: originalUrl)
    }
    
}
