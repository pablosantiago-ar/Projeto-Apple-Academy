import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {

@Binding var selection: Int
@Binding var annotations: [Place]
@State var LocalAfetado = 0
@State var color: Color = Color.init(red: 67/255, green: 151/255, blue: 117/255)
@State var Imagem: String = "custom.globe.americas.fill"
@State var localAfetadoFlag: Bool = false
let numeroDenuncia = "199"
@State var presentQuiz: Bool = false
@State var score: Int

@State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))


@FetchRequest(sortDescriptors: []) var userlocation: FetchedResults<MapEntity>

func VerSeTaNoLocalAfetado() {
    
    if annotations.count <= 1 && userlocation.isEmpty == true{
        Imagem = "custom.globe.americas.fill"
        localAfetadoFlag = false
    }
    
    for user in userlocation{
        for note in annotations {
            print("BD: \(user.userLat!)")
            print("lista: \(String(note.coordinate.latitude)), logitude: \(note.coordinate.longitude)")
            
            if String(note.coordinate.latitude) == user.userLat!{
                Imagem = "danger"
                color = Color.red
                localAfetadoFlag = true
                //return Text("LOCAL AFETADO").foregroundColor(.red).font(.system(size: 20, weight: .bold, design: .default))
                let content = UNMutableNotificationContent()
                content.title = "VOCÊ ESTÁ EM UM LOCAL ARRISCADO"
                content.subtitle = "Cuidado!"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
            }else{
                Imagem = "custom.globe.americas.fill"
                color = Color.init(red: 67/255, green: 151/255, blue: 117/255)
                localAfetadoFlag = false
                //return Text("FORA DE RISCO").foregroundColor(.green).font(.system(size: 20, weight: .bold, design: .default))
            }
        }
    }
}
var RetornoNaoSeiPq: Int = 0

