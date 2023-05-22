//
//  ActivityRingView.swift
//  Amere.App
//
//  Created by Jahaira Maxwell-Myers on 5/22/23.
//
import SwiftUI

struct RingsView: View {
    // Properties storing the completion progress of the three rings
    @State private var firstRingProgress: CGFloat = 0.3
    @State private var secondRingProgress: CGFloat = 0.5
    @State private var thirdRingProgress: CGFloat = 0.6
    let circleLineWidth: CGFloat = 20

    var body: some View {
        ZStack {
            Color.black
            
            /// The three circles are stacked in a ZStack. You can plug in whatever colors you need. Make sure to plug in the darker shade as the first color and the lighter shade as the second color. The radius of the circle will dicate how large it is and the line width will configure how thick the stroke of the circle is
            ActivityRingView(progress: $firstRingProgress, gradientColors: [.darkBlue, .lightBlue], outlineColor: .outlineBlue, radius: 150, lineWidth: circleLineWidth)
                .fixedSize()
            ActivityRingView(progress: $secondRingProgress, gradientColors: [.darkGreen, .lightGreen], outlineColor: .outlineGreen, radius: 128, lineWidth: circleLineWidth)
                .fixedSize()
            ActivityRingView(progress: $thirdRingProgress, gradientColors: [.darkYellow, .lightYellow], outlineColor: .outlineYellow, radius: 105, lineWidth: circleLineWidth)
                .fixedSize()
            
            // Button that increments the rings progress value (just a demo to show the animation)
            VStack {
                Spacer()
                Button("Increment Ring") {
                    firstRingProgress += 0.1
                    secondRingProgress += 0.1
                    thirdRingProgress += 0.1
                }
                .padding()
            }
        }
    }
}


struct RingsView_Previews: PreviewProvider {
    static var previews: some View {
        RingsView()
    }
}
