//
//  MapView.swift
//  CapitaesdeAreia
//
//  Created by aluno on 07/05/22.
//

import SwiftUI
import MapKit
import CoreLocation
import UserNotifications

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    @State var modal = false
    let searchVC = UISearchController(searchResultsController: ResultsCViewController())
    
    @Binding var annotations: [Place]

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var mapget: FetchedResults<MapEntity>
    
    
    
    
    var body: some View {
        ScrollView{
            VStack{
                ZStack{
                    
                    Text("mapa")
                        .offset(y: 13)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .heavy, design: .default))
                        .textCase(.uppercase)
                        .frame(width: UIScreen.main.bounds.size.width, height: 20, alignment: .center)
                    
                    HStack{
                        
                        
                        Spacer()
                        
                        Button {
                            modal = true
                        } label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .foregroundColor(.white)
                        }
                        .padding()
                        
                    }
                    .frame(width: UIScreen.main.bounds.size.width, height: 30)
                    .offset(y: 10)
                    
                }
                .frame(width: UIScreen.main.bounds.size.width, height: 80)
                .background(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                
                VStack{
                    Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: mapget){
                        entity in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(entity.lat), longitude: (entity.long))){
                            ZStack {
                                var size = viewModel.circleSize()
                                
                                Circle()
                                    .foregroundColor(Color.init(red: 0/255, green: 255/255, blue: 0/255, opacity: 0.2))
                                    .frame(width: size.0, height: size.1)
//                                    .animation(.linear)
                                
                                SimboloMapas()
                                    
                                
                            }
                            
                        }
                    }
                    //                .onReceive(viewModel.region) { region in
                    //                    pri nt(region.span)
                    //                }
                    .accentColor(Color.green)
                    .onAppear{
                        viewModel.checkIfLocationServicesIsEnabled()
                        
                    }
                    
                    
                    //                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    //                    .accentColor(Color.green)
                    //                    .onAppear {
                    //                        viewModel.checkIfLocationServicesIsEnabled()
                    //                    }
                    
                    
                }
                .offset(y: -8)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 160)
                
                
                
            }
            
            .ignoresSafeArea()
        }
        
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.init(red: 235/255, green: 235/255, blue: 235/255))
        .sheet(isPresented: $modal) {
            ModalCadastro(isActive: $modal, note: $annotations, id: UUID())
            
            //            VStack{
            //                Text("Fechar")
            //                    .background(.green)
            //                    .font(.system(size: 30))
            //                    .onTapGesture {
            //                        modal = false
            //                    }
            //            }
            
            

            
        }
        
        
        
        
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(annotations: .constant([]))
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -3.71839, longitude: -38.5434), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)){
        didSet {
            print("\(region.span.latitudeDelta), \(region.span.longitudeDelta)")
//            print("\((region.span.latitudeDelta * 10)), \((region.span.longitudeDelta * 10))")
        }
        
    }
    var locationManager: CLLocationManager?
    
    
    func checkIfLocationServicesIsEnabled(){
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            
        } else{
            print("Show an alert")
        }
    }
    
    func checkLocationAuthorization(){
        guard let locationManager = locationManager else {return}
        
        
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("your location is restricted")
            var alerta: some View{
                return VStack{
                    
                }
                .frame(width: 200, height: 200)
            }
            Alert(title: Text("teste"), message: Text("Testando"), dismissButton: .default(Text("pronto")))
        case .denied:
            Alert(title: Text("teste"), message: Text("Testando"), dismissButton: .default(Text("pronto")))
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
            
            
            
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func circleSize() -> (Double, Double) {
        var valorConvertido:Double = 0.0
        
        valorConvertido = 100
        
        let valorConstante = 0.0036277611882624683 * 80
        
        valorConvertido = valorConstante / region.span.latitudeDelta

        return (valorConvertido,valorConvertido)
        
        //    let searchVC = UISearchController(searchResultsController: ResultsCViewController())
        
    }
    
}


struct ModalCadastro: View {
    @Binding var isActive: Bool
    @Binding var note: [Place]
    var id: UUID
    @State var rua = ""
    @State var numero = ""
    @State var cidade = ""
    @State var estado = ""
    @State var select = "Acre"
    var locationManager = CLLocationManager()
    
