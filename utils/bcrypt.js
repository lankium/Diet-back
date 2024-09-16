const bcrypt = require('bcrypt');

// 生成哈希密码
async function hashPassword(password) {
  const saltRounds = 10;
  const hashedPassword = await bcrypt.hash(password, saltRounds);
  return hashedPassword;
}

// 验证密码
async function verifyPassword(inputPassword, storedHash) {
  const match = await bcrypt.compare(inputPassword, storedHash);
  return match;
}

module.exports = {
  hashPassword,
  verifyPassword
}