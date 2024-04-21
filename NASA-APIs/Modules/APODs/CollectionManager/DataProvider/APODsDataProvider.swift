
import Foundation

struct APODsDataProvider {
    var dateSelectSection: APODsSection =
        .init(title: "Pick date",
              items: [
                .init(type: .dataSelectItemType(type: .init(type: .today))),
                .init(type: .dataSelectItemType(type: .init(type: .week))),
                .init(type: .dataSelectItemType(type: .init(type: .month))),
                .init(type: .dataSelectItemType(type: .init(type: .year))),
                .init(type: .dataSelectItemType(type: .init(type: .custom))),
              ],
              type: .dataSelectType)
    
}
