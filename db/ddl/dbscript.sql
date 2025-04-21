-- 🔻 DROP EXISTING OBJECTS
DROP TABLE admin_reply_log CASCADE CONSTRAINTS;
DROP TABLE allergy CASCADE CONSTRAINTS;
DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE comment CASCADE CONSTRAINTS;
DROP TABLE drink CASCADE CONSTRAINTS;
DROP TABLE faq CASCADE CONSTRAINTS;
DROP TABLE health_condition CASCADE CONSTRAINTS;
DROP TABLE health_recommend CASCADE CONSTRAINTS;
DROP TABLE image CASCADE CONSTRAINTS;
DROP TABLE likes CASCADE CONSTRAINTS;
DROP TABLE notice CASCADE CONSTRAINTS;
DROP TABLE pairing CASCADE CONSTRAINTS;
DROP TABLE post_file CASCADE CONSTRAINTS;
DROP TABLE qna CASCADE CONSTRAINTS;
DROP TABLE recipe CASCADE CONSTRAINTS;
DROP TABLE recipe_ingredient CASCADE CONSTRAINTS;
DROP TABLE report_post CASCADE CONSTRAINTS;
DROP TABLE report_user CASCADE CONSTRAINTS;
DROP TABLE search_log CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE user_allergy CASCADE CONSTRAINTS;
DROP TABLE visit_log CASCADE CONSTRAINTS;

-- 📦 CREATE TABLES

-- CREATE TABLE: users
CREATE TABLE users (
    user_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR2(100) NOT NULL,
    nickname VARCHAR2(50) NOT NULL,
    password VARCHAR2(100) NOT NULL,
    provider VARCHAR2(20) NOT NULL,
    role VARCHAR2(10) DEFAULT 'USER' NOT NULL CHECK (role IN ('USER', 'ADMIN')),
    status VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL CHECK (status IN ('ACTIVE', 'INACTIVE')),
    login_id VARCHAR2(50) NOT NULL UNIQUE,
    username VARCHAR2(50) NOT NULL,
    created_at DATE DEFAULT SYSDATE NOT NULL
);

-- CREATE TABLE: allergy
CREATE TABLE allergy (
    allergy_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    description VARCHAR2(200)
);

-- CREATE TABLE: board
CREATE TABLE board (
    board_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(4000) NOT NULL,
    login_id VARCHAR2(50) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE,
    board_category VARCHAR2(100) NOT NULL,
    view_count NUMBER DEFAULT 0 NOT NULL,
    avg_rating NUMBER(3,1) DEFAULT 0 NOT NULL,
    recommend_number NUMBER DEFAULT 0 NOT NULL,
    CONSTRAINT fk_board_login_id FOREIGN KEY (login_id) REFERENCES users(login_id)
);

-- CREATE TABLE: comment
CREATE TABLE comment (
    comment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login_id VARCHAR2(50) NOT NULL,
    target_id NUMBER NOT NULL,
    content VARCHAR2(4000) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE,
    parent_id NUMBER,
    CONSTRAINT fk_comment_login_id FOREIGN KEY (login_id) REFERENCES users(login_id)
);

-- CREATE TABLE: drink
CREATE TABLE drink (
    drink_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(200) NOT NULL,
    alcohol_content NUMBER(4,1),
    price NUMBER,
    pairing_food VARCHAR2(255),
    description VARCHAR2(4000),
    recommend_number NUMBER DEFAULT 0 NOT NULL,
    avg_rating NUMBER(3,1) DEFAULT 0 NOT NULL,
    view_count NUMBER DEFAULT 0 NOT NULL
);

-- CREATE TABLE: faq
CREATE TABLE faq (
    faq_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    question VARCHAR2(500) NOT NULL,
    answer VARCHAR2(1000) NOT NULL
);

-- CREATE TABLE: health_condition
CREATE TABLE health_condition (
    condition_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    condition_name VARCHAR2(50) NOT NULL,
    description VARCHAR2(200)
);

-- CREATE TABLE: health_recommend
CREATE TABLE health_recommend (
    recommend_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reason VARCHAR2(300),
    recipe_id NUMBER NOT NULL,
    condition_id NUMBER NOT NULL,
    CONSTRAINT fk_health_recommend_recipe FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    CONSTRAINT fk_health_recommend_condition FOREIGN KEY (condition_id) REFERENCES health_condition(condition_id)
);

-- CREATE TABLE: image
CREATE TABLE image (
    image_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    target_id NUMBER NOT NULL,
    image_url VARCHAR2(300) NOT NULL,
    description VARCHAR2(300)
);

-- CREATE TABLE: likes
CREATE TABLE likes (
    like_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login_id VARCHAR2(50) NOT NULL,
    target_id NUMBER NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_likes_login_id FOREIGN KEY (login_id) REFERENCES users(login_id)
);

-- CREATE TABLE: notice
CREATE TABLE notice (
    notice_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    created_by VARCHAR2(50) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_notice_created_by FOREIGN KEY (created_by) REFERENCES users(login_id)
);

