import Foundation

struct APODsCellItem: Hashable {
    let id: UUID
    let type: APODsItemType

    init(id: UUID = UUID(), type: APODsItemType) {
        self.type = type
        self.id = id
    }
}

enum APODsItemType: Hashable {
    case dataSelectItemType(type: APODsDateSelectItemModel)
    case imageItemType(type: APODsImageItemModel)
}

struct APODsDateSelectItemModel: Hashable {
    let id = UUID()
    let type: APODsDateSelectItemModelType
    
    var selected: Bool = false

    var fromDate: String?
    var untilDate: String?

    init(type: APODsDateSelectItemModelType, 
         selected: Bool = false,
         fromDate: String? = nil,
         untilDate: String? = nil
    ) {
        self.type = type
        self.selected = selected
        self.fromDate = fromDate
        self.untilDate = untilDate
    }
}

struct APODsImageItemModel: Hashable {
    let id = UUID()
    let title: String
    let bodyText: String
    let imageUrl: URL?
}


enum APODsDateSelectItemModelType {
    case today
    case week
    case month
    case year
    case custom

    var description: String {
        switch self {
        case .today:
            return "Today"
        case .week:
            return "Week"
        case .month:
            return "Month"
        case .year:
            return "Year"
        case .custom:
            return ""
        }
    }
}
