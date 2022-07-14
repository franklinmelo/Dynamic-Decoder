import Foundation

protocol Vehicle: Decodable {}

struct VehicleData: Decodable {
    let name: String
    let brand: String
}

struct VehicleCore: Decodable {
    let vehicle: VehicleData
    let body: VehicleBodyData
}

struct VehicleBodyData: Decodable {
    let type: VehicleBodyType
    let data: Vehicle
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(VehicleBodyType.self, forKey: .type)
        let dataDecoder = try container.superDecoder(forKey: .data)
        data = try type.metaType.init(from: dataDecoder)
    }
}

enum VehicleBodyType: String, Decodable {
    case moto
    
    var metaType: Vehicle.Type {
        switch self {
        case .moto:
            return MotoModel.self
        }
    }
}

struct MotoModel: Vehicle {
    let color: String
    let horsePower: Int
    let cylinderd: Int
}

public class Service {
    func loadJson() -> VehicleCore? {
        if let url = Bundle.main.url(forResource: "Test", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try decoder.decode(VehicleCore.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

let moto = Service().loadJson()
print("name \(moto?.vehicle.name)")
print("brand \(moto?.vehicle.brand)")
print("type \(moto?.body.type.rawValue)")
print("data \(moto?.body.data.self)")
