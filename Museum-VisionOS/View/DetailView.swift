//
//  DetailView.swift
//  Museum-VisionOS
//
//  Created by Abhishek on 17/06/24.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent

struct DetailView: View {
    @State var title: String
    
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        VStack(spacing: 50) {
            // Display content based on the title
            contentForTitle(title)
            
            // Close button
            Button(action: {
                dismissWindow(id: Constants.ViewAndSpaceIDs.detailView)
            }) {
                Text(Constants.DetailsScreen.closeText)
                    .font(.title2)
                    .padding()
            }
            .glassBackgroundEffect()
            .accessibilityLabel("Close Button")
            .accessibilityHint("Closes the detail view")
        }
        .padding()
        .background(LinearGradient(gradient: Constants.GradientBG.mountainRock,
                                   startPoint: .leading,
                                   endPoint: .trailing))
        .cornerRadius(10)
    }
    
    /// Returns the content view for a given title
    @ViewBuilder
    private func contentForTitle(_ title: String) -> some View {
        if title.contains(Constants.EntityNames.milos_plaster_cast) {
            titleView("Aphrodite of Milos", content: milosContent, modelName: Constants.DetailsEntityNames.milos_plaster_cast)
        } else if title.contains(Constants.EntityNames.ryzhanovka) {
            titleView("Scythian Princess from Ryzhanovka", content: ryzhanovkaContent, modelName: Constants.DetailsEntityNames.ryzhanovka)
        } else {
            titleView("St. Onuphrius", content: stOnuphriusContent, modelName: Constants.DetailsEntityNames.sculpture_st)
        }
    }
    
    /// Title view with dynamic content
    private func titleView(_ title: String, content: String, modelName: String) -> some View {
        HStack{
            RealityView { realityViewContent in
                //Sculpture_St.usdz
                //ryzhanovka.usdz
                //Milos_plaster_cast
                async let drummer = Entity(named: modelName, in: realityKitContentBundle)
                
                if let drummerEntity = try? await drummer {
                    try? await drummer.scale = SIMD3(x: Float(0.001), y: Float(0.001), z: Float(0.001))
                    realityViewContent.add(drummerEntity)
                    
                    // Add light for the immersive resource
                    guard let resource = try? await EnvironmentResource(named: Constants.EntityNames.imageBasedLight) else {
                        return
                    }
                    let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.5)
                    try? await drummer.components.set(iblComponent)
                    try? await drummer.components.set(ImageBasedLightReceiverComponent(imageBasedLight: drummer))
                    
                }
            } update: { realityViewContent in
                if let scene = realityViewContent.entities.first {
                    scene.availableAnimations.forEach { animation in
                        scene.playAnimation(animation.repeat(), transitionDuration: 3, startsPaused: false)
                    }
                    // step 25
                    let orbit = OrbitAnimation(duration: 10.0,
                                               axis: SIMD3<Float>(x: 0, y: 1.0, z: 0.0),
                                               startTransform: scene.transform,
                                               spinClockwise: true,
                                               orientToPath: true,
                                               rotationCount: 1.0,
                                               bindTarget: .transform,
                                               repeatMode: .repeat)
                    
                    if let animation = try? AnimationResource.generate(with: orbit) {
                        scene.playAnimation(animation)
                    }
                }
            }
            ScrollView {
                VStack(spacing: 20) {
                    Text(title)
                        .font(.extraLargeTitle)
                        .bold()
                        .accessibilityLabel("\(title) Header")
                        .accessibilityAddTraits(.isHeader)
                    
                    Text(content)
                        .font(.title2)
                        .accessibilityLabel("\(title) Description")
                }
            }
        }
        .padding()
    }
    
    // Content for each section
    private var milosContent: String {
        """
        The original Greek statue was found in 1820 on the Cycladic island of Milos (ancient Greek: Μῆλος, pronounced: Mêlos modern Greek: Μήλος, pronounced: Mýlos) and purchased by Marquis de Rivière, who, back then, was the ambassador of France in Istanbul. He gave the sculpture to Louis XVIII, who, in the following year, handed it over to the Louvre, where it remains to this day. The Aphrodite of Milos became part of the French national collection of antiques, which was to compete with the collections of the British Museum, slightly earlier enriched with the Elgin Marbles: sculptures and reliefs imported from the Acropolis in Athens by Thomas Bruce, 7th Earl of Elgin. The statue of Aphrodite was made of several blocks of marble joined together. This technique was often used in the Cyclades.
        """
    }
    
    private var ryzhanovkaContent: String {
        """
        Since 1887 the collection of the Archaeological Museum of Kraków has boasted the equipment of a rich Scythian female tomb situated under the mound of a kurgan, examined in Ryzhanovka near Zvenyhorodka in Ukraine by Gotfryd Ossowski, the first curator of the Museum of National Antiquities (from which today’s Archaeological Museum has originated) at the Polish Academy of Arts and Sciences in Kraków. The female skeleton discovered in this tomb was strewn with gold decorations being appliqués of a parade costume as well as with jewels (over 440 items). Next to it, there were various vessels and objects lying on the ground, including the silver mug presented on our website. In 1999, the Archaeological Museum of Kraków prepared the exhibition, Tutanchamon ukraińskich stepów [Tutankhamun of the Ukrainian Grasslands], dedicated to the results of the research on this kurgan conducted in 1995–1998 by the expedition organised by the Institute of Archaeology.
        """
    }
    
    private var stOnuphriusContent: String {
        """
        Onuphrius (Greek: Ὀνούφριος, romanized: Onouphrios; also Onoufrios) lived as a hermit in the desert of Upper Egypt in the 4th or 5th centuries. He is venerated as Saint Onuphrius in both the Roman Catholic and Eastern Catholic churches, as Venerable Onuphrius in Eastern Orthodoxy, and as Saint Nofer the Anchorite in Oriental Orthodoxy. Onuphrius was one of the Desert Fathers who made a great impression on Eastern spirituality in the third and fourth centuries, around the time that Christianity was emerging as the dominant faith of the Roman Empire. At this time many Christians were inspired to go out into the desert and live in prayer in the harsh environment of extreme heat and cold, with little to eat and drink, surrounded by all sorts of dangerous animals and robbers.
        """
    }
}

#Preview {
    DetailView(title: Constants.EntityNames.ryzhanovka)
}
