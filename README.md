### MKHotFixManager
- 很简单的JSPatchdemo。
- 对JPLoader和JPCleaner的封装。
- 里面有脚本，以及修复示例。

####你需要做的：
1.配置URL，和服务器同步返回格式。
2.配置RSA的key。
3.在程序进入的地方调用
`[[MKHotFixManager shareManager] downloadScriptAndRun];`
