CREATE TABLE admin_reply_log (
  admin_id VARCHAR2(255) NOT NULL,
  target_user_id VARCHAR2(255) NOT NULL,
  created_by VARCHAR2(255) NOT NULL,
  created_at DATE NOT NULL DEFAULT 'now()',
  message VARCHAR2(255),
  reply_id NUMBER PRIMARY KEY NOT NULL,
  target_id NUMBER NOT NULL,
  target_type VARCHAR2(255) NOT NULL
);


CREATE TABLE allergy (
  allergy_id NUMBER PRIMARY KEY NOT NULL,
  description VARCHAR2(255),
  name VARCHAR2(255) NOT NULL
);


CREATE TABLE category (
  category_id NUMBER PRIMARY KEY NOT NULL,
  name VARCHAR2(255) NOT NULL
);


CREATE TABLE comment (
  comment_id NUMBER PRIMARY KEY NOT NULL,
  content VARCHAR2(255) NOT NULL,
  created_at DATE NOT NULL DEFAULT 'now()',
  parent_id NUMBER,
  post_id NUMBER NOT NULL,
  qna_id NUMBER,
  user_id VARCHAR2(255) NOT NULL
);


CREATE TABLE cooking_step (
  description VARCHAR2(255) NOT NULL,
  recipe_id NUMBER FK NOT NULL,
  step_id NUMBER PRIMARY KEY NOT NULL,
  step_order NUMBER NOT NULL
);


CREATE TABLE data_update_request (
  created_by VARCHAR2(255) NOT NULL,
  admin_reply CLOB,
  created_at DATE NOT NULL DEFAULT 'now()',
  description CLOB,
  processed_at DATE,
  request_id NUMBER PRIMARY KEY NOT NULL,
  status VARCHAR2(255) DEFAULT 'PENDING',
  title VARCHAR2(255) NOT NULL,
  user_id VARCHAR2(255) NOT NULL
);


CREATE TABLE drink (
  abv NUMBER NOT NULL,
  created_by VARCHAR2(255) NOT NULL,
  description CLOB,
  drink_id NUMBER PRIMARY KEY NOT NULL,
  drink_like_count NUMBER NOT NULL DEFAULT '0',
  image_url VARCHAR2(255),
  name VARCHAR2(255) NOT NULL,
  price NUMBER NOT NULL,
  seller_link VARCHAR2(255),
  type VARCHAR2(255) NOT NULL
);


CREATE TABLE drink_image (
  description VARCHAR2(255),
  drink_id NUMBER NOT NULL,
  image_id NUMBER PRIMARY KEY NOT NULL,
  image_url VARCHAR2(255) NOT NULL
);


CREATE TABLE drink_tag (
  drink_id NUMBER PRIMARY KEY NOT NULL,
  tag_id NUMBER PRIMARY KEY NOT NULL
);


CREATE TABLE faq (
  answer VARCHAR2(255),
  faq_id NUMBER PRIMARY KEY NOT NULL,
  question VARCHAR2(255) NOT NULL
);


CREATE TABLE health_condition (
  condition_id NUMBER PRIMARY KEY NOT NULL,
  description VARCHAR2(255),
  name VARCHAR2(255) NOT NULL
);


CREATE TABLE health_recommend (
  condition_id NUMBER NOT NULL,
  reason VARCHAR2(255),
  recipe_id NUMBER NOT NULL
);


CREATE TABLE like_log (
  like_id NUMBER PRIMARY KEY NOT NULL,
  target_id NUMBER NOT NULL,
  target_type VARCHAR2(255) NOT NULL,
  user_id VARCHAR2(255) NOT NULL
);


CREATE TABLE notice (
  content VARCHAR2(255) NOT NULL,
  created_at DATE NOT NULL DEFAULT 'now()',
  hit number NOT NULL,
  notice_id NUMBER PRIMARY KEY NOT NULL,
  title VARCHAR2(255) NOT NULL
);


CREATE TABLE pairing (
  drink_id NUMBER NOT NULL,
  pairing_id NUMBER PRIMARY KEY NOT NULL,
  reason VARCHAR2(255),
  recipe_id NUMBER NOT NULL
);


CREATE TABLE post (
  content CLOB NOT NULL,
  created_at DATE NOT NULL DEFAULT 'now()',
  post_id NUMBER PRIMARY KEY NOT NULL,
  title VARCHAR2(255) NOT NULL,
  type VARCHAR2(255) NOT NULL,
  updated_at DATE,
  user_id VARCHAR2(255) NOT NULL
  post_category VARCHAR2(50) NOT NULL DEFAULT '자유게시판'
  view_count NUMBER DEFAULT '0' NOT NULL
);


