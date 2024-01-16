//
//  MeditationView.swift
//  meditation
//
//  Created by Иван Чернокнижников on 16.01.2024.
//

import SwiftUI

struct MeditationView: View {
    @State private var showPlayer = false
    @StateObject var meditationVM: MeditationViewModel
    var body: some View {
        VStack {
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height / 3)
            
            // Details
            
            ZStack {
                Color(red: 24/255, green: 23/255, blue: 22/255)
                VStack(alignment: .leading,spacing: 24) {
                    // Duration & Type
                    VStack(alignment: .leading,spacing: 8) {
                        Text("Music")
                        Text( DateComponentsFormatter.abbreviated.string(from: meditationVM.meditation.duration) ?? 
                            meditationVM.meditation.duration.formatted() + "s")
                    }
                   
                    .font(.subheadline)
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                    .opacity(0.7)
                    
                    // Title
                    Text(meditationVM.meditation.title)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Button {
                        showPlayer = true
                    } label: {
                         Label("Play",systemImage: "play.fill")
                            .font(.headline)
                            .foregroundStyle(.black)
                            .padding(.vertical,10)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(.white)
                            .cornerRadius(20)
                    }
                    
                    // Description
                    Text(meditationVM.meditation.description)
                    
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(20)
                
            }
            .frame(height: UIScreen.main.bounds.height  * 2 / 3)
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showPlayer) {
            PlayerView(meditationVM: meditationVM)
        }
    }
    
    
}

#Preview {

    MeditationView(meditationVM: MeditationViewModel(meditation: Meditation.data))
}
