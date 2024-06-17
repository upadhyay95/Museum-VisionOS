//
//  Constants.swift
//  Museum-VisionOS
//
//  Created by Abhishek on 16/06/24.
//

struct Constants {
    struct WelcomeScreen {
        static let title = "Welcome to the Interactive Immersive Museum!"
        static let welcomeMessage = """
        We are thrilled to have you embark on a journey through time and space with us. Our app is designed to bring history and art to life in ways you've never experienced before.
        
        As you explore our virtual exhibits, you'll find yourself immersed in stunning 3D models, detailed reconstructions, and interactive narratives that will transport you to different eras and cultures.
        
        Are you ready to start your adventure? Click "Yes, I'm ready!" to begin your journey into the past. Let the exploration begin!
        """
        static let toggleLabel = "Yes, I'm ready!"
        static let toggleHint = "Toggles the immersive museum experience on or off"
    }
    
    struct EntityNames {
        static let dancingMan = "dancing_man"
        static let immersiveView = "Immersive"
        static let ryzhanovka = "ryzhanovka"
        static let milos_plaster_cast = "milos_plaster_cast"
        static let sculpture_st = "sculpture_st"
        static let imageBasedLight = "ImageBasedLight"
    }
    
    struct EntityGroup {
        static let ryzhanoka_group = "ryzhanoka_group"
        static let sculpture_group = "sculpture_group"
        static let milos_group = "milos_group"
    }
    
    struct ChestNames {
        static let chest_ryzhanovka = "chest_ryzhanovka"
        static let chest_sculpture = "chest_sculpture"
        static let chest_milos = "chest_milos"
    }
    
    struct ViewAndSpaceIDs {
        static let welcomeView = "WelcomeView"
        static let detailView = "DetailView"
        static let immersiveSpace = "ImmersiveSpace"
    }
}
