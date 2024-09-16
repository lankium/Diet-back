const router = require('koa-router')()
const { FindAllRecipes, FindRecipe, FindSteps, FindIngredients } = require('../controllers/index.js')

router.post('/recipes', async (ctx) => {
  try {
    // 去数据库查询食谱
    const result = await FindAllRecipes()
    if (result.length) {
      ctx.body = {
        code: '8000',
        data: result,
        msg: '查询成功',
      }
    } else {
      ctx.body = {
        code: '8000',
        data: '食谱为空',
        msg: '食谱为空'
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

router.post('/recipeDetail', async (ctx) => {
  const { recipe_id } = ctx.request.body
  try {
    // 去数据库查询食谱
    const recipe = await FindRecipe(recipe_id)
    const recipeDetail = await FindSteps(recipe_id)
    const recipeingredients = await FindIngredients(recipe_id)
    if (recipe.length) {
      ctx.body = {
        code: '8000',
        data: { recipe, recipeDetail, recipeingredients },
        msg: '查询成功',
      }
    } else {
      ctx.body = {
        code: '8000',
        data: '食谱为空',
        msg: '食谱为空'
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

