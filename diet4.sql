/*
 Navicat MySQL Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80401
 Source Host           : localhost:3306
 Source Schema         : diet

 Target Server Type    : MySQL
 Target Server Version : 80401
 File Encoding         : 65001

 Date: 01/08/2024 15:05:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hot_searches
-- ----------------------------
DROP TABLE IF EXISTS `hot_searches`;
CREATE TABLE `hot_searches`  (
  `search_id` int(0) NOT NULL AUTO_INCREMENT,
  `search_term` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `search_count` int(0) NULL DEFAULT 1,
  `last_searched_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`search_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hot_searches
-- ----------------------------
INSERT INTO `hot_searches` VALUES (1, '炒饭', 15, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (2, '烤鸡', 12, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (3, '牛排', 20, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (4, '意大利面', 18, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (5, '披萨', 22, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (6, '沙拉', 8, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (7, '寿司', 19, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (8, '火锅', 25, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (9, '炒面', 10, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (10, '烧烤', 30, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (11, '奶茶', 35, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (12, '汉堡', 40, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (13, '甜点', 14, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (14, '汤', 6, '2024-07-28 17:48:23');
INSERT INTO `hot_searches` VALUES (15, '果汁', 9, '2024-07-28 17:48:23');

-- ----------------------------
-- Table structure for ingredientcategories
-- ----------------------------
DROP TABLE IF EXISTS `ingredientcategories`;
CREATE TABLE `ingredientcategories`  (
  `category_id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '食材类别表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ingredientcategories
-- ----------------------------
INSERT INTO `ingredientcategories` VALUES (1, '肉类');
INSERT INTO `ingredientcategories` VALUES (2, '蔬菜');
INSERT INTO `ingredientcategories` VALUES (3, '调味品');

-- ----------------------------
-- Table structure for ingredients
-- ----------------------------
DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients`  (
  `ingredient_id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `category_id` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE,
  CONSTRAINT `ingredients_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `ingredientcategories` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '食材信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ingredients
-- ----------------------------
INSERT INTO `ingredients` VALUES (1, '鸡胸肉', 1);
INSERT INTO `ingredients` VALUES (2, '胡萝卜', 2);
INSERT INTO `ingredients` VALUES (3, '洋葱', 2);
INSERT INTO `ingredients` VALUES (4, '大蒜', 3);
INSERT INTO `ingredients` VALUES (5, '猪肉', 1);
INSERT INTO `ingredients` VALUES (6, '生姜', 3);
INSERT INTO `ingredients` VALUES (7, '青菜', 2);

-- ----------------------------
-- Table structure for recipeingredients
-- ----------------------------
DROP TABLE IF EXISTS `recipeingredients`;
CREATE TABLE `recipeingredients`  (
  `recipe_id` int(0) NOT NULL,
  `ingredient_id` int(0) NOT NULL,
  `quantity` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`recipe_id`, `ingredient_id`) USING BTREE,
  INDEX `ingredient_id`(`ingredient_id`) USING BTREE,
  CONSTRAINT `recipeingredients_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `recipeingredients_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '食谱和食材关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recipeingredients
-- ----------------------------
INSERT INTO `recipeingredients` VALUES (2, 1, '200克');
INSERT INTO `recipeingredients` VALUES (2, 2, '1根');
INSERT INTO `recipeingredients` VALUES (2, 3, '1个');
INSERT INTO `recipeingredients` VALUES (2, 4, '2瓣');
INSERT INTO `recipeingredients` VALUES (4, 5, '500克');
INSERT INTO `recipeingredients` VALUES (4, 6, '3片');
INSERT INTO `recipeingredients` VALUES (5, 1, '300克');
INSERT INTO `recipeingredients` VALUES (5, 4, '1瓣');

-- ----------------------------
-- Table structure for reciperatings
-- ----------------------------
DROP TABLE IF EXISTS `reciperatings`;
CREATE TABLE `reciperatings`  (
  `rating_id` int(0) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(0) NULL DEFAULT NULL,
  `user_id` int(0) NULL DEFAULT NULL,
  `rating` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`rating_id`) USING BTREE,
  INDEX `recipe_id`(`recipe_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `reciperatings_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reciperatings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '食谱评分表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reciperatings
-- ----------------------------
INSERT INTO `reciperatings` VALUES (1, 2, 6, 5);

-- ----------------------------
-- Table structure for recipes
-- ----------------------------
DROP TABLE IF EXISTS `recipes`;
CREATE TABLE `recipes`  (
  `recipe_id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `cover_image_base64` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `average_rating` float NULL DEFAULT 0,
  `made_count` int(0) NULL DEFAULT 0,
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`recipe_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '食谱信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recipes
-- ----------------------------
INSERT INTO `recipes` VALUES (2, 6, '美味鸡肉炒饭', '这是一道简单快捷的鸡肉炒饭。', '', 4.5, 100, '2024-07-24 10:03:22');
INSERT INTO `recipes` VALUES (3, 6, '美味鸡肉炒饭', '这是一道简单快捷的鸡肉炒饭。', '', 4.5, 150, '2024-07-24 18:48:06');
INSERT INTO `recipes` VALUES (4, 6, '家常红烧肉', '经典的家常红烧肉做法。', '', 4.8, 80, '2024-07-24 18:48:06');
INSERT INTO `recipes` VALUES (5, 6, '清炒时蔬', '简单的清炒时令蔬菜。', '', 4.2, 60, '2024-07-24 18:48:06');
INSERT INTO `recipes` VALUES (6, 6, '美味鸡肉炒饭', '这是一道简单快捷的鸡肉炒饭。', '', 4.5, 100, '2024-07-24 20:13:10');
INSERT INTO `recipes` VALUES (7, 6, '家常红烧肉', '经典的家常红烧肉做法。', '', 4.8, 150, '2024-07-24 20:13:10');
INSERT INTO `recipes` VALUES (8, 6, '清炒时蔬', '简单的清炒时令蔬菜。', '', 4.2, 80, '2024-07-24 20:13:10');
INSERT INTO `recipes` VALUES (9, 6, '蒜香青菜', '清淡又美味的蒜香青菜。', '', 4.3, 60, '2024-07-24 20:13:10');
INSERT INTO `recipes` VALUES (10, 6, '孜然羊肉', '香辣可口的孜然羊肉。', '', 4.6, 90, '2024-07-24 20:13:10');
INSERT INTO `recipes` VALUES (11, 6, '糖醋排骨', '酸甜可口的糖醋排骨。', '', 4.7, 120, '2024-07-24 20:13:10');
INSERT INTO `recipes` VALUES (12, 6, '麻婆豆腐', '麻辣鲜香的麻婆豆腐。', '', 4.5, 110, '2024-07-24 20:13:10');
INSERT INTO `recipes` VALUES (13, 6, '红烧茄子', '软嫩入味的红烧茄子。', '', 4.4, 95, '2024-07-24 20:13:10');
INSERT INTO `recipes` VALUES (14, 6, '香菇鸡汤', '营养丰富的香菇鸡汤。', '', 4.6, 85, '2024-07-24 20:13:10');
INSERT INTO `recipes` VALUES (15, 6, '鱼香肉丝', '经典的鱼香肉丝做法。', '', 4.7, 130, '2024-07-24 20:13:10');
INSERT INTO `recipes` VALUES (16, 6, '宫保鸡丁', '经典的宫保鸡丁，酸甜适中。', '', 4.7, 200, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (17, 6, '酸辣汤', '开胃的酸辣汤。', '', 4.5, 150, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (18, 6, '番茄炒蛋', '简单美味的番茄炒蛋。', '', 4.6, 180, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (19, 6, '鱼香茄子', '美味的鱼香茄子。', '', 4.4, 130, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (20, 6, '土豆牛腩', '软烂的土豆牛腩。', '', 4.8, 220, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (21, 6, '凉拌黄瓜', '清凉爽口的凉拌黄瓜。', '', 4.3, 110, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (22, 6, '红烧鸡翅', '酱香浓郁的红烧鸡翅。', '', 4.6, 170, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (23, 6, '茄汁排骨', '酸甜开胃的茄汁排骨。', '', 4.7, 160, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (24, 6, '清蒸鲈鱼', '清蒸鲈鱼，鲜美无比。', '', 4.8, 190, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (25, 6, '干煸四季豆', '干煸四季豆，香脆可口。', '', 4.5, 140, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (26, 6, '萝卜炖牛肉', '滋补的萝卜炖牛肉。', '', 4.7, 210, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (27, 6, '酱爆茄子', '酱香浓郁的酱爆茄子。', '', 4.6, 130, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (28, 6, '香煎豆腐', '香煎豆腐，外脆里嫩。', '', 4.4, 100, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (29, 6, '蒜蓉粉丝蒸虾', '蒜香浓郁的蒜蓉粉丝蒸虾。', '', 4.8, 180, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (30, 6, '葱油鸡', '葱香四溢的葱油鸡。', '', 4.6, 150, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (31, 6, '煎牛排', '外焦里嫩的煎牛排。', '', 4.7, 200, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (32, 6, '番茄牛腩', '酸甜适中的番茄牛腩。', '', 4.8, 230, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (33, 6, '麻辣香锅', '麻辣鲜香的麻辣香锅。', '', 4.6, 170, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (34, 6, '酱焖鲫鱼', '酱香浓郁的酱焖鲫鱼。', '', 4.7, 140, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (35, 6, '鸡蛋羹', '嫩滑的鸡蛋羹。', '', 4.5, 120, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (36, 6, '烤鸭', '皮脆肉嫩的烤鸭。', '', 4.8, 250, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (37, 6, '炒米粉', '香喷喷的炒米粉。', '', 4.6, 160, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (38, 6, '番茄鱼片汤', '酸甜适中的番茄鱼片汤。', '', 4.7, 130, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (39, 6, '香辣鸡翅', '麻辣鲜香的香辣鸡翅。', '', 4.8, 190, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (40, 6, '可乐鸡翅', '甜美可口的可乐鸡翅。', '', 4.6, 170, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (41, 6, '芹菜炒牛肉', '香脆的芹菜炒牛肉。', '', 4.5, 140, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (42, 6, '酸菜鱼', '酸辣爽口的酸菜鱼。', '', 4.7, 210, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (43, 6, '炒土豆丝', '清脆的炒土豆丝。', '', 4.4, 100, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (44, 6, '干锅花菜', '香辣的干锅花菜。', '', 4.5, 120, '2024-07-24 20:14:49');
INSERT INTO `recipes` VALUES (45, 6, '香辣虾', '麻辣鲜香的香辣虾。', '', 4.8, 220, '2024-07-24 20:14:49');

-- ----------------------------
-- Table structure for steps
-- ----------------------------
DROP TABLE IF EXISTS `steps`;
CREATE TABLE `steps`  (
  `step_id` int(0) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(0) NULL DEFAULT NULL,
  `step_number` int(0) NULL DEFAULT NULL,
  `instruction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `image_base64` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`step_id`) USING BTREE,
  INDEX `recipe_id`(`recipe_id`) USING BTREE,
  CONSTRAINT `steps_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '食谱步骤表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of steps
-- ----------------------------
INSERT INTO `steps` VALUES (1, 2, 1, '将鸡胸肉切成小块。', '');
INSERT INTO `steps` VALUES (2, 2, 2, '胡萝卜切丁。', '');
INSERT INTO `steps` VALUES (3, 2, 3, '洋葱切丁。', '');
INSERT INTO `steps` VALUES (4, 2, 4, '大蒜剁碎。', '');
INSERT INTO `steps` VALUES (5, 2, 5, '热锅凉油，加入所有食材翻炒。', '');
INSERT INTO `steps` VALUES (6, 4, 1, '将猪肉切块。', '');
INSERT INTO `steps` VALUES (7, 4, 2, '热锅加入生姜片爆香。', '');
INSERT INTO `steps` VALUES (8, 4, 3, '加入猪肉翻炒至变色。', '');
INSERT INTO `steps` VALUES (9, 4, 4, '加入调料焖煮。', '');
INSERT INTO `steps` VALUES (10, 5, 1, '青菜洗净。', '');
INSERT INTO `steps` VALUES (11, 5, 2, '大蒜剁碎。', '');
INSERT INTO `steps` VALUES (12, 5, 3, '热锅凉油，加入大蒜炒香。', '');
INSERT INTO `steps` VALUES (13, 5, 4, '加入青菜快速翻炒。', '');
INSERT INTO `steps` VALUES (14, 3, 1, '鸡胸肉切丁。', '');
INSERT INTO `steps` VALUES (15, 3, 2, '胡萝卜切丁。', '');
INSERT INTO `steps` VALUES (16, 3, 3, '洋葱切丁。', '');
INSERT INTO `steps` VALUES (17, 3, 4, '热锅凉油，加入鸡胸肉翻炒至变色。', '');
INSERT INTO `steps` VALUES (18, 3, 5, '加入胡萝卜和洋葱继续翻炒。', '');
INSERT INTO `steps` VALUES (19, 3, 6, '加入冷饭翻炒均匀。', '');
INSERT INTO `steps` VALUES (20, 3, 7, '加入盐和酱油调味，炒匀。', '');
INSERT INTO `steps` VALUES (21, 3, 8, '出锅前撒上葱花即可。', '');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (6, 'wn', '美食达人', '$2b$10$hxWDbEEXEDvIuYxwd7m5wegLZfVd8U1vsH6fq5Dz8Ci6zOY0iXfdq', '2024-07-23 22:21:19');
INSERT INTO `users` VALUES (7, 'root', 'root', '$2b$10$dig7rR81yOnVL/w.Epehve1215Wjm.PJ7jYoDsgxw1c4QrMOrbRQu', '2024-07-25 22:47:37');

SET FOREIGN_KEY_CHECKS = 1;
