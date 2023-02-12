//
//  Nonetwork.swift
//  FoodClub
//
//  Created by Ahasun on 1/27/23.
//

import SwiftUI

struct Nonetwork: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("no-wifi")
                    .resizable()
                    .frame(width: geometry.size.width / 3, height: geometry.size.height / 4.6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("No Internet")
                    .font(.largeTitle)
                    .foregroundColor(Color(#colorLiteral(red: 0.05316243321, green: 0.1178671643, blue: 0.2198717892, alpha: 1)))
                    .bold()
                    .padding(.top,20)
                Text("Please check your internet connection, turn on your network connection and try again.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .bold()
                    .padding(.top,8)
                    .padding(.bottom,12)
                    .padding(.horizontal,26)
                    .multilineTextAlignment(.center)
                Button(action: {
                    exit(0)
                }, label: {
                    Text("Close")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                })
                .padding(.horizontal,40)
                .padding(.vertical,10)
                .background(Color(#colorLiteral(red: 0.05316243321, green: 0.1178671643, blue: 0.2198717892, alpha: 1)))
                .clipShape(Capsule())
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
        }
    }

}

struct Nonetwork_Previews: PreviewProvider {
    static var previews: some View {
        Nonetwork()
    }
}
