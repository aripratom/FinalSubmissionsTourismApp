//
//  ToursimDetailView.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertToast
import Tourism
import Cleanse
import SwiftUIX

struct TourismDetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var presenter: TourismDetailPresenter
    @ObservedObject var updatePresenter: TourismUpdatePresenter
      
    @State private var alerta: AlertInfo?
    
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        image
                        VStack {
                            address
                            spacer
                            content
                            spacer
                        }.padding()
                    }
                    
                }
                .onAppear {
                    self.presenter.execute()
                    self.updatePresenter.execute(request: nil)
                    if presenter.item == nil {
                        self.presenter.execute()
                    }
                    print("APPEAR")
                }
                .onSubmit {
                    if presenter.item == nil {
                        self.presenter.execute()
                    }
                    print("SUBMIT")
                }
                .toolbar {
                    ToolbarItem {
                        if presenter.item?.favorite != nil {
                            if presenter.item?.favorite == true {
                                Button(action: {
                                    self.presenter.execute()
                                    alerta = AlertInfo(id: 1, title: "Delete", description: "Do You want to delete this item?", tourism: self.presenter.item!)
                                    
                                }) {
                                    Image(systemName: "trash")
                                }
                            } else {
                                Button(action: {
                                    self.presenter.execute()
                                    alerta = AlertInfo(id: 2, title: "Save", description: "Do You want to save this item?", tourism: self.presenter.item!)
                                    self.presenter.item = self.presenter.item
                                    
                                }) {
                                    Image(systemName: "star")
                                }
                            }
                            
                        }
                    }
                        
                }.alert(item: $alerta, content: { alerta in
                    Alert(
                        title: Text("Attention"),
                        message: Text(alerta.description),
                        primaryButton: .default(Text(alerta.title), action: {
                            if alerta.id == 1 {
                                self.updatePresenter.execute(request: alerta.tourism.id)
                                self.mode.wrappedValue.dismiss()

                            } else {
                                self.updatePresenter.execute(request: alerta.tourism.id)
                                self.mode.wrappedValue.dismiss()
                            }
                        })
                        ,
                        secondaryButton: .cancel(Text("Cancel"), action: {
                            self.mode.wrappedValue.dismiss()
                        })
                    )
                })
            }
        }
        .navigationBarTitle(Text(self.presenter.item?.name ?? alerta?.tourism.name ?? ""), displayMode: .large)
    }
}

extension TourismDetailView {

    
    var spacer: some View {
        Spacer()
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var image: some View {
        WebImage(url: URL(string: self.presenter.item?.image ?? alerta?.tourism.image ?? ""))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
    }
    
    var description: some View {
        Text((self.presenter.item?.description ?? alerta?.tourism.description) ?? "Unknow")
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerTitle("Description")
                .padding([.top, .bottom])
            description
        }
    }
    
    var address: some View {
        HStack {
            Text(presenter.item?.address ?? alerta?.tourism.address ?? "Unknow")
                .font(.system(size: 16, weight: .semibold))
        }
    }

    
}

struct AlertInfo: Identifiable {
    var id: Int
    let title: String
    let description: String
    let tourism: TourismDomainModel
}

