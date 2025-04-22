import SwiftUI
import UIKit

struct ClothingItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let imageFileName: String
}

struct WardrobeView: View {
    @State private var clothes: [ClothingItem] = []
    
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    
    var selectedCategory: String?
    
    private let columns = [ GridItem(.adaptive(minimum: 100), spacing: 20) ]
    
    init(selectedCategory: String? = nil) {
        self.selectedCategory = selectedCategory
        _clothes = State(initialValue: Self.loadItems())
    }

    var filteredClothes: [ClothingItem] {
        guard let category = selectedCategory else { return clothes }
        return clothes.filter { $0.name == category }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.1, green: 0.1, blue: 0.1)
                    .edgesIgnoringSafeArea(.all)

                content
                    .padding()
            }
            .navigationTitle(selectedCategory ?? "Your Wardrobe")
            .actionSheet(isPresented: $showingActionSheet) { addActionSheet }
            .sheet(isPresented: $showingImagePicker) { imagePicker }
            .onChange(of: selectedImage) { _, image in
                handleImage(image)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
    }

    @ViewBuilder
    private var content: some View {
        if filteredClothes.isEmpty {
            emptyState
        } else {
            gridView
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "hanger")
                .font(.system(size: 50))
                .foregroundColor(.white.opacity(0.7))
            Text("No \(selectedCategory ?? "clothing") items yet")
                .foregroundColor(.white.opacity(0.7))
                .font(.headline)
            Button { showingActionSheet = true } label: {
                Label("Add Clothing", systemImage: "plus")
                    .foregroundColor(.yellow)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(filteredClothes) { item in
                    if let uiImage = Self.loadImage(named: item.imageFileName) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .cornerRadius(8)
                    } else {
                        WardrobeItemView(imageType: .asset(name: item.imageFileName), label: item.name)
                    }
                }
            }
        }
    }

    private var addActionSheet: ActionSheet {
        ActionSheet(
            title: Text("Add Clothing"),
            buttons: [
                .default(Text("Take Photo")) {
                    imagePickerSource = .camera
                    showingImagePicker = true
                },
                .default(Text("Photo Library")) {
                    imagePickerSource = .photoLibrary
                    showingImagePicker = true
                },
                .cancel()
            ]
        )
    }

    private var imagePicker: some View {
        ImagePicker(sourceType: imagePickerSource, selectedImage: $selectedImage)
    }

    private func handleImage(_ image: UIImage?) {
        guard let uiImage = image else { return }
        let fileName = UUID().uuidString + ".jpg"
        if let data = uiImage.jpegData(compressionQuality: 0.8) {
            let url = Self.documentsDirectory().appendingPathComponent(fileName)
            try? data.write(to: url)
            let newName = selectedCategory ?? ""
            let newItem = ClothingItem(id: UUID(), name: newName, imageFileName: fileName)
            clothes.append(newItem)
            Self.saveItems(clothes)
        }
    }

    // MARK: Persistence
    private static func documentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    private static func dataFileURL() -> URL {
        documentsDirectory().appendingPathComponent("clothing_items.json")
    }

    private static func loadItems() -> [ClothingItem] {
        let url = dataFileURL()
        guard let data = try? Data(contentsOf: url),
              let items = try? JSONDecoder().decode([ClothingItem].self, from: data)
        else { return [] }
        return items
    }

    private static func saveItems(_ items: [ClothingItem]) {
        let url = dataFileURL()
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: url)
        }
    }

    private static func loadImage(named fileName: String) -> UIImage? {
        let url = documentsDirectory().appendingPathComponent(fileName)
        return UIImage(contentsOfFile: url.path)
    }
    }


struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let img = info[.originalImage] as? UIImage {
                parent.selectedImage = img
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