var body: some View {
    NavigationView {
        
        ScrollView{
            VStack{
                ZStack{
                    Text("Desmorona Brasil")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.size.width, height: 41, alignment: .center)
                        .offset(y: -15)
                        .font(.system(size: 24, weight: .heavy, design: .default))
                    
                    Button {
                        let phone = "tel://"
                        let phoneNumberformatted = phone + numeroDenuncia
                        guard let url = URL(string: phoneNumberformatted) else {return}
                        UIApplication.shared.open(url)
                        
                    } label: {
                        
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: 22, height: 20)
                        //                            .border(.red)
                        
                    }
                    .offset(x: 150, y: -15)
                    
                }
                .frame(width: UIScreen.main.bounds.size.width, height: 147)
                .background(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                .overlay(alignment: .init(horizontal: .center, vertical: .top)) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 354, height: 189)
                            .offset(y: 95)
                            .foregroundColor(.white)
                        VStack{
                            Spacer()
                            Image("\(Imagem)")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .offset(x: -100, y: 120)
                                .foregroundColor(color)
                            Text("Status de Risco:")
                                .font(.system(size: 23, weight: .heavy, design: .default))
                                .offset(x: 74)
                                .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                            
                            
                            
                            Text(localAfetadoFlag ? "LOCAL AFETADO" : "FORA DE RISCO")
                                .foregroundColor(localAfetadoFlag ? .red : .green)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .position(x: 270, y: 20)
                            
                            
                            
                            
                            
                            
                            ZStack{
                                Button {
                                    print("alo")
                                    selection = 2
                                    
                                } label: {
                                    
                                    Text("Saiba mais")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12, weight: .heavy, design: .default))
                                        .background {
                                            Capsule()
                                                .frame(width: 120, height: 35)
                                                .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                                        }
                                    
                                    
                                }
                                .offset(x:80, y:60)
                            }
                            
                        }
                    }
                    .offset(x: 0)
                }
                
                
                Spacer()
                    .frame(height: 120)
                
                Text("Continue denunciando!")
                    .font(.system(size: 22, weight: .bold, design: .default))
                    .frame(width: 300)
                //                    .border(.red)
                    .offset(x: -52, y: 40)
                Text("Suas denúncias são importantes para o funcionamento do aplicativo. Veja suas denúncias aqui:")
                    .font(.system(size: 12, weight: .light, design: .default))
                    .offset(y:10)
                    .frame(width: 350)
                //                    .border(.red)
                    .offset(x: -2, y: 40)
                
                
                Spacer()
                    .frame(height:40)
                
                VStack(alignment: .center, spacing: 30){
                    ZStack{
                        Button {
                            selection = 4
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 130)
                                    .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                                HStack{
                                    Image("profile")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .offset(x: -20)
                                        .foregroundColor(.white)
                                    VStack{
                                        Text("0 Denúncias")
                                            .font(.system(size: 25, weight: .bold, design: .default))
                                            .foregroundColor(.white)
                                            .offset(x:10)
                                        Text("Há 56 dias!")
                                            .font(.system(size: 25, weight: .bold, design: .default))
                                            .foregroundColor(.white)
                                            .offset(x: 20)
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    VStack{
                        Text("Faça o quiz!")
                            .font(.system(size: 22, weight: .bold, design: .default))
                            .frame(width: 300)
                            .offset(x: -106)
                        Text("Teste seus conhecimentos para denunciar corretamente!")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .offset(x: -6, y: 6)
                            .frame(width: 350)
                        
                        
                        
                    }
                    ZStack{
                        Button {
                            presentQuiz = true
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 130)
                                    .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                                HStack{
                                    Image("fotoLogo")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .offset(x: -20)
                                        .foregroundColor(.white)
                                    
                                    VStack{
                                        Text("\(score)/7")
                                            .font(.system(size: 30, weight: .bold, design: .default))
                                            .foregroundColor(.white)
                                            .offset(x:10)
                                        Text(score >= 4 ? "Parabéns!" : "Tente de novo!")
                                            .font(.system(size: 25, weight: .bold, design: .default))
                                            .foregroundColor(.white)
                                            .offset(x: 20)
                                    }
                                }
                                
                                
                            }
                        }

    
                        
                        
                    }
                    
                    
                }
                .frame(width: (UIScreen.main.bounds.width - 50), height: UIScreen.main.bounds.height/1.8, alignment: .center)
                
                
                
                
                VStack{
                    Spacer()
                        .frame(height: 20)
                    Text("SINAIS DE RISCO")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .offset(x: -80, y: 0)
                    Spacer()
                        .frame(height: 40)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 150, height: 200)
                                    .foregroundColor(.white)
                                
                                Image("rachadura")
                                    .resizable()
                                    .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                                    .frame(width: 90, height: 90)
                                    .offset(y:-35)
                                    
                                
                                Text("Rachaduras progressivas")
                                    .offset(x: 0, y: 50)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .frame(width: 150, height: 200)
                                
                            }
                            .frame(width: 150, height: 200)
                            //                            .border(.red)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 150, height: 200)
                                    .foregroundColor(.white)
                                
                                Image(systemName: "drop.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                                    .frame(width: 90, height: 90)
                                    .offset(y:-35)
                                
                                Text("Manchas de infiltração")
                                    .offset(x: 0, y: 50)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .frame(width: 150, height: 200)
                            }
                            .frame(width: 150, height: 200)
                            //                            .border(.red)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 150, height: 200)
                                    .foregroundColor(.white)
                                
                                Image("door")
                                    .resizable()
                                    .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                                    .frame(width: 90, height: 90)
                                    .offset(y:-35)
                                
                                Text("Portas envergadas")
                                    .offset(x: 0, y: 50)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .frame(width: 150, height: 200)
                            }
                            .frame(width: 150, height: 200)
                            //                            .border(.red)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 150, height: 200)
                                    .foregroundColor(.white)
                                
                                Image("tree")
                                    .resizable()
                                    .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                                    .frame(width: 90, height: 90)
                                    .offset(y:-35)
                                
                                Text("Árvores inclinando")
                                    .offset(x: 0, y: 50)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .frame(width: 150, height: 200)
                            }
                            .frame(width: 150, height: 200)
                            //                            .border(.red)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 150, height: 200)
                                    .foregroundColor(.white)
                                
                                Image(systemName: "cloud.bolt.rain.fill")
                                    .resizable()
                                    .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                                    .frame(width: 90, height: 90)
                                    .offset(y:-35)
                                
                                Text("Chuvas fortes")
                                    .offset(x: 0, y: 50)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .frame(width: 150, height: 200)
                            }
                            .frame(width: 150, height: 200)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 150, height: 200)
                                    .foregroundColor(.white)
                                
                                Image(systemName: "drop.triangle")
                                    .resizable()
                                    .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                                    .frame(width: 90, height: 90)
                                    .offset(y:-35)
                                
                                Text("Água barrenta acumulada")
                                    .offset(x: 0, y: 50)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .frame(width: 150, height: 200)
                            }
                            .frame(width: 150, height: 200)
                            //                            .border(.red)
                            
                            Spacer()
                                .frame(width: 20, height: 100)
                            
                            
                        }
                    }
                    .offset(x: 10, y: -10)
                }
                .offset(x: 0, y: -20)
                
                Spacer()
                    .frame(height:60)
                
                
                
            }
            .ignoresSafeArea()
            
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.init(red: 235/255, green: 235/255, blue: 235/255))
        .sheet(isPresented: $presentQuiz) {
        } content: {
            QuizView(score: $score)
        }
        .onAppear() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set")
                }else if let error = error {
                    print(error.localizedDescription)
                }
            }
            VerSeTaNoLocalAfetado()
                

        }
    }
        
    
}
    

}

struct ContentView_Previews: PreviewProvider {

static var previews: some View {
    ContentView(selection: .constant(0), annotations: .constant([]), score: 0)
}
}
// new 31 maio

