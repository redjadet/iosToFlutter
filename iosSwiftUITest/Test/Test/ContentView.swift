import SwiftUI

struct ContentView: View {
    @State private var showingTips = false

    var body: some View {
        NavigationStack {
            List {
                Section(LocalizedStringKey("Try a Sample")) {
                    ForEach(Demo.allCases) { demo in
                        NavigationLink(value: demo) {
                            DemoRow(demo: demo)
                        }
                    }
                }
                .accessibilityIdentifier("samplesSection")

                Section(LocalizedStringKey("About")) {
                    Text(LocalizedStringKey("Browse a handful of common SwiftUI patterns. Each screen focuses on a different building block that you can adapt in your own projects."))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 4)
                }
                .accessibilityIdentifier("aboutSection")
            }
            .listStyle(.insetGrouped)
            .navigationTitle("SwiftUI Samples")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingTips = true
                    } label: {
                        Label(LocalizedStringKey("SwiftUI Tips"), systemImage: "lightbulb")
                    }
                    .accessibilityIdentifier("tipsButton")
                }
            }
            .sheet(isPresented: $showingTips) {
                TipsSheet()
            }
            .navigationDestination(for: Demo.self) { demo in
                demo.destinationView
            }
        }
    }
}

private enum Demo: String, CaseIterable, Identifiable {
    case gradient
    case controls
    case animation
    case list
    case grid

    var id: String { rawValue }

    var title: LocalizedStringKey {
        switch self {
        case .gradient:
            return LocalizedStringKey("Gradient Playground")
        case .controls:
            return LocalizedStringKey("Forms and Controls")
        case .animation:
            return LocalizedStringKey("Animations")
        case .list:
            return LocalizedStringKey("Dynamic Lists")
        case .grid:
            return LocalizedStringKey("Adaptive Grid")
        }
    }

    var subtitle: LocalizedStringKey {
        switch self {
        case .gradient:
            return LocalizedStringKey("Animate colors and tweak gradients.")
        case .controls:
            return LocalizedStringKey("Build a form with common controls.")
        case .animation:
            return LocalizedStringKey("Play with smooth transitions.")
        case .list:
            return LocalizedStringKey("Organize data with sections.")
        case .grid:
            return LocalizedStringKey("Lay out cards with LazyVGrid.")
        }
    }

    var icon: String {
        switch self {
        case .gradient:
            return "paintpalette"
        case .controls:
            return "slider.horizontal.3"
        case .animation:
            return "sparkles"
        case .list:
            return "list.bullet.rectangle"
        case .grid:
            return "square.grid.2x2"
        }
    }

    @ViewBuilder
    var destinationView: some View {
        switch self {
        case .gradient:
            GradientPlayground()
        case .controls:
            FormPlayground()
        case .animation:
            AnimationPlayground()
        case .list:
            TaskListPlayground()
        case .grid:
            GridPlayground()
        }
    }
}

private struct DemoRow: View {
    let demo: Demo

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: demo.icon)
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.blue.gradient)
                )
            VStack(alignment: .leading, spacing: 4) {
                Text(demo.title)
                    .font(.headline)
                Text(demo.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(demo.title) + Text(". ") + Text(demo.subtitle))
        .accessibilityAddTraits(.isButton)
        .padding(.vertical, 6)
    }
}

private struct TipsSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section(LocalizedStringKey("Previews")) {
                    Label(LocalizedStringKey("Use the resume button to refresh a preview quickly."), systemImage: "play.circle")
                    Label(LocalizedStringKey("Switch devices from the Preview canvas toolbar."), systemImage: "iphone")
                }
                Section(LocalizedStringKey("Layout")) {
                    Label(LocalizedStringKey("Stacks and spacers are the backbone of most layouts."), systemImage: "square.split.2x2")
                    Label(LocalizedStringKey("ContainerRelativeFrame helps with scrollable hero sections."), systemImage: "rectangle.expand.vertical")
                }
            }
            .navigationTitle(LocalizedStringKey("SwiftUI Tips"))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

