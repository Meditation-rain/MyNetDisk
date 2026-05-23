//
//  FileDetailView.swift
//  MyNetDisk
//
//  Created by chenshiyu on 2026/5/23.
//

import SwiftUI

// 这是一张白纸：我们全新定制的“文件详情页”
struct FileDetailView: View {
    // 接收从上一个页面（列表页）传过来的具体文件数据
    let file: CloudFile
    
    var body: some View {
        VStack(spacing: 25) {
            // 1. 根据文件类型显示大图标
            Image(systemName: file.name.hasSuffix(".mp4") ? "video.fill" : "doc.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding(.top, 40)
            
            // 2. 显示文件名
            Text(file.name)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // 3. 用一个精致的卡片包起来显示详细字段
            VStack(alignment: .leading, spacing: 12) {
                detailRow(label: "文件 ID", value: file.file_id)
                Divider() // 灰色的分割线
                detailRow(label: "文件大小", value: file.formattedSize)
                Divider()
                detailRow(label: "存储路径", value: file.path)
                Divider()
                detailRow(label: "上传时间", value: file.formattedDate)
            }
            .padding()
            .background(Color(.systemGray6)) // 浅灰色背景
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer() // 把内容撑到最上方
        }
        .navigationTitle("文件详情") // 新页面的顶部标题
        .navigationBarTitleDisplayMode(.inline) // 变成精致的小标题
    }
    
    // 一个抽离出来的辅助小组件，用来画每一行属性
    func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label).foregroundColor(.gray)
            Spacer()
            Text(value).bold()
        }
        .font(.subheadline)
    }
}
