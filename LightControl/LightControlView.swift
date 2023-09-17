//
//  LightControlView.swift
//  LightControl
//
//  Created by rryu on 2023/1/13.
//

import SwiftUI

struct LightControlView: View {
    @Binding var settingsOpen: Bool
    @Binding var lightBrightness: Double
    @Binding var lightSpeed: Double
    @Binding var lightTemp: Double
    @Binding var isEditing: Bool
    @Binding var lightControl: LightControler
    @Binding var lightIp: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text("LightController")
                .font(.title.bold())
                .foregroundColor(.primary)
            Spacer()
            
            // 测试按钮
//            Button {
//                lightControl.checkLightState(ip: lightIp)
//            } label: {
//                Image(systemName: "questionmark.square.dashed")
//                    .foregroundColor(.gray)
//                    .font(.largeTitle)
//            }.buttonStyle(.plain).help(Text("测试"))

            Button {
                lightControl.turnOff(ip: lightIp)
            } label: {
                Image(systemName: "lightswitch.off.square")
                    .foregroundColor(.gray)
                    .font(.largeTitle)
            }.buttonStyle(.plain).help(Text("关灯"))
            
            Button {
                lightControl.turnOn(ip: lightIp)
            } label: {
                Image(systemName: "lightswitch.on.square.fill")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
            }.buttonStyle(.plain).help(Text("开灯"))
        }.padding(10)
        
        // 亮度调整滑块
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: "dial.low")
                .foregroundColor(.black)
                .font(.title3)
                .symbolRenderingMode(.multicolor)
            
            Slider(
                value: $lightBrightness,
                in: 10...100,
                onEditingChanged: { editing in
                    lightControl.setBrightess(ip: lightIp, brightness: lightBrightness)
                }
            )
            
            Image(systemName: "dial.high.fill")
                .foregroundColor(.black)
                .font(.title3)
                .symbolRenderingMode(.multicolor)
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 12,style:.circular)
                .fill(.white)
        }
        
        // 色温调整滑块
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: "snowflake.circle")
                .foregroundColor(.black)
                .font(.title3)
                .symbolRenderingMode(.multicolor)
            
            Slider(
                value: $lightTemp,
                in: 2200...6500,
//                step: 100,
                onEditingChanged: { editing in
                    lightControl.setTemp(ip: lightIp,temp: lightTemp)
                }
            ).tint(.blue)
            
            Image(systemName: "sun.max")
                .foregroundColor(.black)
                .font(.title3)
                .symbolRenderingMode(.multicolor)
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 12,style:.circular)
                .fill(.white)
        }
        
        TabView {
            StaticLightView(lightControl: $lightControl,lightIp: $lightIp)
                .tabItem {
                    Label("static-light".localized, systemImage: "circle.fill")
                }
            DynamicLightView(lightControl: $lightControl,lightSpeed: $lightSpeed, lightIp: $lightIp)
                .tabItem {
                    Label("dynamic-light".localized, systemImage: "circle.circle")
                }
        }
    }
}


struct StaticLightView: View {
    @Binding var lightControl: LightControler
    @Binding var lightIp: String
    
