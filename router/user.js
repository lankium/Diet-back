const { hashPassword, verifyPassword } = require('../utils/bcrypt.js')
const router = require('koa-router')()
const jwt = require('../utils/jwt.js')
const { userFind, userRegister } = require('../controllers/index.js')
router.prefix('/user') // 路由前缀

// 登录
router.post('/login', async (ctx) => {
  // 获取到前端传递的账号密码，去数据库中校验
  const { username, password } = ctx.request.body;
  try {
    // 去数据库校验
    const findRes = await userFind(username)
    const isMatch = await verifyPassword(password, findRes[0].password_hash)
    console.log(isMatch);
    if (isMatch) {
      let data = {
        user_id: findRes[0].user_id,
        nickname: findRes[0].nickname,
        username: findRes[0].username
      }
      // 生成token 
      let token = jwt.sign({ user_id: findRes[0].user_id, username: findRes[0].user_id, admin: true })
      ctx.body = {
        code: '8000',
        data: data,
        msg: '登录成功',
        token: token
      }
    } else {
      ctx.body = {
        code: '8004',
        data: 'error',
        msg: '用户名或密码错误'
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

// 注册
router.post('/register', async (ctx) => {
  const { username, password, nickname } = ctx.request.body;
  const password_hash = await hashPassword(password)
  if (!username || !password || !nickname) {
    ctx.body = {
      code: '8001',
      data: 'error',
      msg: '用户名或密码不能为空'
    }
    return
  }
  try {
    const findRes = await userFind(username)
    if (findRes.length) {
      ctx.body = {
        code: '8002',
        data: 'error',
        msg: '用户名已存在'
      }
      return
    }
    const registerRes = await userRegister(username, password_hash, nickname)
    if (registerRes.affectedRows) {
      ctx.body = {
        code: '8000',
        data: 'success',
        msg: '注册成功'
      }
    } else {
      ctx.body = {
        code: '8004',
        data: 'error',
        msg: '注册失败'
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