const mysql = require('mysql2/promise');

// 创建数据库连接
const config = require('../config/index.js')
// 线程池
const pool = mysql.createPool({
  host: config.database.HOST,
  user: config.database.USERNAME,
  password: config.database.PASSWORD,
  database: config.database.DATABASE,
  port: config.database.PORT
})

const allServices = {
  async query(sql, values) {
    try {
      // 通过线程池连接mysql
      const conn = await pool.getConnection();
      // 对连接执行某些操作
      const [rows, fields] = await conn.query(sql, values)
      pool.releaseConnection(conn);
      return Promise.resolve(rows)
    } catch (error) {
      return Promise.reject(error)
    }
  }
}

// 注册
const userRegister = (username, password_hash, nickname) => {
  let _sql = `INSERT INTO users (username, password_hash, nickname) values('${username}', '${password_hash}', '${nickname}')`
  return allServices.query(_sql)
}
// 查找账号
const userFind = (username) => {
  let _sql = `select * from users where username="${username}";`
  return allServices.query(_sql)
}
// 查询所有食谱Recipes
const FindAllRecipes = () => {
  let _sql = 'SELECT * FROM recipes'
  return allServices.query(_sql)
}
// 查询热门搜索记录
const FindHot_searchList = () => {
  let _sql = 'SELECT * FROM hot_searches;'
  return allServices.query(_sql)
}
const FindRecipe = (recipe_id) => {
  let _sql = `SELECT * FROM recipes WHERE recipe_id="${recipe_id}" `
  return allServices.query(_sql)
}
const FindSteps = (recipe_id) => {
  let _sql = `SELECT * FROM steps WHERE recipe_id="${recipe_id}" `
  return allServices.query(_sql)
}
const FindIngredients = (recipe_id) => {
  let _sql = `SELECT i.name AS ingredient_name, ri.quantity
       FROM recipeingredients ri
       JOIN ingredients i ON ri.ingredient_id = i.ingredient_id
       WHERE ri.recipe_id = ${recipe_id}`
  return allServices.query(_sql)
}

module.exports = {
  userFind,
  userRegister,
  FindAllRecipes,
  FindHot_searchList,
  FindRecipe,
  FindSteps,
  FindIngredients
}
