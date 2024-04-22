import Foundation

struct APODsCellItem: Hashable {
    let id = UUID()
    let type: APODsItemType
}


enum APODsItemType: Hashable {
    case dataSelectItemType(type: APODsDateSelectItemModel)
    case imageItemType(type: APODsImageItemModel)
}

struct APODsDateSelectItemModel: Hashable {
    let id = UUID()
    let type: APODsDateSelectItemModelType
    
    var selected: Bool = false

    init(type: APODsDateSelectItemModelType, selected: Bool = false) {
        self.type = type
        self.selected = selected
    }
}

struct APODsImageItemModel: Hashable {
    let id = UUID()
    let title: String
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
