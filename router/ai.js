const router = require('koa-router')()
const fs = require('fs');
const { aiSearch } = require('../ai_service/ai-search.js')
const { aiSpeak } = require('../ai_service/ai-speak.js')

router.post('/ai_search', async (ctx) => {
  const { search_text, recipes } = ctx.request.body;
  try {
    const result = await aiSearch(search_text, recipes)
    if (result.length) {
      ctx.body = {
        code: '8000',
        data: result,
        msg: '查询成功',
      }
    } else {
      ctx.body = {
        code: '8000',
        data: '',
        msg: '记录为空'
      }
    }
  } catch (error) {
    ctx.body = {
      code: '8005',
      data: error,
      msg: '服务器异常'
    }
  }
})

router.post('/ai_speak', async (ctx) => {
  const { content } = ctx.request.body;
  try {
    const audioFilePath = await aiSpeak(content);
    if (!fs.existsSync(audioFilePath)) {
      throw new Error('File not found');
    }
    ctx.type = 'audio/mpeg';
    ctx.body = fs.createReadStream(audioFilePath);
  } catch (error) {
    console.error('Error in /ai_speak route:', error.message);
    ctx.status = 500; // 设置HTTP状态码为500
    ctx.body = {
      code: '8005',
      data: error.message,
      msg: '服务器异常'
    };
  }
});

module.exports = router