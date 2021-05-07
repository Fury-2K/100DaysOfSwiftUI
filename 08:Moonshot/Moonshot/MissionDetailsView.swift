//
//  MissionDetailsView.swift
//  Moonshot
//
//  Created by Manas Aggarwal on 29/04/21.
//

import SwiftUI

struct MissionDetailsView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    var mission: Mission
    var astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission

        var matches: [CrewMember] = []

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width * 0.8)
                    
                    Text(mission.formattedLaunchDate)
                        .foregroundColor(.secondary)
                    
                    Text(mission.description)
                        .layoutPriority(1)
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautDetailsView(crewMember: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                        }
                    }
                    
                    Spacer(minLength: 25)
                }
                .padding()
            }
            .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
        }
    }
}

struct MissionDetailsView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionDetailsView(mission: missions[1], astronauts: astronauts)
    }
}
