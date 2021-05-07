//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Manas Aggarwal on 04/05/21.
//

import SwiftUI


// --------------------------
// MARK:- Steps to use @Published with Codable
// --------------------------


class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name: String = "Manas"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}


// --------------------------
// MARK:- Codable with URLSession
// --------------------------


struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}


// --------------------------
// MARK:- Validating & Form Disabling
// --------------------------


struct ContentView: View {
    // MARK:- Validating & Form Disabling
    /*
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
//            .disabled(username.isEmpty || email.isEmpty)
            .disabled(disableForm)

        }
    }
    */
    
    // MARK:- Itunes API Codable and URLSession
    /*
    @State var results: [Result] = []

    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }

                    return
                }
            }

            print("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
        }.resume()
    }

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
    */
    
    // MARK:- Main Project HomePage
    
    var body: some View {
        OrderView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
