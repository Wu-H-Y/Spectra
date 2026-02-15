<div align="center">

# Spectra

**现代化多媒体数据采集应用**

一款现代化的桌面和移动端多媒体数据采集应用，支持视频、音乐、小说、漫画和图片，支持自定义爬虫规则。

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-blue)]()

<img src="assets/icon.svg" alt="Spectra Logo" width="128" height="128">

</div>

---

## ✨ 功能特性

- 🎬 **视频采集** - 支持多种视频源的采集和下载
- 🎵 **音乐采集** - 批量采集音乐资源
- 📚 **小说采集** - 支持网络小说和本地小说管理
- 📖 **漫画采集** - 漫画资源采集与阅读
- 🖼️ **图片采集** - 图片批量采集和管理
- 🔧 **自定义规则** - 灵活的爬虫规则系统，支持用户自定义
- 📱 **跨平台** - 支持 Android、iOS、Windows、macOS、Linux

## 📥 安装

### 下载安装包

前往 [Releases](../../releases) 页面下载对应平台的安装包。

| 平台    | 文件格式 | 说明                     |
| ------- | -------- | ------------------------ |
| Android | `.apk`   | 直接安装                 |
| iOS     | `.ipa`   | 需要自签名安装           |
| Windows | `.zip`   | 解压后运行 `Spectra.exe` |
| macOS   | `.zip`   | 解压后运行 `Spectra.app` |
| Linux   | `.zip`   | 解压后运行 `./Spectra`   |

### 从源码构建

```bash
# 克隆仓库
git clone https://github.com/Wu-H-Y/spectra.git
cd spectra

# 安装依赖
flutter pub get

# 安装 Git Hooks (可选，用于提交规范检查)
dart pub global activate git_hooks
dart run git_hooks create git_hooks.dart

# 运行应用
flutter run

# 构建 release 版本
flutter build <platform> --release
```

## 🚀 快速开始

1. **添加数据源** - 在设置中添加自定义爬虫规则
2. **浏览内容** - 使用内置浏览器访问目标网站
3. **采集数据** - 一键采集所需的多媒体资源
4. **管理收藏** - 在本地管理和查看采集的内容

## 📖 文档

- [贡献指南](.github/CONTRIBUTING.md) - 如何参与项目开发
- [分支规则](docs/BRANCHING.md) - Git 分支管理规范
- [提交规范](docs/COMMIT_CONVENTION.md) - Conventional Commits 规范
- [发布指南](docs/RELEASE.md) - 版本发布流程

## 🛠️ 技术栈

- [Flutter](https://flutter.dev/) - UI 框架
- [Dart](https://dart.dev/) - 编程语言

## 🤝 贡献

欢迎贡献代码、报告 Bug 或提出新功能建议！

1. Fork 本仓库
2. 创建功能分支 (`git checkout -b feat/your-feature`)
3. 提交更改 (`git commit -m 'feat: 添加新功能'`)
4. 推送到分支 (`git push origin feat/your-feature`)
5. 创建 Pull Request

详见 [贡献指南](.github/CONTRIBUTING.md)。

## 📝 开发状态

项目正在积极开发中，功能可能会发生变化。

## ⚠️ 免责声明

**请在使用本软件前仔细阅读以下声明：**

1. **本项目仅供学习和研究使用**，不得用于任何商业或非法用途。

2. **用户责任**：本软件仅提供技术框架和数据采集工具，用户需自行确保采集行为符合目标网站的服务条款和相关法律法规。使用本软件所产生的一切法律责任由用户自行承担。

3. **尊重版权**：本软件不提供、不存储、不传播任何受版权保护的内容。所有采集的多媒体资源均来自第三方网站，版权归原始作者或版权方所有。请支持正版，尊重创作者的劳动成果。

4. **无担保**：本软件按"原样"提供，不提供任何形式的明示或暗示担保，包括但不限于适销性和特定用途适用性的担保。作者不对因使用本软件而产生的任何直接或间接损失负责。

5. **合规使用**：用户应遵守《中华人民共和国网络安全法》、《中华人民共和国著作权法》等相关法律法规，不得利用本软件从事违法违规活动。

6. **爬虫规则**：本软件的自定义规则功能仅供技术研究和合法数据采集使用。用户应遵守目标网站的 robots.txt 协议，合理控制访问频率，避免对目标服务器造成过大负担。

**使用本软件即表示您已阅读、理解并同意遵守以上声明。如果您不同意，请勿使用本软件。**

📄 完整免责声明请查看 [DISCLAIMER.md](DISCLAIMER.md)。

## 📄 许可证

本项目采用 GNU Affero General Public License v3.0 许可证 - 详见 [LICENSE](LICENSE) 文件。

**注意**: AGPL-3.0 是一种严格的开源许可证，要求：

- 任何修改版本必须以相同许可证发布
- 网络服务使用也必须提供源代码
- 必须保留版权声明和许可证副本

## 👤 作者

**Wu-H-Y**

- GitHub: [@Wu-H-Y](https://github.com/Wu-H-Y)

---

<div align="center">

如果这个项目对你有帮助，请给一个 ⭐️ Star 支持一下！

</div>
