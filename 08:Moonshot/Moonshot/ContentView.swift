//
//  ContentView.swift
//  Moonshot
//
//  Created by Manas Aggarwal on 28/04/21.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var isDate: Bool = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionDetailsView(mission: mission, astronauts: astronauts)) {
                    HStack(spacing: 12) {
                        Image(mission.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(mission.displayName)
                                .fontWeight(.bold)
                            if isDate {
                                Text(mission.formattedLaunchDate)
                            } else {
                                ForEach(mission.crew, id: \.name) { crewMember in
                                    Text(crewMember.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Moonshot")
            .navigationBarItems(
                trailing: Button(isDate ? "Crew" : "Date") { isDate.toggle() }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
