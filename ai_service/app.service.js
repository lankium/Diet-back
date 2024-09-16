// 接口， embedding
// vue -> 数学向量 -> 多维空间中的向量 -> 任何一个词或物体都可以在空间中找到
// vue vue-router 相近？ 计算就可以拿到相似性
// const dotenv = require('dotenv');
// dotenv.config({ path: '.env' });
// https://api.302.ai/v1/chat/completions
// apiKey: 'sk-Rwqkr8Bc4jdJrBowq16eVV4YxXF75VrNDy07wLiyHQFSenB0'
const OpenAI = require('openai');

const client = new OpenAI({
  baseURL: 'https://api.302.ai/v1',
  // apiKey: process.env.OPENAI_KEY,
  apiKey: 'sk-Rwqkr8Bc4jdJrBowq16eVV4YxXF75VrNDy07wLiyHQFSenB0'
});

module.exports = { client };
