# Language Server部署
本文档将会列举该项目支持的语言的language server的简单配置步骤

本项目使用项目[jsonrpc-ws-proxy](https://github.com/wylieconlon/jsonrpc-ws-proxy)作为Language Server的代理，使得前端可以直接使用websocket与各个Language Server通信，如果你有更好的选择，也可以使用其他项目

- [Language Server部署](#language-server部署)
- [jsonrpc-ws-proxy代理安装与配置](#jsonrpc-ws-proxy代理安装与配置)
- [各个语言的Language Server的简易安装及其对应yml配置](#各个语言的language-server的简易安装及其对应yml配置)
  - [C/C++](#cc)

# jsonrpc-ws-proxy代理安装与配置
克隆项目
```bash
git clone https://github.com/wylieconlon/jsonrpc-ws-proxy.git
```
编译项目
```bash
cd jsonrpc-ws-proxy
npm install
npm run prepare
```
创建一个servers.yml文件，内容为各个language server的配置，以ccls作为c++语言的language server为例，其他语言类推加入配置即可，本文档往后的配置将省略根配置"langservers"，只列出语言具体配置，请注意缩进
```yml
langservers:
  cpp: #语言名称
    - ccls #运行的language server
    - "--init={\"cache\":{\"directory\": \"\", \"format\": \"json\"},\"index\":{\"onChange\":true,\"trackDependency\":2}}" #运行测参数
```
运行代理
```bash
node dist/server.js --port 3000 --languageServers servers.yml
```

# 各个语言的Language Server的简易安装及其对应yml配置
## C/C++
完整流程及细节可参考[官方文档](https://github.com/MaskRay/ccls/wiki)

安装所需环境
```bash
sudo apt install cmake
sudo apt install clang libclang-10-dev
```

克隆ccls项目
```bash
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
```

编译ccls项目
```bash
cd ccls
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=/usr/lib/llvm-10 \
    -DLLVM_INCLUDE_DIR=/usr/lib/llvm-10/include \
    -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-10/
```

安装ccls项目
```bash
cmake --build Release
```

检查ccls可用性，即使输出版本号为unknow也可用
```bash
ccls --version
```

对应servers.yml文件运行配置
```yaml
cpp:
    - ccls
    - "--init={\"cache\":{\"directory\": \"\", \"format\": \"json\"},\"index\":{\"onChange\":true,\"trackDependency\":2}}"
```