private struct GradientPlayground: View {
    @State private var startHue: Double = 0.1
    @State private var endHue: Double = 0.6
    @State private var rotation: Double = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 220)
                    .rotationEffect(.degrees(rotation))
                    .shadow(color: .black.opacity(0.15), radius: 16, y: 10)
                    .animation(.smooth(duration: 0.8), value: rotation)

                VStack(alignment: .leading, spacing: 18) {
                    slider(
                        title: "Rotation",
                        value: $rotation,
                        range: 0...360,
                        display: "\(Int(rotation)) deg"
                    )
                    slider(
                        title: "Start Hue",
                        value: $startHue,
                        range: 0...1,
                        display: String(format: "%.2f", startHue)
                    )
                    slider(
                        title: "End Hue",
                        value: $endHue,
                        range: 0...1,
                        display: String(format: "%.2f", endHue)
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Gradient Playground")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var gradientColors: [Color] {
        [
            Color(hue: startHue, saturation: 0.8, brightness: 0.95),
            Color(hue: endHue, saturation: 0.85, brightness: 0.8)
        ]
    }

    @ViewBuilder
    private func slider(
        title: String,
        value: Binding<Double>,
        range: ClosedRange<Double>,
        display: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(display)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Slider(value: value, in: range)
        }
    }
}

private struct FormPlayground: View {
    @State private var name: String = "Taylor Developer"
    @State private var receivesEmail: Bool = true
    @State private var preferredFocus = Focus.afternoon
    @State private var energyLevel: Double = 0.7
    @State private var dailySessions: Int = 3
    @State private var reminderDate: Date = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()

    private enum Focus: String, CaseIterable, Identifiable {
        case morning
        case afternoon
        case evening

        var id: String { rawValue }

        var title: String {
            rawValue.capitalized
        }
    }

    var body: some View {
        Form {
            Section(LocalizedStringKey("Profile")) {
                TextField("Name", text: $name)
                    .textInputAutocapitalization(.words)
                    .keyboardType(.default)
                DatePicker("Reminder", selection: $reminderDate, displayedComponents: [.date, .hourAndMinute])
            }

            Section(LocalizedStringKey("Preferences")) {
                Picker("Focus Time", selection: $preferredFocus) {
                    ForEach(Focus.allCases) { focus in
                        Text(focus.title).tag(focus)
                    }
                }
                .pickerStyle(.automatic)

                Toggle("Send daily summary", isOn: $receivesEmail)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Energy")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Slider(value: $energyLevel, in: 0...1)
                    Text("Current level: \(Int(energyLevel * 100))%")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Stepper("Sessions per day: \(dailySessions)", value: $dailySessions, in: 1...8)
            }

            Section {
                Button(role: .destructive) {
                    name = ""
                    receivesEmail = false
                    preferredFocus = .morning
                    energyLevel = 0.5
                    dailySessions = 1
                } label: {
                    Text(LocalizedStringKey("Reset to Defaults"))
                }
            }
        }
        .navigationTitle(LocalizedStringKey("Forms and Controls"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct AnimationPlayground: View {
    @State private var cardExpanded = false
    @State private var animateBars = false
    private let barHeights: [CGFloat] = [160, 90, 180, 120, 150]

    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.accentColor.opacity(0.15))
                        .frame(height: cardExpanded ? 200 : 120)
                        .overlay(alignment: .leading) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(LocalizedStringKey("Spring Animation"))
                                    .font(.title3.weight(.semibold))
                                Text(LocalizedStringKey("Tap the button below to expand and collapse this card with a spring animation."))
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                            .padding()
                        }
                        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: cardExpanded)

                    Button {
                        withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                            cardExpanded.toggle()
                        }
                    } label: {
                        Text(cardExpanded ? LocalizedStringKey("Collapse Card") : LocalizedStringKey("Expand Card"))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }

                VStack(spacing: 24) {
                    Text(LocalizedStringKey("Repeating Equalizer"))
                        .font(.headline)
                    HStack(alignment: .bottom, spacing: 14) {
                        ForEach(Array(barHeights.enumerated()), id: \.offset) { index, height in
                            Capsule()
                                .fill(Color.accentColor.gradient)
                                .frame(width: 18, height: animateBars ? height : height * 0.35)
                                .animation(
                                    .easeInOut(duration: 1.1)
                                        .delay(Double(index) * 0.08)
                                        .repeatForever(autoreverses: true),
                                    value: animateBars
                                )
                        }
                    }
                    .frame(height: 200)
                }
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey("Animations"))
        .navigationBarTitleDisplayMode(.inline)
        .task {
            guard !animateBars else { return }
            try? await Task.sleep(nanoseconds: 200_000_000)
            animateBars = true
        }
    }
}

private struct TaskListPlayground: View {
    @State private var tasks = SampleTask.examples
    @State private var completed: [SampleTask] = []

