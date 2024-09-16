const router = require('koa-router')()
const { FindHot_searchList } = require('../controllers/index.js')

router.post('/hot_searchList', async (ctx) => {
  try {
    // 去数据库查询热门搜索记录
    const result = await FindHot_searchList()
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

module.exports = router