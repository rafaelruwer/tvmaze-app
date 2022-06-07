import Foundation

struct ShowSearchResultCellViewModel {
    
    private let show: Show
    
    init(show: Show) {
        self.show = show
    }
    
    var posterUrl: URL {
        show.poster.thumbnail
    }
    
    var title: String {
        show.title
    }
    
    var airDate: String {
        let releaseYear = Calendar.current.component(.year, from: show.releaseDate)
        let endYear = show.endDate.map { Calendar.current.component(.year, from: $0) }
        
        if let endYear = endYear {
            return "\(releaseYear)-\(endYear)"
        } else {
            return "\(releaseYear)-current"
        }
    }
    
    var info: String {
        if let schedule = show.schedule {
            var components = [String]()
            
            let days = schedule.days.map { dayOfTheWeek -> String in
                let index = Self.daysOfTheWeek.firstIndex(of: dayOfTheWeek) ?? -1
                let date = Calendar.current.date(bySetting: .weekday, value: index + 1, of: Date())
                let shortWeekDay = date.flatMap(Self.weekDayFormatter.string(from:))
                
                let fallback = dayOfTheWeek[..<dayOfTheWeek.index(dayOfTheWeek.startIndex, offsetBy: 3)]
                
                return shortWeekDay ?? "\(fallback)"
            }
            
            components.append(contentsOf: days)
            
            // time
            if !schedule.time.isEmpty {
                let hour = schedule.time.split(separator: ":").first.flatMap { Int($0) }
                let minute = schedule.time.split(separator: ":").last.flatMap { Int($0) }
                
                var calendar = Calendar.current
                calendar.timeZone = TimeZone(identifier: "UTC") ?? .current
                let date = calendar.date(bySettingHour: hour ?? 0, minute: minute ?? 0, second: 0, of: Date())
                
                let time = date.flatMap(Self.timeFormatter.string(from:))
                let fallback = schedule.time
                
                components.append(time ?? fallback)
            }
            
            return "\(components.joined(separator: ", ")) @ \(show.network)"
        } else {
            return show.network
        }
    }
    
    private static let daysOfTheWeek: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    private static var weekDayFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "E"
        return df
    }()
    
    private static var timeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: "UTC")
        df.dateStyle = .none
        df.timeStyle = .short
        return df
    }()
    
}