    var body: some View {
        List {
            Section(LocalizedStringKey("In Progress")) {
                if tasks.isEmpty {
                    Text(LocalizedStringKey("All tasks completed. Nice work!"))
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(tasks) { task in
                        TaskRow(task: task)
                    }
                    .onDelete { indexSet in
                        let removed = indexSet.map { tasks[$0] }
                        completed.append(contentsOf: removed)
                        tasks.remove(atOffsets: indexSet)
                    }
                }
            }

            Section(LocalizedStringKey("Completed")) {
                if completed.isEmpty {
                    Text(LocalizedStringKey("Swipe left on a task to mark it complete."))
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(completed) { task in
                        TaskRow(task: task, showProgress: false)
                    }
                }
            }
        }
        .animation(.default, value: tasks + completed)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .bottomBar) {
                Button("Shuffle Tasks") {
                    withAnimation {
                        tasks.shuffle()
                    }
                }
            }
        }
        .navigationTitle(LocalizedStringKey("Task List"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct TaskRow: View {
    let task: SampleTask
    var showProgress: Bool = true

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: task.icon)
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(Color.accentColor)
                )
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.headline)
                Text(task.detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                if let dueDate = task.dueDate {
                    Text("Due \(dueDate, style: .date) \(dueDate, style: .time)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                if showProgress {
                    ProgressView(value: task.progress)
                        .tint(.accentColor)
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("\(task.title). \(task.detail)"))
        .padding(.vertical, 4)
    }
}

private struct SampleTask: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let detail: String
    let dueDate: Date?
    let progress: Double
    let icon: String

    static let examples: [SampleTask] = [
        SampleTask(
            title: "Design onboarding flow",
            detail: "Review the latest wireframes and add feedback.",
            dueDate: Calendar.current.date(byAdding: .hour, value: 6, to: Date()),
            progress: 0.45,
            icon: "paintbrush"
        ),
        SampleTask(
            title: "Stand-up meeting",
            detail: "Share yesterday's progress and today's plan.",
            dueDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date()),
            progress: 0.1,
            icon: "person.3"
        ),
        SampleTask(
            title: "Refactor data layer",
            detail: "Clean up the networking code and add unit tests.",
            dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()),
            progress: 0.75,
            icon: "gearshape"
        ),
        SampleTask(
            title: "Prepare release notes",
            detail: "Summarize new features for the upcoming release.",
            dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()),
            progress: 0.3,
            icon: "doc.text"
        )
    ]
}

private struct GridPlayground: View {
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150, maximum: 150), spacing: 10)
    ]
    private let palettes = SamplePalette.examples

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(palettes) { palette in
                    VStack(alignment: .leading, spacing: 14) {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: palette.colors,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 140)
                            .overlay(alignment: .topLeading) {
                                Text(palette.name)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .padding(12)
                            }
                        Text(palette.description)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        HStack(spacing: 8) {
                            ForEach(Array(palette.colors.enumerated()), id: \.offset) { index, color in
                                Capsule()
                                    .fill(color)
                                    .frame(width: 28, height: 8)
                                    .opacity(Double(index) == Double(palette.colors.count - 1) ? 0.9 : 0.8)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(Color.secondary.opacity(0.12))
                    )
                }
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey("Adaptive Grid"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct SamplePalette: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let colors: [Color]

    static let examples: [SamplePalette] = [
        SamplePalette(
            name: "Sunset",
            description: "Warm accents that fade from orange to purple.",
            colors: [.orange, .pink, .purple]
        ),
        SamplePalette(
            name: "Forest",
            description: "Earthy greens that work for nature inspired designs.",
            colors: [.green, .mint, .teal]
        ),
        SamplePalette(
            name: "Ocean",
            description: "Cool blues that feel right at home in dashboard UI.",
            colors: [.blue, .cyan, .teal]
        ),
        SamplePalette(
            name: "Mono",
            description: "Neutral grays that keep the focus on typography.",
            colors: [.gray, .secondary, .black]
        )
    ]
}

#Preview("ContentView") {
    ContentView()
}

#Preview("GradientPlayground") {
    NavigationStack { GradientPlayground() }
}

#Preview("FormPlayground") {
    NavigationStack { FormPlayground() }
}

#Preview("AnimationPlayground") {
    NavigationStack { AnimationPlayground() }
}

#Preview("TaskListPlayground") {
    NavigationStack { TaskListPlayground() }
}

#Preview("GridPlayground") {
    NavigationStack { GridPlayground() }
}