-- CREATE TABLE: pairing
CREATE TABLE pairing (
    pairing_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    recipe_id NUMBER NOT NULL,
    drink_id NUMBER NOT NULL,
    reason VARCHAR2(300),
    CONSTRAINT fk_pairing_recipe FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    CONSTRAINT fk_pairing_drink FOREIGN KEY (drink_id) REFERENCES drink(drink_id)
);

-- CREATE TABLE: post_file
CREATE TABLE post_file (
    file_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    target_id NUMBER NOT NULL,
    original_filename VARCHAR2(255) NOT NULL,
    stored_filename VARCHAR2(255) NOT NULL
);

-- CREATE TABLE: qna
CREATE TABLE qna (
    qna_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(1000) NOT NULL,
    user_id VARCHAR2(50) NOT NULL,
    created_by VARCHAR2(50) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    is_answered CHAR(1) DEFAULT 'N' NOT NULL CHECK (is_answered IN ('Y', 'N')),
    answer VARCHAR2(1000),
    answered_at DATE,
    status VARCHAR2(20) DEFAULT 'PENDING' NOT NULL,
    CONSTRAINT fk_qna_user_id FOREIGN KEY (user_id) REFERENCES users(login_id),
    CONSTRAINT fk_qna_created_by FOREIGN KEY (created_by) REFERENCES users(login_id)
);

-- CREATE TABLE: recipe
CREATE TABLE recipe (
    recipe_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(200) NOT NULL,
    recipe_category VARCHAR2(50) NOT NULL,
    description VARCHAR2(500),
    created_by VARCHAR2(50) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    step_order NUMBER NOT NULL,
    recommend_number NUMBER DEFAULT 0 NOT NULL,
    avg_rating NUMBER(3,1) DEFAULT 0 NOT NULL,
    view_count NUMBER DEFAULT 0 NOT NULL,
    ingredient_name VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_recipe_created_by FOREIGN KEY (created_by) REFERENCES users(login_id)
);

-- CREATE TABLE: recipe_ingredient
CREATE TABLE recipe_ingredient (
    ingredient_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    recipe_id NUMBER NOT NULL,
    ingredient_name VARCHAR2(100) NOT NULL,
    allergy_id NUMBER,
    CONSTRAINT fk_recipe_ingredient_recipe FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    CONSTRAINT fk_recipe_ingredient_allergy FOREIGN KEY (allergy_id) REFERENCES allergy(allergy_id)
);

-- CREATE TABLE: report_post
CREATE TABLE report_post (
    report_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    board_id NUMBER NOT NULL,
    reason VARCHAR2(500) NOT NULL,
    reporter_id VARCHAR2(50) NOT NULL,
    reported_at DATE DEFAULT SYSDATE,
    is_checked CHAR(1) DEFAULT 'N' NOT NULL CHECK (is_checked IN ('Y', 'N')),
    checked_at DATE,
    CONSTRAINT fk_report_post_board FOREIGN KEY (board_id) REFERENCES board(board_id),
    CONSTRAINT fk_report_post_reporter FOREIGN KEY (reporter_id) REFERENCES users(login_id)
);

-- CREATE TABLE: report_user
CREATE TABLE report_user (
    report_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reported_user_id VARCHAR2(50) NOT NULL,
    reason VARCHAR2(500) NOT NULL,
    reporter_id VARCHAR2(50) NOT NULL,
    reported_at DATE DEFAULT SYSDATE,
    is_checked CHAR(1) DEFAULT 'N' NOT NULL CHECK (is_checked IN ('Y', 'N')),
    checked_at DATE,
    CONSTRAINT fk_report_user_reported FOREIGN KEY (reported_user_id) REFERENCES users(login_id),
    CONSTRAINT fk_report_user_reporter FOREIGN KEY (reporter_id) REFERENCES users(login_id)
);

-- CREATE TABLE: search_log
CREATE TABLE search_log (
    log_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login_id VARCHAR2(50) NOT NULL,
    keyword VARCHAR2(200) NOT NULL,
    search_type VARCHAR2(50) NOT NULL,
    searched_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_search_log_login_id FOREIGN KEY (login_id) REFERENCES users(login_id)
);

-- CREATE TABLE: user_allergy
CREATE TABLE user_allergy (
    login_id VARCHAR2(50) NOT NULL,
    allergy_id NUMBER NOT NULL,
    PRIMARY KEY (login_id, allergy_id),
    CONSTRAINT fk_user_allergy_login_id FOREIGN KEY (login_id) REFERENCES users(login_id),
    CONSTRAINT fk_user_allergy_allergy_id FOREIGN KEY (allergy_id) REFERENCES allergy(allergy_id)
);

-- CREATE TABLE: visit_log
CREATE TABLE visit_log (
    log_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login_id VARCHAR2(50) NOT NULL,
    ip_address VARCHAR2(50) NOT NULL,
    page_url VARCHAR2(255) NOT NULL,
    visited_at DATE NOT NULL,
    CONSTRAINT fk_visit_log_login_id FOREIGN KEY (login_id) REFERENCES users(login_id)
);

-- ADD INDEXES
CREATE INDEX idx_recipe_name ON recipe(name);
CREATE INDEX idx_search_log_keyword ON search_log(keyword);
CREATE INDEX idx_board_login_id ON board(login_id);