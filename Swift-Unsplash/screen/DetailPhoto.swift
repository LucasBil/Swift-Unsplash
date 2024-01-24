//
//  DetailPhoto.swift
//  Swift-Unsplash
//
//  Created by Lucas BILLY on 1/24/24.
//

import SwiftUI

struct DetailPhoto: View {
    let photo : UnsplashPhoto
    @State var screenResolution : ScreenResolution = ScreenResolution.small
    
    var body: some View {
        NavigationStack{
            HStack{
                Spacer().frame(width: 8)
                VStack{
                    Picker("Type", selection: $screenResolution) {
                        ForEach(ScreenResolution.allCases, id: \.self) { resolution in
                            Text(resolution.rawValue)
                        }
                    }
                    .pickerStyle(PalettePickerStyle())
                    ZStack{
                        AsyncImage(url: URL(string: screenResolution.getPhotoResolution(photo: photo))!){ image in
                            image
                                .centerCropped()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } placeholder: {
                            ProgressView()
                        }
                        
                        HStack{
                            VStack{
                                AsyncImage(url: URL(string: photo.user.profile_image.large)!){ profil in
                                    profil
                                        .centerCropped()
                                } placeholder: {
                                    ProgressView()
                                }
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                                Spacer()
                            }
                            Spacer()
                        }
                        
                    }
                    
                }
                Spacer().frame(width: 8)
            }
            .navigationBarTitle("Une image de @\(photo.user.name)")
        }
    }
}

#Preview {
    DetailPhoto(photo: UnsplashPhoto(id: "img",slug: "slug_image",user: User(name: "hop", profile_image: ProfileImage(small: "https://media1.tenor.com/m/o0lrdNm2BawAAAAC/aqua-cry-cute-aqua.gif", medium: "https://media1.tenor.com/m/o0lrdNm2BawAAAAC/aqua-cry-cute-aqua.gif", large: "https://media1.tenor.com/m/o0lrdNm2BawAAAAC/aqua-cry-cute-aqua.gif")),urls: UnsplashPhotoUrls(raw: "raw",full: "full",regular: "regular",small: "https://ih1.redbubble.net/image.1834907813.4926/raf,360x360,075,t,fafafa:ca443f4786.jpg",thumb: "thumb")))
}
