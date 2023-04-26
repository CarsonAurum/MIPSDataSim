//
//  OptionsView.swift
//  DataSim
//
//  Created by Carson Rau on 4/3/23.
//

import SwiftUI

struct OptionsView: View {
    @EnvironmentObject private var settings: AppSettings
    @EnvironmentObject private var gameManager: GameManager
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("App Settings")
                    .font(.customLargeTitle)
                Spacer()
            }
            .animation(.default)
            if gameManager.isPaused {
                Text("If you want to make changes to the timer settings, you must first quit your current game!")
                    .multilineTextAlignment(.center)
                    .font(.customBody)
                    .padding([.top, .bottom], 30)
            } else {
                HStack {
                    Spacer()
                    Toggle(isOn: $settings.enableTimer) {
                        Text("Use Timer")
                            .font(.customBody)
                    }
                        .onChange(of: settings.enableTimer) { newValue in
                            if (newValue == false && settings.enableHardMode) {
                                settings.enableHardMode = false
                            }
                        }
                        .fixedSize()
                    Spacer()
                }
                .animation(.default)
                if settings.enableTimer {
                    VStack {
                        HStack {
                            Spacer()
                            Picker(selection: $settings.difficulty) {
                                Text(AppSettings.Difficulty.turtle.rawValue).tag(AppSettings.Difficulty.turtle)
                                    .font(.customCaption)
                                Text(AppSettings.Difficulty.easy.rawValue).tag(AppSettings.Difficulty.easy)
                                    .font(.customCaption)
                                Text(AppSettings.Difficulty.medium.rawValue).tag(AppSettings.Difficulty.medium)
                                    .font(.customCaption)
                                Text(AppSettings.Difficulty.hard.rawValue).tag(AppSettings.Difficulty.hard)
                                    .font(.customCaption)
                                Text(AppSettings.Difficulty.lightning.rawValue).tag(AppSettings.Difficulty.lightning)
                                    .font(.customCaption)
                            } label: {
                                Text("Timer Difficult Selection")
                                    .font(.customBody)
                            }
                            .onChange(of: settings.difficulty) { newValue in
                                gameManager.timeRemaining = settings.getTimeRemaining()
                            }
                            .pickerStyle(.inline)
                            Spacer()
                        }
                        VStack {
                            HStack {
                                Spacer()
                                Toggle(isOn: $settings.enableHardMode) {
                                    Text("Hard Mode")
                                        .font(.customBody)
                                }
                                    .onChange(of: settings.enableHardMode) { newValue in
                                        if (!settings.enableTimer) {
                                            settings.enableHardMode = false
                                        }
                                    }
                                    .fixedSize()
                                Spacer()
                            }
                            Text("Hardmode reduces time remaining on each incorrect connection.")
                                .font(.customSubtitle)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    .transition(.slide)
                    .animation(.default)
                }
            }
            HStack {
                Spacer()
                ColorPicker(selection: $settings.primaryColor) {
                    Text("Datapath Element Color")
                        .font(.customBody)
                }
                    .fixedSize()
                Spacer()
            }
            .animation(.default)
        }
    }
}
