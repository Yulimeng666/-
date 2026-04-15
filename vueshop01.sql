/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80037 (8.0.37)
 Source Host           : localhost:3306
 Source Schema         : vueshop01

 Target Server Type    : MySQL
 Target Server Version : 80037 (8.0.37)
 File Encoding         : 65001

 Date: 30/10/2025 23:27:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `address_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户ID',
  `recipient_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系电话',
  `detail_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详细地址',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否默认地址（0=否，1=是）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`address_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_address_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收货地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 1, '一个普通人', '13580655555', '广州市从化区', 0, '2025-10-15 17:18:48');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cart_item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '购物车项ID',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户ID',
  `product_id` bigint UNSIGNED NOT NULL COMMENT '商品ID',
  `quantity` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '数量',
  `is_selected` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否选中（0=未选，1=选中）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`cart_item_id`) USING BTREE,
  UNIQUE INDEX `uniq_user_product`(`user_id` ASC, `product_id` ASC) USING BTREE,
  UNIQUE INDEX `uk_user_product`(`user_id` ASC, `product_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `fk_cart_product`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_cart_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (5, 1, 3, 5, 1, '2025-10-21 10:00:17', '2025-10-26 23:44:34');
INSERT INTO `cart` VALUES (6, 1, 1, 1, 1, '2025-10-21 10:00:20', '2025-10-21 10:00:20');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `parent_id` int UNSIGNED NULL DEFAULT 0 COMMENT '父分类ID（0表示顶级分类）',
  `sort_order` smallint UNSIGNED NULL DEFAULT 0 COMMENT '排序值',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT 1,
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '手机数码', 0, 1, 'phone', 1);
INSERT INTO `category` VALUES (2, '电脑办公', 0, 2, 'computer', 1);
INSERT INTO `category` VALUES (3, '家用电器', 0, 3, 'appliance', 1);
INSERT INTO `category` VALUES (4, '服装鞋帽', 0, 4, 'clothes', 1);
INSERT INTO `category` VALUES (5, '食品生鲜', 0, 5, 'food', 1);
INSERT INTO `category` VALUES (6, '美妆护肤', 0, 6, 'cosmetic', 1);
INSERT INTO `category` VALUES (7, '母婴玩具', 0, 7, 'baby', 1);
INSERT INTO `category` VALUES (8, '运动户外', 0, 8, 'sports', 1);
INSERT INTO `category` VALUES (9, '汽车用品', 0, 9, 'car', 1);
INSERT INTO `category` VALUES (10, '图书音像', 0, 10, 'book', 1);
INSERT INTO `category` VALUES (11, '手机', 1, 1, NULL, 1);
INSERT INTO `category` VALUES (12, '平板电脑', 1, 2, NULL, 1);
INSERT INTO `category` VALUES (13, '耳机', 1, 3, NULL, 1);
INSERT INTO `category` VALUES (14, '相机', 1, 4, NULL, 1);
INSERT INTO `category` VALUES (15, '智能设备', 1, 5, NULL, 1);
INSERT INTO `category` VALUES (16, '手机配件', 1, 6, NULL, 1);
INSERT INTO `category` VALUES (17, '笔记本', 2, 1, NULL, 1);
INSERT INTO `category` VALUES (18, '台式机', 2, 2, NULL, 1);
INSERT INTO `category` VALUES (19, '显示器', 2, 3, NULL, 1);
INSERT INTO `category` VALUES (20, '办公设备', 2, 4, NULL, 1);
INSERT INTO `category` VALUES (21, '网络产品', 2, 5, NULL, 1);
INSERT INTO `category` VALUES (22, '电脑配件', 2, 6, NULL, 1);

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `order_item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单项ID',
  `order_id` bigint UNSIGNED NOT NULL COMMENT '订单ID',
  `product_id` bigint UNSIGNED NOT NULL COMMENT '商品ID',
  `product_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品快照名称',
  `product_price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '商品快照价格',
  `quantity` int UNSIGNED NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`order_item_id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `fk_order_item_product`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_item_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单商品明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (1, 1, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (2, 2, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (3, 3, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (5, 5, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (6, 6, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (7, 7, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (8, 8, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (9, 9, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (10, 10, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (11, 11, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (12, 12, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (13, 13, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (14, 14, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (15, 15, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (16, 16, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);
INSERT INTO `order_item` VALUES (17, 17, 3, 'Apple/苹果 iPhone 17 Pro（A3294）', 6488.00, 1);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_sn` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号（业务唯一标识）',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户ID',
  `address_id` bigint UNSIGNED NOT NULL COMMENT '收货地址ID',
  `total_amount` decimal(10, 2) UNSIGNED NOT NULL COMMENT '订单总金额',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`order_id`) USING BTREE,
  UNIQUE INDEX `uniq_order_sn`(`order_sn` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `fk_order_address`(`address_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 'O17610119945575442523F', 1, 1, 6488.00, '待发货', '2025-10-21 09:59:55');
INSERT INTO `orders` VALUES (2, 'O1761012070111F78F126D', 1, 1, 6488.00, '待发货', '2025-10-21 10:01:10');
INSERT INTO `orders` VALUES (3, 'O17610122808543F94737E', 1, 1, 6488.00, '待发货', '2025-10-21 10:04:41');
INSERT INTO `orders` VALUES (5, 'O1761012838215204F04E9', 1, 1, 6488.00, '待付款', '2025-10-21 10:13:58');
INSERT INTO `orders` VALUES (6, 'O176112498240342450565', 1, 1, 6488.00, '待发货', '2025-10-22 17:23:02');
INSERT INTO `orders` VALUES (7, 'O1761125051167F1419522', 1, 1, 6488.00, '待发货', '2025-10-22 17:24:11');
INSERT INTO `orders` VALUES (8, 'O1761125101380E26C1E45', 1, 1, 6488.00, '待发货', '2025-10-22 17:25:01');
INSERT INTO `orders` VALUES (9, 'O1761125185866380CA971', 1, 1, 6488.00, '待发货', '2025-10-22 17:26:26');
INSERT INTO `orders` VALUES (10, 'O1761125223930B981F7D5', 1, 1, 6488.00, '待发货', '2025-10-22 17:27:04');
INSERT INTO `orders` VALUES (11, 'O176112710964873EECE31', 1, 1, 6488.00, '待发货', '2025-10-22 17:58:30');
INSERT INTO `orders` VALUES (12, 'O17611277081968C831CCA', 1, 1, 6488.00, '待发货', '2025-10-22 18:08:28');
INSERT INTO `orders` VALUES (13, 'O1761493483543FFABB35F', 1, 1, 6488.00, '待发货', '2025-10-26 23:44:44');
INSERT INTO `orders` VALUES (14, 'O1761613623894795252C3', 1, 1, 6488.00, '待发货', '2025-10-28 09:07:04');
INSERT INTO `orders` VALUES (15, 'O1761614105282352CB3BF', 1, 1, 6488.00, '待付款', '2025-10-28 09:15:05');
INSERT INTO `orders` VALUES (16, 'O17616141107887990DB88', 1, 1, 6488.00, '待发货', '2025-10-28 09:15:11');
INSERT INTO `orders` VALUES (17, 'O1761614120746EDC34131', 1, 1, 6488.00, '待发货', '2025-10-28 09:15:21');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `product_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `product_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品描述',
  `price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '价格',
  `stock` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '库存数量',
  `category_id` int UNSIGNED NOT NULL COMMENT '所属分类ID',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '上架状态（0=下架，1=上架）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品主图URL',
  `detail_images` json NULL COMMENT '产品详情图片(JSON数组格式)',
  `specifications` json NULL COMMENT '产品规格参数(JSON格式)',
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `idx_category`(`category_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_price`(`price` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  FULLTEXT INDEX `idx_product_name`(`product_name`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 'Apple/苹果 iPhone 16 Pro（A3294）', '白色钛金属 支持移动联通电信5G 双卡双待手机', 6499.00, 99, 1, 1, '2025-09-23 10:16:46', '2025-09-23 10:16:46', '/uploads/images/17c49b34-d428-4c3e-b4c7-fcd1f0e25d50.jpg', '[\"/uploads/images/4f5228af-6727-40aa-9e2e-fd26e2fe95ab.jpg\", \"/uploads/images/b0f5ec93-8f78-4370-880a-a6f932305259.jpg\", \"/uploads/images/84653063-9c68-43ab-9ef9-1281750783de.jpg\", \"/uploads/images/766163bf-2ae3-411f-b09d-f4b7da96447b.jpg\", \"/uploads/images/94400ad4-7a0b-4c7b-9751-f5ddf9d9f595.jpg\"]', '{\"版本\": [\"128GB\", \"256GB\"]}');
INSERT INTO `product` VALUES (3, 'Apple/苹果 iPhone 17 Pro（A3294）', '白色钛金属 支持移动联通电信5G 双卡双待手机', 6488.00, 83, 1, 1, '2025-09-30 09:48:24', '2025-10-28 09:15:21', '/uploads/images/d7fd47c3-b4da-419d-a8ed-22d615556603.jpg', '[\"/uploads/images/c247d0a6-a029-4f1f-8154-f8c44513d93e.jpg\", \"/uploads/images/5eca6a9a-3f70-402c-9cd1-06f22fa462e3.jpg\", \"/uploads/images/4b6690e0-f0af-4103-afee-1634dae9ff13.jpg\", \"/uploads/images/8e9f1a0e-2274-4542-84ab-d83c72f9e695.jpg\", \"/uploads/images/2ea348b5-b57e-4136-bca4-8034414c72d5.jpg\"]', '{\"版本\": [\"128GB\", \"256GB\"]}');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像URL',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `uniq_username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `uniq_phone`(`phone` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'root1', '$2a$10$bziM/ecrt5EXpvFt7qcVxOBP9UA6gH/bW0.8.IwtW/eX4V8hQSirm', '13811111111', '123@qq.com', 'default-avatar.png', '2025-10-21 09:51:12');
INSERT INTO `user` VALUES (2, 'root', '$2a$10$O5DE7fF.Ut87zGjpqYjbQOG27NFxp268S.qgU2VAKOdalgId96Wz2', '16311111111', '1234@qq.com', 'default-avatar.png', '2025-09-17 17:10:08');

SET FOREIGN_KEY_CHECKS = 1;
