
import Foundation

struct APODsDataProvider {
    static let mockURL = URL(string: "https://media.cnn.com/api/v1/images/stellar/prod/181115180453-01-mars-best-moments-mars-globe-valles-marineris-enhanced.jpg?q=w_2500,h_1406,x_0,y_0,c_fill")
    static let mockURL1 = URL(string: "https://adminassets.devops.arabiaweather.com/sites/default/files/field/image/Detecting%20the%20source%20of%20a%20giant%20earthquake%20that%20struck%20Mars%20arabia%20weather.jpg")

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

    var picturesSection: APODsSection =
        .init(title: "",
              items: [
                .init(type: .imageItemType(type: .init(title: "Test data", imageUrl: mockURL))),
                .init(type: .imageItemType(type: .init(title: "Test data1", imageUrl: mockURL))),
                .init(type: .imageItemType(type: .init(title: "Test data2", imageUrl: mockURL))),
                .init(type: .imageItemType(type: .init(title: "Test data2", imageUrl: mockURL))),
                .init(type: .imageItemType(type: .init(title: "Test data2", imageUrl: mockURL1))),

              ],
              type: .pictures)

}