    var body: some View {
        Grid() {
            GridRow {
                ControlViewV(icon: "lightbulb.led", title: "暖白", color: .yellow,scene: 11)
                ControlViewV(icon: "sun.max", title: "日光", color: .white,scene: 12)
                ControlViewV(icon: "snowflake", title: "冷白", color: .blue,scene: 13)
            }
            Spacer()
            GridRow {
                ControlViewV(icon: "moon", title: "夜灯", color: .gray,scene: 14)
                ControlViewV(icon: "cup.and.saucer", title: "舒适", color: .yellow,scene: 6)
                ControlViewV(icon: "paintpalette", title: "原色", color: .yellow,scene: 17)
                ControlViewV(icon: "leaf", title: "放松", color: .purple,scene: 16)
                ControlViewV(icon: "person.and.background.dotted", title: "专注", color: .white,scene: 15)
            }
            
            GridRow {
                ControlViewV(icon: "sparkles.tv", title: "电视时间", color: .blue,scene: 18)
                ControlViewV(icon: "tree", title: "植物生长", color: .pink,scene: 19)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func ControlViewV (icon:String, title: String, color: Color, scene: Int)->some View{
        Button {
            lightControl.setScene(ip: lightIp, scene: scene)
        } label: {
            VStack(spacing:10){
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .background{
                        Circle()
                            .fill(color.opacity(0.2))
                    }
                Text(title)
                    .font(.caption)
                    .foregroundColor(.black)
            }
            .frame(width: 70,height: 80)
            .background{
                RoundedRectangle(cornerRadius: 12,style: .continuous)
                    .fill(.white)
            }
        }.buttonStyle(.borderless)
    }
}

struct DynamicLightView: View {
    @Binding var lightControl: LightControler
    @Binding var lightSpeed: Double
    @Binding var lightIp: String
    var body: some View {
        Grid() {
            GridRow {
                ControlViewV(icon: "microbe", title: "烛光", color: .yellow, scene: 29)
                ControlViewV(icon: "water.waves", title: "呼吸灯", color: .yellow, scene: 31)
                ControlViewV(icon: "rays", title: "金白色", color: .white, scene: 30)
                ControlViewV(icon: "eyeglasses", title: "蒸汽朋克", color: .yellow, scene: 32)
            }
            Spacer()
            GridRow {
                ControlViewV(icon: "fireplace", title: "壁炉", color: .orange, scene: 5)
                ControlViewV(icon: "wind", title: "秋天", color: .orange, scene: 22)
                ControlViewV(icon: "fleuron", title: "俱乐部", color: .orange, scene: 26)
                ControlViewV(icon: "sunset", title: "日落", color: .red, scene: 3)
                ControlViewV(icon: "bolt.heart", title: "浪漫", color: .purple, scene: 2)
            }
            
            GridRow {
                ControlViewV(icon: "party.popper", title: "聚会", color: .pink, scene: 4)
                ControlViewV(icon: "arrow.triangle.swap", title: "柔和色系", color: .pink, scene: 8)
                ControlViewV(icon: "leaf", title: "春天", color: .green, scene: 20)
                ControlViewV(icon: "tshirt", title: "夏天", color: .yellow, scene: 21)
                ControlViewV(icon: "tent.2", title: "森林", color: .mint, scene: 7)
            }
            
            GridRow {
                ControlViewV(icon: "sparkles.tv", title: "丛林", color: .green, scene: 24)
                ControlViewV(icon: "wineglass", title: "莫吉托", color: .cyan, scene: 25)
                ControlViewV(icon: "sailboat", title: "海洋", color: .teal, scene: 1)
                ControlViewV(icon: "fish", title: "深海", color: .blue, scene: 23)
                ControlViewV(icon: "gift", title: "圣诞节", color: .red, scene: 27)
            }
            
            GridRow {
                ControlViewV(icon: "flame.circle", title: "排灯节", color: .yellow, scene: 33)
                ControlViewV(icon: "theatermasks", title: "万圣节", color: .orange, scene: 28)
            }
            Spacer()
            GridRow {
                ControlViewV(icon: "alarm", title: "晨醒", color: .white, scene: 9)
                ControlViewV(icon: "teddybear", title: "就寝时间", color: .orange, scene: 10)
            }
            
            // 速度调整滑块
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "tortoise")
                    .foregroundColor(.black)
                    .font(.title3)
                    .symbolRenderingMode(.multicolor)
                
                Slider(
                    value: $lightSpeed,
                    in: 10...200,
                    onEditingChanged: { editing in
                        lightControl.setSpeed(ip: lightIp, speed: lightSpeed)
                    }
                ).tint(.blue)
                
                Image(systemName: "hare")
                    .foregroundColor(.black)
                    .font(.title3)
                    .symbolRenderingMode(.multicolor)
            }
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 12,style:.circular)
                    .fill(.white)
            }
        }
        .padding(10)
    }
    
    @ViewBuilder
    func ControlViewV (icon:String, title: String, color: Color, scene: Int)->some View{
        Button {
            lightControl.setScene(ip: lightIp, scene: scene)
        } label: {
            VStack(spacing:10){
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .background{
                        Circle()
                            .fill(color.opacity(0.2))
                    }
                Text(title)
                    .font(.caption)
                    .foregroundColor(.black)
            }
            .frame(width: 70,height: 80)
            .background{
                RoundedRectangle(cornerRadius: 12,style: .continuous)
                    .fill(.white)
            }
        }.buttonStyle(.borderless)
    }
}