    let estados: [String] = ["Acre","Alagoas","Amapá","Amazonas","Bahia","Ceará","Distrito Federal",
                             "Espirito Santo",
                             "Goiás",
                             "Maranhão",
                             "Mato Grosso do Sul",
                             "Mato Grosso",
                             "Minas Gerais",
                             "Pará",
                             "Paraíba",
                             "Paraná",
                             "Pernambuco",
                             "Piauí",
                             "Rio de Janeiro",
                             "Rio Grande do Norte",
                             "Rio Grande do Sul",
                             "Rondônia",
                             "Roraima",
                             "Santa Catarina",
                             "São Paulo",
                             "Sergipe",
                             "Tocantins",]

    
    @State var geocoder = CLGeocoder()
    func callGeoCoder() {
        
        geocoder.geocodeAddressString("\(ChecarRua()) \(rua), \(numero), \(cidade), \(estado)") {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let long = placemark?.location?.coordinate.longitude
            print("\(lat), \(long)")
            
            if(lat == nil || long ==  nil){
                showAlert = true //setar via binding que vem da MapView
                alertTitle = "Erro!"
                alertMessage = "Digite o endereço novamente!"
            }else{
//                note.append(Place(name: "Coordenada", coordinate: CLLocationCoordinate2D(latitude: lat ?? 0, longitude: long ?? 0)))
                let mapread = MapEntity(context: moc)
                mapread.id = UUID()
                mapread.lat = Double(lat ?? 0)
                mapread.long = Double(long ?? 0)
                mapread.rua = rua
                mapread.numero = Int16(numero)!
                mapread.cidade = cidade
                mapread.estado = estado
                mapread.userLat = String(locationManager.location!.coordinate.latitude)
                mapread.userLong = String(locationManager.location!.coordinate.longitude)
                
                try? moc.save()
                
                print("latitude do novo local: \(lat) /n longitude do novo local: \(long)")
                
            }
        }
        
    }
    @State var showAlert = false
    @State var alertTitle: String = "ERRO!"
    @State var alertMessage: String = "Digite os dados novamente"
    
    func checkValuesVar() -> Bool{
        if(rua.count == 0 || numero.count == 0 || rua.count < 5 || Int(numero) == nil){
            rua = ""
            numero = ""
            
            showAlert = true
            alertTitle = "Erro!"
            alertMessage = "Digite os dados novamente!"
            
            return false
            
        }else if zstack == (-400,0,400){
            if(cidade.count < 3){
                cidade = ""
                showAlert = true
                return false
            } else{
                showAlert = false
                return true
            }
        } else if zstack == (-400,-400,0){
            var trueExists = 0
            for check in checkboxes{
                if check.0 == true{
                    trueExists += 1
                }
            }
            if trueExists == 0{
                showAlert = true
                return false
            }else{
                showAlert = false
                return true
            }
        }else{
            showAlert = false
            return true
            
        }
        
        
    }
    @State var zstack = (0,400,400)
    
    @State var isSearching = true
    
    @State var checkboxImage: [String] = ["circle","circle","circle", "circle", "circle"]
    @State var checkboxes: [(Bool,String)] = [(false,"valor do texto"), (false, "valor do texto)"), (false,"valor do texto)"),(false, "valor do texto)"), (false, "valor do texto)"), (false, "valor do texto)") ]
    @State var isChecked = false
    @State var modalvalor = false
    
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<MapEntity>
    @Environment(\.managedObjectContext) var moc
    
    func ChecarRua() -> String{
        var lista = rua.components(separatedBy: " ")
        
        for i in lista{
            if i.uppercased() == "RUA"{
                return ""
            }else{
                return "Rua"
            }
        }
        return ""
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("CADASTRO")
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.size.width, height: 50, alignment: .center)
            
