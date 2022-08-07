import Foundation

extension Int {
    
    func incrementWeekDays(by num: Int) -> Int {
        let incrementedVal = self + num
        let mod = incrementedVal % 7
        
        return mod
    }
    
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        let weekDayComponent = components.weekday! - 1
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.weekdaySymbols[weekDayComponent]
    }
    
    func getHourStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "HH"
        
        return dateFormatter.string(from: date)
    }
}

