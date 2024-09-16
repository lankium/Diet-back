const fs = require('fs');
const path = require('path');

// 获取当前文件的目录路径
const { client } = require('./app.service.js'); // 动态导入 ES 模块

// 文本转语音函数
async function aiSpeak(content) {
  try {
    const response = await client.audio.speech.create({
      model: 'tts-1',
      voice: "alloy",
      input: content
    }, {
      responseType: 'stream'  // 获取流数据
    });// 检查响应状态
    if (response.status === 200) {
      const outputFilePath = path.join(__dirname, 'output.mp3');
      const writer = fs.createWriteStream(outputFilePath);
      // 将响应数据流写入文件
      response.body.pipe(writer);
      return new Promise((resolve, reject) => {
        writer.on('finish', () => {
          resolve(outputFilePath);
        });
        writer.on('error', (err) => {
          console.error('保存音频文件时出错', err);
          reject(err);
        });
      });
    } else {
      console.log(`API 返回状态错误: ${response.statusText}`);
      throw new Error(`API 返回状态错误: ${response.statusText}`);
    }
  } catch (err) {
    console.log('文本转语言失败了', err);
    throw err;
  }
}

module.exports = { aiSpeak }