import Foundation

enum FormatterUtils {
    
    // MARK: Schedule
    
    private static let daysOfTheWeek: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    static func formatSchedule(_ schedule: Schedule) -> String {
        var components = [String]()
        
        let days = schedule.days.map { dayOfTheWeek -> String in
            let index = daysOfTheWeek.firstIndex(of: dayOfTheWeek) ?? -1
            let date = Calendar.current.date(bySetting: .weekday, value: index + 1, of: Date())
            let shortWeekDay = date?.formatted(.dateTime.weekday(.abbreviated))
            
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
            
            let time = date?.formatted(date: .omitted, time: .shortened)
            let fallback = schedule.time
            
            components.append(time ?? fallback)
        }
        
        return components.joined(separator: ", ")
    }
    
    // MARK: - Years active
    
    static func formatYearsActive(releaseDate: Date, endDate: Date?) -> String {
        let releaseYear = Calendar.current.component(.year, from: releaseDate)
        let endYear = endDate.map { Calendar.current.component(.year, from: $0) }
        
        if let endYear = endYear {
            return "\(releaseYear)-\(endYear)"
        } else {
            return "\(releaseYear)-current"
        }
    }
    
    // MARK: - Runtime
    
    private static var runtimeFormatter: MeasurementFormatter = {
        let mf = MeasurementFormatter()
        mf.unitStyle = .medium
        mf.unitOptions = .naturalScale
        return mf
    }()
    
    static func formatRuntime(_ runtime: Int) -> String {
        let minutes = Measurement(value: Double(runtime), unit: UnitDuration.minutes)
        return runtimeFormatter.string(from: minutes)
    }
    
    // MARK: - Remove HTML tags
    
    static func removeHTMLTags(from text: String) -> String {
        let textData = Data(text.utf8)
        let htmlString = try? NSAttributedString(data: textData,
                                                 options: [.documentType: NSAttributedString.DocumentType.html],
                                                 documentAttributes: nil)
        let noTagsString = htmlString?.string ?? text
        return noTagsString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
