import SwiftUI

// 1. 定义符合作业要求的数据模型
struct CloudFile: Identifiable, Codable {
    var id: String { file_id }       // 绑定 SwiftUI 要求的唯一 ID
    let file_id: String              // 文件唯一标识
    let name: String                 // 文件名
    let size: Int64                  // 文件大小（B）
    let path: String                 // 服务器路径
    let timestamp: TimeInterval      // 上传时间戳
    
    // 字节转换成 KB/MB
    var formattedSize: String {
        ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
    }
    
    // 时间戳转换成可读日期
    var formattedDate: String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
}

// 2. 界面视图
struct ContentView: View {
    // 模拟网盘的假数据
    @State private var fileList: [CloudFile] = [
        CloudFile(file_id: "1", name: "算法期末复习资料.pdf", size: 1048576 * 5, path: "/file/1", timestamp: 1787472000),
        CloudFile(file_id: "2", name: "最新产品演示视频.mp4", size: 1048576 * 45, path: "/file/2", timestamp: 1787558400),
        CloudFile(file_id: "3", name: "大作业开题报告.docx", size: 1024 * 350, path: "/file/3", timestamp: 1787644800)
    ]
    var body: some View {
            NavigationStack { // 整个页面的大舞台（有了它才能跳转）
                List(fileList) { file in
                    
                    // ⬇️ 关键改动：给每一行套上 NavigationLink。
                    // destination 表示目的地，点击这一行，就跳转到我们刚刚新建的 FileDetailView 页面
                    NavigationLink(destination: FileDetailView(file: file)) {
                        
                        // 里面完全保持你原本的 HStack 结构不变
                        HStack(spacing: 15) {
                            Image(systemName: file.name.hasSuffix(".mp4") ? "video.fill" : "doc.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(file.name)
                                    .font(.headline)
                                HStack {
                                    Text(file.formattedSize)
                                    Text("•")
                                    Text(file.formattedDate)
                                }
                                .font(.caption)
                                .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                        
                    } // ⬆️ NavigationLink 结束
                    
                }
                .navigationTitle("我的云网盘")
                .toolbar {
                    Button(action: { print("点击了上传22222") }) {
                        Image(systemName: "plus.circle.fill").font(.title2)
                    }
                }
            }
        }
    
}

#Preview {
    ContentView()
}
