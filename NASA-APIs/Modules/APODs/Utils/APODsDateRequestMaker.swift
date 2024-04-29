
import Foundation

enum APODsDateRequestMaker {
    case day
    case week
    case month
    case year
    case custom(_ outputResult: APODsDatePickerModuleOutputResult)

    var request: PODsServiceRequest {
        switch self {
        case .day:
            return makeDayRequest()
        case .week:
            return makeWeekRequest()
        case .month:
            return makeMonthRequest()
        case .year:
            return makeYearRequest()
        case .custom(let outputResult):
            return makeCustomRequest(with: outputResult)
        }
    }

    private func makeDayRequest() -> PODsServiceRequest {
        let date = Date()
        return .init(startDate: format(date: date), endDate: format(date: date))
    }

    private func makeWeekRequest() -> PODsServiceRequest {
        let until = Date()
        let from = Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: until)
        return .init(startDate: format(date: from ?? Date()), endDate: format(date: until))
    }

    private func makeMonthRequest() -> PODsServiceRequest {
        let until = Date()
        let from = Calendar.current.date(byAdding: .month, value: -1, to: until)
        return .init(startDate: format(date: from ?? Date()), endDate: format(date: until))
    }

    private func makeYearRequest() -> PODsServiceRequest {
        let until = Date()
        let from = Calendar.current.date(byAdding: .year, value: -1, to: until)
        return .init(startDate: format(date: from ?? Date()), endDate: format(date: until))
    }

    private func makeCustomRequest(with outputResult: APODsDatePickerModuleOutputResult) -> PODsServiceRequest {
        let from = outputResult.fromDate
        let until = outputResult.toDate
        return .init(startDate: format(date: from), endDate: format(date: until))
    }

    private func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

}