            ZStack{
                VStack{
                    TextField("Rua", text: $rua)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: rua) { newValue in
                            if newValue.count > 50 {
                                self.rua = String(newValue.prefix(50))
                            }
                        }

                    TextField("Número", text: $numero)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: numero) { newValue in
                            if newValue.count > 4 {
                                self.numero = String(newValue.prefix(4))
                            }
                    
                
                    }
                    
                }
                .offset(x: CGFloat(zstack.0))
                
                
                ZStack{
                    VStack{
                        Text("Selecione o Estado")
                        Picker("Selecione o Estado",selection: $select) {
                            ForEach(estados.reversed(), id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(width: UIScreen.main.bounds.size.width, height: 10)
                        
                        Spacer()
                        
                        TextField("Cidade", text: $cidade)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                        
                    }
                    
                    
                }
                .offset(x: CGFloat(zstack.1))
                .frame(width: UIScreen.main.bounds.size.width, height: 110)
                .animation(.easeIn(duration: 0.5))
                ZStack{
                    VStack{
                        Text("Sinais observados: ")
                        Spacer()
                        VStack{
                            HStack{
                                Image(systemName: "\(checkboxImage[0])")
                                    .animation(.easeInOut(duration: 0.5))
                                Text("Rachaduras progressivas")
                            }
                            .onTapGesture {
                                if isChecked == false{
                                    isChecked.toggle()
                                    checkboxImage[0] = "checkmark.circle.fill"
                                    checkboxes[0] = (true,"")
                                } else{
                                    isChecked.toggle()
                                    checkboxImage[0] = "circle"
                                    checkboxes[0] = (false,"")
                                }
                            
                            }
                            
                            Spacer()
                            
                            HStack{
                                Image(systemName: "\(checkboxImage[1])")
                                    .animation(.easeInOut(duration: 0.5))
                                Text("Manchas de infiltração")
                            }
                            .onTapGesture {
                                if isChecked == false{
                                    isChecked.toggle()
                                    checkboxImage[1] = "checkmark.circle.fill"
                                    checkboxes[1] = (true, "")
                                } else{
                                    isChecked.toggle()
                                    checkboxImage[1] = "circle"
                                    checkboxes[1] = (false,"")
                                }
                            }
                            
                            Spacer()
                            HStack{
                                Image(systemName: "\(checkboxImage[2])")
                                    .animation(.easeInOut(duration: 0.5))
                                Text("Portas envergadas")
                            }
                            .onTapGesture {
                                if isChecked == false{
                                    isChecked.toggle()
                                    checkboxImage[2] = "checkmark.circle.fill"
                                    checkboxes[2] = (true,"")
                                } else{
                                    isChecked.toggle()
                                    checkboxImage[2] = "circle"
                                    checkboxes[2] = (false,"")
                                }
                            }
                            
                            Spacer()
                            HStack{
                                Image(systemName: "\(checkboxImage[3])")
                                    .animation(.easeInOut(duration: 0.5))
                                Text("Árvores inclinando")
                            }
                            .onTapGesture {
                                if isChecked == false{
                                    isChecked.toggle()
                                    checkboxImage[3] = "checkmark.circle.fill"
                                    checkboxes[3] = (true, "")
                                } else{
                                    isChecked.toggle()
                                    checkboxImage[3] = "circle"
                                    checkboxes[3] = (false,"")
                                }
                            }
                            
                            Spacer()
                            HStack{
                                Image(systemName: "\(checkboxImage[4])")
                                    .animation(.easeInOut(duration: 0.5))
                                Text("Chuvas fortes")
                            }
                            .onTapGesture {
                                if isChecked == false{
                                    isChecked.toggle()
                                    checkboxImage[4] = "checkmark.circle.fill"
                                    checkboxes[4] = (true, "")
                                } else{
                                    isChecked.toggle()
                                    checkboxImage[4] = "circle"
                                    checkboxes[4] = (false,"")
                                }
                            }
                            
                            Spacer()
                            
                            
                        
                           
                            
                            
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.size.width, height: 120)
                    
                    
                }
                .offset(x: CGFloat(zstack.2))
                .frame(width: UIScreen.main.bounds.size.width, height: 110)
                .animation(.easeIn(duration: 0.5))
                
            }
            
            Button {
                checkValuesVar()
                
                
                if zstack == (-400,0,400){
                    if Int(numero) == nil {
                        showAlert = true
                    }else{
                        showAlert = false
                        if checkValuesVar() {
                            zstack = (-400,-400,0)
                        }
                    }
                } else if zstack == (-400,-400,0){
                    if checkValuesVar() == true{
                        isActive = false
                        callGeoCoder()
                    }
                } else if checkValuesVar() == true {
                    zstack = (-400,0,400)
                }
                
            } label: {
                
                Text("Próximo")
                Image(systemName: "arrow.right")
            }
            .frame(width: UIScreen.main.bounds.size.width, height: 20, alignment: .center)
            .offset(y: 10)
            
            
        }
        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 100)
        .alert(isPresented: $showAlert) {
            zstack = (0,400,400)
            return Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(
                    Text("Ok!")
                )
            )
            
        }
    }
    
}