CREATE TABLE post_file (
  file_id NUMBER PRIMARY KEY NOT NULL,
  file_size NUMBER,
  original_filename VARCHAR2(255) NOT NULL,
  post_id NUMBER NOT NULL,
  stored_path VARCHAR2(255) NOT NULL,
  updated_at DATE NOT NULL DEFAULT 'now()'
);


CREATE TABLE qna (
  answer VARCHAR2(255),
  answered_at DATE,
  content VARCHAR2(255) NOT NULL,
  created_at DATE NOT NULL DEFAULT 'now()',
  is_answered VARCHAR2(255) NOT NULL DEFAULT 'N',
  qna_id NUMBER PRIMARY KEY NOT NULL,
  title VARCHAR2(255) NOT NULL,
  user_id VARCHAR2(255) NOT NULL
);


CREATE TABLE recipe (
  created_at DATE NOT NULL DEFAULT SYSDATE,
  created_by VARCHAR2(255) NOT NULL,
  description VARCHAR2(255),
  image_url VARCHAR2(255),
  name VARCHAR2(255) NOT NULL,
  recipe_id NUMBER PRIMARY KEY NOT NULL,
  category_id NUMBER NOT NULL,
  CONSTRAINT fk_recipe_category FOREIGN KEY (category_id) REFERENCES category(category_id)
);



CREATE TABLE recipe_allergy (
  allergy_id NUMBER NOT NULL,
  recipe_id NUMBER NOT NULL
);


CREATE TABLE recipe_ingredient (
  allergy_id NUMBER NOT NULL,
  ingredient_name VARCHAR2(255) NOT NULL,
  recipe_id NUMBER NOT NULL,
  recipe_ingredient_id NUMBER PRIMARY KEY NOT NULL
);


CREATE TABLE recipe_search_log (
  keyword VARCHAR2(255) NOT NULL,
  log_id NUMBER PRIMARY KEY NOT NULL,
  searched_at DATE NOT NULL,
  user_id VARCHAR2(255) NOT NULL
);


CREATE TABLE recipe_tag (
  recipe_id NUMBER PRIMARY KEY NOT NULL,
  tag_id NUMBER PRIMARY KEY NOT NULL
);


CREATE TABLE report_post (
  checked_at DATE,
  is_checked VARCHAR2(255) NOT NULL DEFAULT 'N',
  post_id NUMBER NOT NULL,
  reason VARCHAR2(255) NOT NULL,
  report_id NUMBER PRIMARY KEY NOT NULL,
  user_id VARCHAR2(255) NOT NULL,
  reported_at DATE NOT NULL DEFAULT 'now()',
  reporter_id VARCHAR2(255) NOT NULL
);


CREATE TABLE report_user (
  checked_at DATE,
  is_checked VARCHAR2(255) NOT NULL DEFAULT 'N',
  reason VARCHAR2(255) NOT NULL,
  report_id NUMBER PRIMARY KEY NOT NULL,
  reported_at DATE NOT NULL DEFAULT 'now()',
  reported_user_id VARCHAR2(255) NOT NULL,
  reporter_id VARCHAR2(255) NOT NULL
);


CREATE TABLE search_log (
  keyword VARCHAR2(255) NOT NULL,
  log_id NUMBER PRIMARY KEY NOT NULL,
  search_type VARCHAR2(255) NOT NULL DEFAULT 'recipe',
  searched_at DATE NOT NULL DEFAULT 'now()',
  user_id VARCHAR2(255) NOT NULL
);


CREATE TABLE tag (
  name VARCHAR2(255) NOT NULL,
  tag_id NUMBER PRIMARY KEY NOT NULL
);


CREATE TABLE user (
  created_at DATE NOT NULL DEFAULT 'now()',
  email VARCHAR2(255) NOT NULL,
  member_num NUMBER PRIMARY KEY NOT NULL,
  nickname VARCHAR2(255) NOT NULL,
  password VARCHAR2(255) NOT NULL,
  provider VARCHAR2(255) NOT NULL,
  role VARCHAR2(255) NOT NULL DEFAULT 'USER',
  status VARCHAR2(255) NOT NULL DEFAULT 'ACTIVE',
  user_id VARCHAR2(255) NOT NULL,
  username VARCHAR2(255) NOT NULL
);


CREATE TABLE user_allergy (
  allergy_id NUMBER NOT NULL,
  user_id VARCHAR2(255) NOT NULL
);


CREATE TABLE user_tag (
  tag_id NUMBER PRIMARY KEY NOT NULL,
  user_id NUMBER PRIMARY KEY NOT NULL,
  weight VARCHAR2(255) DEFAULT '1.0'
);


CREATE TABLE visit_log (
  ip_address VARCHAR2(255) NOT NULL,
  log_id NUMBER PRIMARY KEY NOT NULL,
  page_url VARCHAR2(255) NOT NULL,
  user_id VARCHAR2(255) NOT NULL,
  visited_at DATE NOT NULL,
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255),
  Ref: VARCHAR2(255)
);
