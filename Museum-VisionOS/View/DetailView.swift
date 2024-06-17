//
//  DetailView.swift
//  Museum-VisionOS
//
//  Created by Abhishek on 17/06/24.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @State var title: String

    @Environment(\.dismissWindow) private var dismissWindow
    var body: some View {
        VStack(spacing: 50) {
            if title.contains(Constants.EntityNames.milos_plaster_cast) {
                Text("Aphrodite of Milos")
                    .font(.extraLargeTitle)
                    .bold()

                Text("The original Greek statue was found in 1820 on the Cycladic island of Milos (ancient Greek: Μῆλος, pronounced: Mêlos modern Greek: Μήλος, pronounced: Mýlos) and purchased by Marquis de Rivière, who, back then, was the ambassador of France in Istanbul. He gave the sculpture to Louis XVIII, who, in the following year, handed it over to the Louvre, where it remains to this day. The Aphrodite of Milos became part of the French national collection of antiques, which was to compete with the collections of the British Museum, slightly earlier enriched with the Elgin Marbles: sculptures and reliefs imported from the Acropolis in Athens by Thomas Bruce, 7th Earl of Elgin. The statue of Aphrodite was made of several blocks of marble joined together. This technique was often used in the Cyclades.")
                    .font(.title)

            } else if title.contains(Constants.EntityNames.ryzhanovka) {
                Text("Scythian princess from Ryzhanovka")
                    .font(.extraLargeTitle)
                    .bold()

                Text("Since 1887 the collection of the Archaeological Museum of Kraków has boasted the equipment of a rich Scythian female tomb situated under the mound of a kurgan, examined in Ryzhanovka near Zvenyhorodka in Ukraine by Gotfryd Ossowski, the first curator of the Museum of National Antiquities (from which today’s Archaeological Museum has originated) at the Polish Academy of Arts and Sciences in Kraków. The female skeleton discovered in this tomb was strewn with gold decorations being appliqués of a parade costume as well as with jewels (over 440 items). Next to it, there were various vessels and objects lying on the ground, including the silver mug presented on our website. In 1999, the Archaeological Museum of Kraków prepared the exhibition, Tutanchamon ukraińskich stepów [Tutankhamun of the Ukrainian Grasslands], dedicated to the results of the research on this kurgan conducted in 1995–1998 by the expedition organised by the Institute of Archaeology.")
                    .font(.title)
            } else {
                Text("St. Onuphrius")
                    .font(.extraLargeTitle)
                    .bold()

                Text("Onuphrius (Greek: Ὀνούφριος, romanized: Onouphrios; also Onoufrios) lived as a hermit in the desert of Upper Egypt in the 4th or 5th centuries. He is venerated as Saint Onuphrius in both the Roman Catholic and Eastern Catholic churches, as Venerable Onuphrius in Eastern Orthodoxy, and as Saint Nofer the Anchorite in Oriental Orthodoxy. Onuphrius was one of the Desert Fathers who made a great impression on Eastern spirituality in the third and fourth centuries, around the time that Christianity was emerging as the dominant faith of the Roman Empire. At this time many Christians were inspired to go out into the desert and live in prayer in the harsh environment of extreme heat and cold, with little to eat and drink, surrounded by all sorts of dangerous animals and robbers.")
                    .font(.title)
            }
            Button {
                dismissWindow(id: "DetailView")
            } label: {
                Text("Close")
                    .tint(Color.red)
            }
        }
        .padding()
    }
}


struct LearnMoreButtonView: View {
  var body: some View {
    Text("Know more")
      .font(.extraLargeTitle)
      .tint(.blue)
      .padding([.vertical, .horizontal], 50)
      .glassBackgroundEffect()
  }
}

