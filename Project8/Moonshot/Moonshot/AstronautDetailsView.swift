//
//  AstronautDetailsView.swift
//  Moonshot
//
//  Created by Manas Aggarwal on 29/04/21.
//

import SwiftUI

struct AstronautDetailsView: View {
    
    var crewMember: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(crewMember.id)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(crewMember.description)
                    .layoutPriority(1)
                    .padding()
                
                Spacer(minLength: 25)
            }
        }
        .navigationBarTitle(Text(crewMember.name), displayMode: .inline)
    }
}

struct AstronautDetailsView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautDetailsView(crewMember: astronauts[1])
    }
}
