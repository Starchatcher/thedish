-- 🔻 DROP EXISTING OBJECTS

DROP TABLE allergy CASCADE CONSTRAINTS;
DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE comments CASCADE CONSTRAINTS;
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
drop table rating cascade CONSTRAINTS;


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


INSERT INTO users (
    email, nickname, password, provider, role, status, login_id, username, created_at
) VALUES (
    'admin@example.com',
    '관리자',
    'admin',  -- 실제로는 해시된 비밀번호를 넣으세요
    'local',
    'ADMIN',
    'ACTIVE',
    'ADMIN',
    '관리자',
    SYSDATE
);


INSERT INTO users (
    email, nickname, password, provider, role, status, login_id, username, created_at
) VALUES (
    'user01@example.com',
    '유저01',
    'pass01',  
    'local',
    'USER',
    'ACTIVE',
    'user01',
    '유저일',
    SYSDATE
);

INSERT INTO users (
    email, nickname, password, provider, role, status, login_id, username, created_at
) VALUES (
    'user02@example.com',
    '유저02',
    'pass02',  
    'local',
    'USER',
    'ACTIVE',
    'user02',
    '유저일',
    SYSDATE
);



INSERT INTO users (
    email, nickname, password, provider, role, status, login_id, username, created_at
) VALUES (
    'user03@example.com',
    '유저03',
    'pass03',  
    'local',
    'USER',
    'ACTIVE',
    'user03',
    '유저삼',
    SYSDATE
);








-- CREATE TABLE: allergy
CREATE TABLE allergy (
    allergy_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    description VARCHAR2(200)
);

COMMENT ON COLUMN allergy.allergy_id IS '알레르기 고유 ID';
COMMENT ON COLUMN allergy.description IS '알레르기 설명';
COMMENT ON COLUMN allergy.name IS '알레르기 이름';


INSERT INTO allergy (name, description) VALUES ('땅콩', '땅콩 알레르기 반응을 유발하는 식품');
INSERT INTO allergy (name, description) VALUES ('우유', '우유 및 유제품에 대한 알레르기');
INSERT INTO allergy (name, description) VALUES ('계란', '계란 단백질에 의한 알레르기 반응');
INSERT INTO allergy (name, description) VALUES ('대두', '대두 알레르기 반응을 유발하는 식품');
INSERT INTO allergy (name, description) VALUES ('쌀', '쌀에 대한 알레르기');
INSERT INTO allergy (name, description) VALUES ('밀', '밀 단백질에 의한 알레르기 반응');
INSERT INTO allergy (name, description) VALUES ('게', '게에 대한 알레르기 반응을 유발하는 식품');
INSERT INTO allergy (name, description) VALUES ('새우', '새우 단백질에 의한 알레르기 반응');
INSERT INTO allergy (name, description) VALUES ('겨', '겨에 대한 알레르기');
INSERT INTO allergy (name, description) VALUES ('깨', '깨에 대한 알레르기');
INSERT INTO allergy (name, description) VALUES ('호두', '호두 단백질에 의한 알레르기 반응');
INSERT INTO allergy (name, description) VALUES ('잣', '잣에 대한 알레르기 반응을 유발하는 식품');

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
    original_file_name VARCHAR2(100),
    rename_file_name VARCHAR2(100),
    recommend_number NUMBER DEFAULT 0 NOT NULL,
    CONSTRAINT fk_board_login_id FOREIGN KEY (login_id) REFERENCES users(login_id)
);


comment on column board.board_id is '게시글의 고유 ID';
comment on column board.title is '게시글 제목';
comment on column board.content is '게시글 내용';
comment on column board.login_id is '작성자 ID';
comment on column board.created_at is '작성일';
comment on column board.updated_at is '수정일';
comment on column board.board_category is '게시판 유형';
comment on column board.view_count is '게시판 조회수';
comment on column board.avg_rating is '게시글에 대한 평점';
comment on column board.ORIGINAL_FILE_NAME IS '첨부파일';
comment on column board.RENAME_FILE_NAME IS '수정된첨부파일';
comment on column board.recommend_number is '추천 수';



INSERT INTO board (title, content, login_id, board_category) VALUES
('서울에서 곱창 맛집 추천받아요!', '곱창 좋아하는데 요즘 어디가 괜찮을까요?', 'user01', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('오늘 날씨 진짜 좋네요!', '한강에 피크닉 가고 싶은 날씨에요.', 'user02', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('새로 산 노트북 자랑!', '이번에 큰 맘 먹고 최신 노트북 질렀습니다!', 'user03', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('이번 주말 영화 추천', '이번 주말에 볼 만한 영화 있을까요?', 'user01', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('가성비 좋은 블루투스 이어폰 추천', '음질 괜찮고 가격 착한 이어폰 찾고 있어요!', 'user02', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('다이어트 식단 공유', '제가 요즘 먹고 있는 다이어트 식단 공유합니다!', 'user03', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('여행 계획 같이 짜실 분!', '다음 달에 제주도 가는데 같이 계획 짜실 분 있나요?', 'user01', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('취업 성공 후기', '드디어 꿈에 그리던 회사에 취업했습니다!', 'user02', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('집에서 간단하게 만들 수 있는 요리', '초보도 쉽게 따라 할 수 있는 요리 레시피 공유해요!', 'user03', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('오늘 로또 당첨되신 분 있나요?', '혹시 로또 1등 되신 분 계신가요? 부럽습니다!', 'user01', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('고양이 사진 자랑', '저희 집 고양이 너무 귀엽죠?', 'user02', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('새로운 게임 찾아요!', '요즘 할 만한 스팀 게임 추천 부탁드립니다.', 'user03', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('주식 투자 팁 공유', '주식 초보인데 투자 팁 좀 알려주세요!', 'user01', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('인생 드라마 추천', '살면서 꼭 봐야 할 드라마 있으면 추천해주세요!', 'user02', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('오늘 점심 뭐 먹을까요?', '매일 하는 고민...점심 메뉴 추천해주세요!', 'user03', '자유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('초보도 쉽게 만드는 김치볶음밥 황금레시피!', '백종원 레시피 참고해서 만들었는데 정말 맛있어요!', 'user01', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('라면 맛있게 끓이는 꿀팁 대방출!', '물 조절, 면 넣는 타이밍, 스프 넣는 순서까지!', 'user02', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('에어프라이어로 만드는 초간단 스테이크 레시피', '겉바속촉 스테이크, 이제 집에서도 즐기세요!', 'user03', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('자취생 필수템! 전자레인지 활용 요리 꿀팁', '햇반, 계란찜, 라면까지 전자레인지로 OK!', 'user01', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('캠핑 가서 해먹기 좋은 바베큐 레시피', '목살, 삼겹살, 소세지 완벽 조합!', 'user02', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('다이어트 중에도 포기할 수 없는 닭가슴살 요리 꿀팁', '샐러드, 볶음밥, 스테이크 다양하게 즐겨보세요!', 'user03', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('손님 초대 요리, 밀푀유나베 황금레시피', '비주얼도 맛도 최고! 손님 칭찬 гарантирован!', 'user01', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('집에서 만드는 칵테일 레시피', '간단한 재료로 분위기 있는 칵테일 만들기!', 'user02', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('아이 간식으로 좋은 수제 요거트 만드는 법', '첨가물 없이 건강하게!', 'user03', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('남은 치킨 활용 요리, 치킨마요덮밥 레시피', '간단하고 맛있게!', 'user01', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('고구마 맛있게 굽는 꿀팁', '에어프라이어, 오븐, 전자레인지 활용법!', 'user02', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('커피 맛있게 내리는 꿀팁', '핸드드립, 에스프레소, 더치커피!', 'user03', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('파스타 면 삶는 꿀팁', '알덴테 식감 제대로 살리기!', 'user01', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('계란찜 폭탄처럼 만드는 꿀팁', '전자레인지로 간단하게!', 'user02', '팁공유');

INSERT INTO board (title, content, login_id, board_category) VALUES
('식빵 맛있게 먹는 꿀팁', '토스트, 샌드위치, 러스크!', 'user03', '팁공유');


INSERT INTO board (title, content, login_id, board_category) VALUES
('강남역 맛집 "육통령" 솔직 후기', '육즙 가득한 삼겹살과 푸짐한 밑반찬 최고!', 'user01', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('홍대 "미미네" 떡볶이 후기', '국물 떡볶이와 김말이 환상 조합!', 'user02', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('부산 해운대 "개미집" 낙곱새 후기', '매콤한 낙곱새, 볶음밥 필수!', 'user03', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('제주도 "흑돼지 돈까스" 맛집 후기', '겉바속촉 흑돼지 돈까스, 인생 돈까스 등극!', 'user01', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('속초 "대포항 튀김골목" 후기', '새우튀김, 오징어튀김, 게튀김 종류별로 다 먹어봤어요!', 'user02', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('전주 "왱이콩나물국밥" 후기', '시원한 콩나물국밥, 아침 식사로 딱!', 'user03', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('여수 "낭만포차" 후기', '밤바다 보면서 해산물 먹으니 낭만적!', 'user01', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('경주 "황리단길" 맛집 투어 후기', '다양한 음식과 예쁜 카페 가득!', 'user02', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('가평 "닭갈비" 맛집 후기', '숯불 닭갈비, 막국수 환상 조합!', 'user03', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('을지로 "노가리 골목" 후기', '저렴한 가격에 맥주 한 잔!', 'user01', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('대구 "막창 골목" 후기', '고소한 막창, 술안주로 최고!', 'user02', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('광주 "육전" 맛집 후기', '따뜻하고 부드러운 육전, 막걸리와 함께!', 'user03', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('수원 "통닭 골목" 후기', '바삭하고 촉촉한 옛날 통닭!', 'user01', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('인천 "차이나타운" 맛집 투어 후기', '다양한 중국 음식 맛보기!', 'user02', '후기');

INSERT INTO board (title, content, login_id, board_category) VALUES
('강릉 "중앙시장" 먹거리 후기', '닭강정, 호떡, 아이스크림 호떡!', 'user03', '후기');



-- CREATE TABLE: comments
CREATE TABLE comments (
    comment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login_id VARCHAR2(50) NOT NULL,
    target_id NUMBER NOT NULL,
    content VARCHAR2(4000) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE,
    parent_id NUMBER,
    CONSTRAINT fk_comment_login_id FOREIGN KEY (login_id) REFERENCES users(login_id)
);

comment on column comments.comment_id is '댓글 고유 ID';
comment on column comments.login_id is '작성자 ID';
comment on column comments.target_id is '대상 ID';
comment on column comments.content is '댓글 내용';
comment on column comments.created_at is '작성일';
comment on column comments.updated_at is '수정일';
comment on column comments.parent_id is '부모 댓글 ID';


INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 1, '곱창은 역시 왕십리 곱창골목이 최고죠!');
INSERT INTO comments (login_id, target_id, content, parent_id) VALUES ('user03', 1, '왕십리 멀어서 아쉬워요 ㅠㅠ 다른 곳도 추천해주세요!',1);
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 2, '날씨 진짜 좋네요! 저도 오늘 한강 가야겠어요!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 3, '노트북 부럽습니다! 저도 곧 바꿔야 하는데 뭘 살지 고민이네요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 4, '이번 주말에 인사이드 아웃2 개봉한다던데 그거 어떠세요?');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 5, '저도 가성비 이어폰 찾고 있는데, 정보 공유 부탁드려요!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 6, '다이어트 식단 공유 감사합니다! 저도 따라해볼게요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 7, '제주도 여행 부럽네요! 즐거운 여행 되세요!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 8, '취업 축하드려요! 앞으로 좋은 일만 가득하길 바랍니다.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 9, '간단한 요리 레시피 기대됩니다! 빨리 공유해주세요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 10, '로또 1등 당첨되면 저도 맛있는 거 사주세요!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 11, '고양이 너무 귀엽네요! 종이 뭐에요?');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 12, '스팀 게임은 역시 갓겜 위쳐3죠!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 13, '주식 투자 팁 저도 궁금합니다! 고수님 알려주세요!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 14, '인생 드라마 추천 감사합니다! 주말에 정주행해야겠어요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 15, '점심 메뉴 고민은 정말 매일 해도 힘드네요 ㅠㅠ');

INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 16, '김치볶음밥은 역시 백종원 레시피가 최고죠!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 17, '라면 꿀팁 감사합니다! 내일 아침에 바로 해먹어봐야겠어요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 18, '에어프라이어 스테이크 정말 간단하고 맛있죠!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 19, '자취생 필수템 정보 감사합니다! 전자레인지 활용 꿀팁 최고!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 20, '캠핑 바베큐 기대됩니다! 사진도 올려주세요!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 21, '닭가슴살 요리 꿀팁 감사합니다! 다이어트 힘내볼게요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 22, '밀푀유나베 비주얼 최고네요! 손님 초대 요리로 딱이겠어요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 23, '집에서 칵테일 만들기 도전해봐야겠어요!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 24, '수제 요거트 레시피 감사합니다! 아이 간식으로 만들어줘야겠어요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 25, '남은 치킨 활용 요리 꿀팁 감사합니다! 내일 해먹어야겠어요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 26, '고구마 맛있게 굽는 꿀팁 감사합니다! 에어프라이어 활용해봐야겠어요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 27, '커피 꿀팁 감사합니다! 맛있는 커피 내려마셔야겠어요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 28, '파스타 면 삶는 꿀팁 감사합니다! 알덴테 도전!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 29, '계란찜 폭탄처럼 만드는 꿀팁 감사합니다! 전자레인지로 도전!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 30, '식빵 꿀팁 감사합니다! 토스트 해먹어야겠어요.');

INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 31, '육통령 저도 가봤는데 진짜 맛있어요! 강추!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 32, '미미네 떡볶이 저도 좋아해요! 김말이 필수!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 33, '개미집 낙곱새 먹고 볶음밥 안 먹으면 후회하죠!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 34, '흑돼지 돈까스 진짜 맛있어보이네요! 제주도 가면 꼭 가봐야겠어요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 35, '대포항 튀김골목 저도 가봤는데 튀김 종류 진짜 많더라구요!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 36, '왱이콩나물국밥 시원하니 아침에 먹기 딱 좋죠!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 37, '여수 낭만포차 분위기 진짜 좋죠! 저도 가고 싶네요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 38, '황리단길 맛집 투어 부럽네요! 저도 가보고 싶어요.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 39, '가평 닭갈비는 역시 숯불 닭갈비가 최고죠!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 40, '을지로 노가리 골목에서 맥주 한 잔 캬!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user03', 41, '대구 막창 골목은 사랑입니다!');
INSERT INTO comments (login_id, target_id, content) VALUES ('user01', 42, '광주 육전 진짜 부드럽고 맛있죠! 막걸리랑 찰떡궁합.');
INSERT INTO comments (login_id, target_id, content) VALUES ('user02', 43, '수원 통닭 골목은 진리죠! 바삭바삭!');





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

COMMENT ON COLUMN drink.drink_id IS '술 고유 ID';
COMMENT ON COLUMN drink.name IS '술 이름';
COMMENT ON COLUMN drink.alcohol_content IS '도수(%)';
COMMENT ON COLUMN drink.price IS '가격(원)';
COMMENT ON COLUMN drink.pairing_food IS '어울리는 음식';
COMMENT ON COLUMN drink.description IS '술에 대한 상세 설명';
COMMENT ON COLUMN drink.recommend_number IS '술에 대한 추천 수';
COMMENT ON COLUMN drink.avg_rating IS '술에 대한 평점';
COMMENT ON COLUMN drink.view_count IS '조회수';




INSERT INTO drink (name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
( 'GCF, 꼬뜨 드 뵈프', '13', 36000, '스테이크, 치즈', '세계적인 와인 그룹 GCF 의 컨셉트 와인으로 스테이크류에 최적화된 맛을 지니고 있다. 시라와 마르슬랑을 각각 프렌치 오크 배럴에 숙성하여 병입 후 출시한다. 과일맛이 잘 느껴지는 푸루티 스타일, 리치하고 맛있는 미감을 지녔다.', 12, 4.6, 120);

INSERT INTO drink ( name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
( '그랜트 버지, 미암바 쉬라즈', '14', 39000, '양갈비', '깊고 진한 보랏빛이 감도는 루비색을 띠며, 피자두, 라즈베리, 블랙베리, 감초, 오크에서 묻어난 스파이스와 바닐라 향이 완벽한 조화를 이룹니다.', 17, 4.8, 140);

INSERT INTO drink ( name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
( '아이들와일드, 플로라 파우나 레드', '13', 60000, '양념치킨, 파스타', '진한 루비색을 띠며, 다크체리, 말린 허브, 바이올렛 의 아로마가 느껴진다. 입 안에서는 좋은 산도와 타닌, 알코올에 조화롭게 어우러지는 와인이다.', 21, 4.2, 290);


INSERT INTO drink (name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
('맥켈란 12년', 40.0, 120000, '다크 초콜렛, 치즈', '우아하고 복잡한 풍미를 지닌 스코틀랜드의 프리미엄 싱글 몰트입니다.', 10, 4.9, 200);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
('발베니 더블우드 12년', 43.0, 80000, '훈제 연어, 샐러드', '오크통에서 숙성하여 부드러운 바닐라와 과일 맛이 특징입니다.', 8, 4.7, 150);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
('아드벡 10년', 46.0, 90000, 'BBQ, 매운 음식', '강렬한 피트 향이 특징인 스코틀랜드 아이슬레이 지역의 위스키입니다.', 12, 4.8, 180);


INSERT INTO drink (name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
('하이네켄', 5.0, 5000, '치킨, 피자', '세계적으로 유명한 라거 맥주로, 시원하고 청량감이 있습니다.', 20, 4.3, 300);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
('버드와이저', 5.0, 6000, '핫윙, 나초', '미국의 대표적인 라거 맥주로, 가벼운 맛이 특징입니다.', 15, 4.2, 250);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
('코로나', 4.5, 7000, '타코, 해산물', '멕시코 맥주로 라임과 함께 즐기면 더욱 맛있습니다.', 18, 4.5, 280);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
('기네스', 4.2, 8000, '스테이크, 양파링', '부드럽고 크리미한 질감이 특징인 아이리쉬 스타우트입니다.', 25, 4.6, 200);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, recommend_number, avg_rating, view_count) VALUES
('블루문', 5.4, 7500, '샐러드, 해산물', '신선한 오렌지 맛과 향이 특징인 벨지안 스타일의 밀맥주입니다.', 22, 4.4, 230);



-- CREATE TABLE: faq
CREATE TABLE faq (
    faq_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    question VARCHAR2(1000) NOT NULL,
    answer VARCHAR2(4000) NOT NULL
);

COMMENT ON COLUMN FAQ.FAQ_ID IS 'FAQ번호';
COMMENT ON COLUMN FAQ.QUESTION IS 'FAQ질문내용';
COMMENT ON COLUMN FAQ.ANSWER IS 'FAQ답변내용';


INSERT INTO faq ( question, answer) VALUES 
( '레시피는 무료로 볼 수 있나요?', '네, THE DISH에 등록된 대부분의 레시피는 회원가입 없이도 무료로 열람하실 수 있습니다.');

INSERT INTO faq (question, answer) VALUES 
( '회원가입은 어떻게 하나요?', '홈페이지 우측 상단의 회원가입 버튼을 클릭 후, 이메일 또는 SNS 계정으로 간편하게 가입하실 수 있습니다.');

INSERT INTO faq (question, answer) VALUES 
( '비밀번호을 잊어버렸어요.', '로그인 화면에서 비밀번호 찾기를 클릭 후, 이메일 인증을 통해 비밀번호를 재설정하실 수 있습니다.');

INSERT INTO faq ( question, answer) VALUES 
( '건강맞춤형 레시피 추천은 어떤 기준으로 제공되나요?', '추천 메뉴로 들어가서 자신이 가지고 있는 질병이나 예방하고 싶으신 질병을 입력하시면 그에 맞는 재료를 추천해주고 싫어하시는 재료를 선택하시면 그 재료들을 뺀 나머지 재료들로 음식을 추천해드리고 있습니다!');

INSERT INTO faq ( question, answer) VALUES 
( '추천된 술은 구매할 수 있나요?', '현재는 정보 제공만 가능하며, 구매 기능은 연계된 주류몰 링크를 통해 이용하실 수 있습니다.');


-- CREATE TABLE: health_condition
CREATE TABLE health_condition (
    condition_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    condition_name VARCHAR2(500) NOT NULL,
    description VARCHAR2(4000)
);

COMMENT ON COLUMN health_condition.condition_id IS '건강 상태 고유 ID (자동 생성)';
COMMENT ON COLUMN health_condition.condition_name IS '건강 상태명 (예: 당뇨, 고혈압 등)';
COMMENT ON COLUMN health_condition.description IS '건강 상태에 대한 상세 설명';

INSERT INTO health_condition (condition_name, description) VALUES 
('당뇨', '당분 섭취에 주의가 필요한 상태');
INSERT INTO health_condition (condition_name, description) VALUES 
('고혈압', '나트륨 섭취를 줄여야 하는 고혈압 환자에게 적합');
INSERT INTO health_condition (condition_name, description) VALUES 
('통풍', '체내 요산 수치 조절이 필요한 상태');
INSERT INTO health_condition (condition_name, description) VALUES 
('고지혈증', '지방 섭취 제한이 필요한 상태');
INSERT INTO health_condition (condition_name, description) VALUES 
('글루텐 민감증', '글루텐에 민감하거나 알레르기가 있는 경우');
INSERT INTO health_condition (condition_name, description) VALUES 
('비건', NULL);
INSERT INTO health_condition (condition_name, description) VALUES 
('신장 질환', '동물성 단백질 제한이 필요한 식단');
INSERT INTO health_condition (condition_name, description) VALUES 
('암 치료 중', '면역력 강화를 위한 식단 관리 대상');
INSERT INTO health_condition (condition_name, description) VALUES 
('식품 알레르기', '알러지 유발 식품 피해야 함');
INSERT INTO health_condition (condition_name, description) VALUES 
('위장 질환', '위산 과다 및 위장 장애에 민감한 상태');




-- CREATE TABLE: likes
CREATE TABLE likes (
    like_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login_id VARCHAR2(50) NOT NULL,
    target_id NUMBER NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_likes_login_id FOREIGN KEY (login_id) REFERENCES users(login_id)
);

comment on column likes.like_id is '좋아요 고유 ID';
comment on column likes.login_id is '좋아요 누른 사용자 ID';
comment on column likes.target_id is '대상 게시물의 ID';
comment on column likes.created_at is '좋아요 누른 시간';


INSERT INTO likes (login_id, target_id) VALUES ('user01', 1);
INSERT INTO likes (login_id, target_id) VALUES ('user02', 1);
INSERT INTO likes (login_id, target_id) VALUES ('user03', 2);
INSERT INTO likes (login_id, target_id) VALUES ('user01', 3);
INSERT INTO likes (login_id, target_id) VALUES ('user02', 4);
INSERT INTO likes (login_id, target_id) VALUES ('user03', 5);
INSERT INTO likes (login_id, target_id) VALUES ('user01', 6);
INSERT INTO likes (login_id, target_id) VALUES ('user02', 7);
INSERT INTO likes (login_id, target_id) VALUES ('user03', 8);
INSERT INTO likes (login_id, target_id) VALUES ('user01', 9);
INSERT INTO likes (login_id, target_id) VALUES ('user02', 10);
INSERT INTO likes (login_id, target_id) VALUES ('user03', 11);
INSERT INTO likes (login_id, target_id) VALUES ('user01', 12);
INSERT INTO likes (login_id, target_id) VALUES ('user02', 13);
INSERT INTO likes (login_id, target_id) VALUES ('user03', 14);
INSERT INTO likes (login_id, target_id) VALUES ('user01', 31);
INSERT INTO likes (login_id, target_id) VALUES ('user02', 32);
INSERT INTO likes (login_id, target_id) VALUES ('user03', 33);



-- CREATE TABLE: notice
CREATE TABLE notice (
    notice_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    created_by VARCHAR2(50) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
 original_file_name VARCHAR2(100),
   rename_file_name VARCHAR2(100),
   readcount number default 1 NOT NULL,
    CONSTRAINT fk_notice_created_by FOREIGN KEY (created_by) REFERENCES users(login_id)
);

COMMENT ON COLUMN NOTICE.NOTICE_ID IS '공지글번호';
COMMENT ON COLUMN NOTICE.CREATED_BY IS '공지글작성자';
COMMENT ON COLUMN NOTICE.CREATED_AT IS '공지등록일시';
COMMENT ON COLUMN NOTICE.TITLE IS '공지제목';
COMMENT ON COLUMN NOTICE.CONTENT IS '공지내용';
COMMENT ON COLUMN NOTICE.ORIGINAL_FILE_NAME IS '첨부파일';
COMMENT ON COLUMN NOTICE.RENAME_FILE_NAME IS '수정된첨부파일';
COMMENT ON COLUMN NOTICE.READCOUNT IS '공지사항조회수';


INSERT INTO NOTICE  (created_by, created_at, title, content, readcount) VALUES ( 'ADMIN', '24/12/30', '올해가 얼마 남지 않았습니다 여러분!', '안녕하세요, 맛있는 순간을 함께하는 여러분!
어느덧 2025년도 마지막 분기에 접어들었습니다.
한 해 동안 저희 사이트를 찾아주시고, 사랑해주신 모든 분들께 진심으로 감사드립니다.
다가오는 연말, 소중한 사람들과 따뜻한 음식을 나누며
행복한 시간 보내시길 바라며, 저희도 더욱 맛있고 유익한 콘텐츠로 보답하겠습니다.
 올해 마지막까지도 여러분의 식탁에 즐거움을 더할 수 있도록 최선을 다하겠습니다.
감사합니다!
여러분의 입맛을 책임지는 [THE DISH 전 관리자들 드림]', default);
INSERT INTO NOTICE  (created_by, created_at, title, content, readcount) VALUES ( 'ADMIN', '25/01/01', '새해 복 많이 받으세요! THE DISH에서 인사드립니다.', '안녕하세요, THE DISH를 사랑해주시는 여러분!
희망 가득한 2025년 새해가 밝았습니다.
지난 한 해 동안 보내주신 관심과 사랑에 깊이 감사드리며,
새해에도 여러분의 일상에 더 맛있고 행복한 순간들이 가득하시길 진심으로 기원합니다.
2025년에도 THE DISH는
더 다양하고 특별한 음식 콘텐츠, 알찬 레시피,
그리고 감동을 담은 맛있는 이야기로 찾아뵙겠습니다.
올해도 여러분의 식탁에 웃음과 풍요가 함께하길 바라며,
든든한 마음으로 항상 곁에 있는 THE DISH가 되겠습니다.
새해 복 많이 받으세요! 
– THE DISH 드림', default);
INSERT INTO NOTICE  (created_by, created_at, title, content, readcount) VALUES ( 'ADMIN', '25/01/12', '이번에 저희 THE DISH가 추가한 레시피를 소개합니다!', '안녕하세요, 미식의 즐거움을 전하는 THE DISH입니다!
더 풍성한 식탁을 위해 이번에 새롭게 맛과 정성을 담은 레시피들을 추가했습니다.
하루 한 끼가 특별해지는 순간, 지금 바로 만나보세요!
 이번에 추가된 레시피 중 일부를 소개합니다:
 집에서도 근사하게! ‘트러플 크림 파스타’
 상큼한 건강함, ‘훈제연어 아보카도 샐러드’
 속은 촉촉, 겉은 바삭! ‘에어프라이어 간장치킨’
 부드럽고 달콤한 ‘클래식 티라미수’
지금 바로 THE DISH에서 새로운 레시피를 확인해보세요!
여러분의 오늘이 더 맛있어지는 그 순간까지, 저희가 함께하겠습니다 
 [THE DISH 레시피 바로 가기]', default);
INSERT INTO NOTICE  (created_by, created_at, title, content, readcount) VALUES ( 'ADMIN', '25/01/23', '2025/01 신고 당한 회원자들입니다.', '안녕하세요, THE DISH 운영팀입니다.
THE DISH는 모든 회원 여러분이 즐겁고 건강한 커뮤니티 환경을 누릴 수 있도록
커뮤니티 이용 수칙을 바탕으로 운영되고 있습니다.
이에 따라, 2025년 1월 한 달간
내부 검토 및 회원 신고 접수를 통해 아래의 회원에 대해 조치를 취하였음을 알려드립니다.
 신고 처리 대상 회원 (닉네임 기준)
1. 맛잘알123 – 부적절한 댓글 작성 (경고)
2. foodie90 – 허위 정보 게시 (일시 정지)
3. spicyqueen – 타인 비방 및 욕설 (영구 정지)
앞으로도 THE DISH는 커뮤니티 질서를 해치는 행위에 대해
엄정하게 대응할 예정이며,
모든 회원 여러분께서도 건전하고 따뜻한 소통 문화를 함께 만들어주시길 부탁드립니다.
감사합니다.
– THE DISH 운영팀 드림', default);
INSERT INTO NOTICE  (created_by, created_at, title, content, readcount) VALUES ( 'ADMIN', '25/02/10', '2025/02 이번달 추천 맛집 리스트입니다!.', '안녕하세요, THE DISH입니다!
찬 바람 속에서도 식욕은 살아있다!
이번 2월, THE DISH가 자신 있게 추천하는 이달의 맛집 리스트를 소개합니다.
분위기, 맛, 서비스 모두 잡은 숨은 맛집부터 핫플레이스까지 한눈에 확인해보세요!
 2월의 추천 맛집 TOP 5
1.[온도: 따뜻한 국밥집] – 정통 소고기국밥의 깊은 맛, 서울 종로
2.[라쁠라쎄] – 감성 가득 프렌치 디너, 부산 해운대
3.[오모리김치찌개 본점] – 매콤한 중독성, 경기 성남
4.[파스타클럽] – 데이트에 찰떡, 감성 가득 이탈리안, 대전 중구
5.[낭만포차] – 친구들과 한잔하기 좋은 분위기, 광주 상무지구
매달 업데이트되는 맛집 리스트로
여러분의 하루가 더 맛있고 즐거워지길 바라며,
THE DISH는 언제나 여러분의 입맛과 감성을 책임지겠습니다!
지금 바로 맛집 리스트 확인하고, 미식 여행 떠나보세요!
 [추천 맛집 전체 보기]
감사합니다.
– THE DISH 드림', default);
INSERT INTO NOTICE (created_by, created_at, title, content, readcount)  VALUES ( 'ADMIN', '25/02/20', '2025/02 밸런타인데이 스페셜 디저트 소개', '안녕하세요, THE DISH입니다!
사랑이 넘치는 2월, 밸런타인데이를 맞아 특별한 디저트를 준비했어요.
딸기 가나슈 타르트
하트 모양 수제 마카롱
벨기에 다크초콜릿 케이크
소중한 사람에게 달콤함을 전해보세요!
[밸런타인 스페셜 디저트 보기]
– THE DISH 드림', default);
INSERT INTO NOTICE  (created_by, created_at, title, content, readcount) VALUES ( 'ADMIN', '25/03/05', '2025/03 핫한 맛집 추천 리스트입니다!.', '안녕하세요, THE DISH입니다!
봄기운이 완연한 3월, 여러분의 입맛도 새롭게 깨어나는 계절입니다.
이번 달에는 THE DISH가 엄선한 지금 가장 핫한 맛집들을 소개해드립니다!
지금 가장 뜨고 있는 곳, 꼭 한 번 가봐야 할 맛집들을 한자리에 모았어요.
 2025년 3월 핫플 맛집 TOP 5
1. [비프스탁] – 미디엄레어의 정석, 수제 스테이크 전문점 (서울 연남동)
2. [초코홀릭카페] – 디저트 덕후들의 성지, 수제 초콜릿 "&" 핫초코 (부산 해운대)
3. [월화쌈밥] – 한 상 가득 봄 제철 나물 쌈밥 (광주 남구)
4. [라멘하치도] – 정통 일본 라멘의 깊은 맛 (대전 둔산동)
5. [크루아상연구소] – 매일 아침 갓 구운 수제 크루아상 (대구 동성로)
친구와의 약속, 데이트, 혼밥까지 다 가능한 이번 달 핫플레이스!
지금 바로 THE DISH에서 확인해보시고, 여러분만의 맛집 리스트에 추가해보세요 
[3월 추천 맛집 전체 보기]
여러분의 맛있는 하루를 위해 늘 함께하는
– THE DISH 드림', default);
INSERT INTO NOTICE  (created_by, created_at, title, content, readcount) VALUES ( 'ADMIN', '25/03/15', 'THE DISH 서비스 점검 안내 (3/17 새벽)', '안녕하세요, THE DISH입니다.
더 나은 서비스를 제공하기 위해 아래 일정으로 시스템 점검이 진행됩니다.

📌 점검 일시: 2025년 3월 17일(월) 00:00 ~ 04:00
📌 점검 내용: 서버 안정화 및 속도 개선

점검 시간 동안 일시적으로 서비스 이용이 제한될 수 있습니다.
이용에 불편을 드려 죄송하며, 양해 부탁드립니다.
– THE DISH 드림', default);
INSERT INTO NOTICE  (created_by, created_at, title, content, readcount) VALUES ( 'ADMIN', '25/04/01', '만우절 이벤트! 사실 그런 건 없습니다~!', '안녕하세요, THE DISH입니다!
설레는 마음으로 클릭하셨다면… 정말 죄송합니다.
오늘은 바로 만우절!
그래서 살~짝 장난을 쳐봤어요 😅
하지만 그냥 보내긴 아쉬우니,
댓글에 "나만의 만우절 음식 장난"을 공유해주시면
추첨을 통해 깜짝 선물을 드릴지도…?
 예: 초코소스 짜장면인 척하기, 케이크인 줄 알았는데 김치전이야?!
언제나 여러분과 소통하며 더 즐거운 식탁 문화를 만들어가는
THE DISH가 되겠습니다.
모두 웃음 가득한 하루 보내세요!
– THE DISH 드림', default);


INSERT INTO notice (created_by, created_at, title, content) VALUES (
    'ADMIN',
    TO_DATE('2025-04-05', 'YYYY-MM-DD'),
    'THE DISH 회원 등급제도 안내',
    '안녕하세요, THE DISH입니다!
더 많은 혜택을 드리기 위해 회원 등급 제도를 새롭게 도입하였습니다.

등급별 혜택 안내
브론즈: 리뷰 작성 시 포인트 적립
실버: 매월 할인 쿠폰 제공
골드: 생일 축하 쿠폰 + 특별 이벤트 초대

회원 등급은 매달 자동으로 갱신되며, 마이페이지에서 확인 가능합니다.
[회원 등급제도 자세히 보기]
– THE DISH 드림'
);


INSERT INTO notice (created_by, created_at, title, content) VALUES (
    'ADMIN',
    TO_DATE('2025-04-10', 'YYYY-MM-DD'),
    '2025/04 봄나들이 도시락 추천 메뉴!',
    '안녕하세요, THE DISH입니다!
포근한 봄날, 소풍이나 나들이를 계획 중이신가요?
이번 4월에는 간편하지만 감성 가득한 도시락 메뉴를 추천해드립니다.
에그샐러드 샌드위치 
유부초밥  과일 피크닉 세트
닭가슴살 샐러드 도시락
더 맛있고 건강한 나들이를 위한 THE DISH의 제안!
[4월 도시락 추천 메뉴 보기]
– THE DISH 드림'
);




-- 수정된 post_file 테이블 생성문
CREATE TABLE post_file (
    file_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    target_id NUMBER NOT NULL,
    target_type VARCHAR2(50) NOT NULL,  -- 게시글 유형 구분용 컬럼 추가
    original_filename VARCHAR2(255) NOT NULL,
    stored_filename VARCHAR2(255) NOT NULL
);

-- 컬럼 코멘트 추가
COMMENT ON COLUMN post_file.file_id IS '첨부파일 고유 ID';
COMMENT ON COLUMN post_file.target_id IS '첨부된 대상 게시글 ID';
COMMENT ON COLUMN post_file.target_type IS '첨부된 대상 게시글 유형 (예: board, recipe_post 등)';
COMMENT ON COLUMN post_file.original_filename IS '파일 원본 이름';
COMMENT ON COLUMN post_file.stored_filename IS '실제 저장 이름';


INSERT INTO post_file (target_id, target_type, original_filename, stored_filename)
VALUES (2, 'board', '닭한마리_사진.jpg', '20250410_123456.jpg');

INSERT INTO post_file (target_id, target_type, original_filename, stored_filename)
VALUES (2, 'board', '막걸리안주_팁.txt', '20250410_223344.txt');





-- CREATE TABLE: qna
CREATE TABLE qna (
    qna_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(4000) NOT NULL,
    user_id VARCHAR2(50) NOT NULL,
    created_by VARCHAR2(50),
    created_at DATE DEFAULT SYSDATE,
    is_answered CHAR(1) DEFAULT 'N' NOT NULL CHECK (is_answered IN ('Y', 'N')),
    answer VARCHAR2(1000),
    answered_at DATE,
    status VARCHAR2(20) DEFAULT 'PENDING' NOT NULL,
    CONSTRAINT fk_qna_user_id FOREIGN KEY (user_id) REFERENCES users(login_id),
    CONSTRAINT fk_qna_created_by FOREIGN KEY (created_by) REFERENCES users(login_id)
);

COMMENT ON COLUMN QNA.QNA_ID IS '1대1문의번호';
COMMENT ON COLUMN QNA.TITLE IS '문의제목';
COMMENT ON COLUMN QNA.CONTENT IS '문의내용';
COMMENT ON COLUMN QNA.CREATED_AT IS '문의작성시간';
COMMENT ON COLUMN QNA.USER_ID IS '문의작성자ID';
COMMENT ON COLUMN QNA.ANSWER IS '관리자답변내용';
COMMENT ON COLUMN QNA.ANSWERED_AT IS '답변등록시간';
COMMENT ON COLUMN QNA.IS_ANSWERED IS '답변여부(Y/N)';
COMMENT ON COLUMN QNA.CREATED_BY IS '답변등록한관리자ID';
COMMENT ON COLUMN QNA.STATUS IS '요청처리상태';



INSERT INTO qna (
  title, content, user_id, created_by, created_at, 
  is_answered, answer, answered_at, status
) VALUES (
  '레시피가 안 보여요', 
  '홈페이지 오류때문에 레시피 정보가 안보여요.. 어떻게 하죠?', 
  'user01', 
  NULL, 
  TO_DATE('2025-04-01 03:30:00', 'YYYY-MM-DD HH24:MI:SS'), 
  'N', 
  NULL, 
  NULL, 
  'PENDING'
);

INSERT INTO qna (
  title, content, user_id, created_by, created_at, 
  is_answered, answer, answered_at, status
) VALUES (
  '건강추천 입력 방법이 궁금해요',
  '건강맞춤형 추천 기능은 어떻게 쓰나요?',
  'user02',
  'ADMIN',
  TO_DATE('2025-04-01 10:15:00', 'YYYY-MM-DD HH24:MI:SS'),
  'Y',
  '메인 페이지 상단에 검색추천을 누르시면 상세히 나와있습니다!',
  TO_DATE('2025-04-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'),
  'RESOLVED'
);



-- CREATE TABLE: recipe
CREATE TABLE recipe (
    recipe_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(200) NOT NULL,
    recipe_category VARCHAR2(50) NOT NULL,
    description VARCHAR2(500),
    created_by VARCHAR2(50) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    instructions VARCHAR2(4000) NOT NULL,
    recommend_number NUMBER DEFAULT 0 NOT NULL,
    avg_rating NUMBER(3,1) DEFAULT 0 NOT NULL,
    view_count NUMBER DEFAULT 0 NOT NULL,
    ingredient_name VARCHAR2(2000) NOT NULL,
    CONSTRAINT fk_recipe_created_by FOREIGN KEY (created_by) REFERENCES users(login_id)
);

COMMENT ON COLUMN recipe.recipe_id IS '레시피 고유 ID';
COMMENT ON COLUMN recipe.name IS '레시피 이름';
COMMENT ON COLUMN recipe.recipe_category IS '레시피 카테고리';
COMMENT ON COLUMN recipe.description IS '레시피 설명';
COMMENT ON COLUMN recipe.created_by IS '작성자 ID (users.login_id 참조)';
COMMENT ON COLUMN recipe.created_at IS '작성 일자';
COMMENT ON COLUMN recipe.instructions IS '상세 설명';
COMMENT ON COLUMN recipe.recommend_number IS '레시피에 대한 추천 수';
COMMENT ON COLUMN recipe.avg_rating IS '레시피에 대한 평점';
COMMENT ON COLUMN recipe.view_count IS '조회수';
COMMENT ON COLUMN recipe.ingredient_name IS '재료명';


INSERT INTO recipe (
    name,
    recipe_category,
    description,
    created_by,
    created_at,
    instructions,
    recommend_number,
    avg_rating,
    view_count,
    ingredient_name
) VALUES (
    '새우 두부 계란찜',
    '반찬',
    '부드러운 연두부와 새우가 들어간 찜 요리로, 건강하고 간편하게 즐길 수 있습니다.',
    'ADMIN',  -- 작성자 ID, 필요에 따라 변경 가능
    SYSDATE,
    '1. 손질된 새우를 끓는 물에 데쳐 건진다. 2. 연두부, 달걀, 생크림, 설탕에 녹인 무염버터를 믹서에 넣고 간 뒤 새우(1)를 함께 섞어 그릇에 담는다. 3. 시금치를 잘게 다져 혼합물 그릇에 뿌리고 찜기에 넣고 중간 불에서 10분 정도 찐다.',
    0,  -- 추천 수 (초기값)
    0,  -- 평균 평점 (초기값)
    0,  -- 조회 수 (초기값)
    '연두부 75g(3/4모), 칵테일새우 20g(5마리), 달걀 30g(1/2개), 생크림 13g(1큰술), 설탕 5g(1작은술), 무염버터 5g(1작은술), 시금치 10g(3줄기)'
);

INSERT INTO recipe (
    name,
    recipe_category,
    description,
    created_by,
    created_at,
    instructions,
    recommend_number,
    avg_rating,
    view_count,
    ingredient_name
) VALUES (
    '새우 두부 계란찜',
    '반찬',
    '부드러운 연두부와 새우가 들어간 찜 요리로, 건강하고 간편하게 즐길 수 있습니다.',
    'ADMIN',  -- 작성자 ID, 필요에 따라 변경 가능
    SYSDATE,
    '1. 손질된 새우를 끓는 물에 데쳐 건진다. 2. 연두부, 달걀, 생크림, 설탕에 녹인 무염버터를 믹서에 넣고 간 뒤 새우(1)를 함께 섞어 그릇에 담는다. 3. 시금치를 잘게 다져 혼합물 그릇에 뿌리고 찜기에 넣고 중간 불에서 10분 정도 찐다.',
    0,  -- 추천 수 (초기값)
    0,  -- 평균 평점 (초기값)
    0,  -- 조회 수 (초기값)
    '연두부 75g(3/4모), 칵테일새우 20g(5마리), 달걀 30g(1/2개), 생크림 13g(1큰술), 설탕 5g(1작은술), 무염버터 5g(1작은술), 시금치 10g(3줄기)'
);

INSERT INTO recipe (
    name,
    recipe_category,
    description,
    created_by,
    created_at,
    instructions,
    recommend_number,
    avg_rating,
    view_count,
    ingredient_name
) VALUES (
    '방울토마토 소박이',
    '반찬',
    '상큼한 방울토마토에 양념을 넣어 만든 간편한 반찬입니다.',
    'ADMIN',  -- 작성자 ID를 필요에 따라 변경해 주세요.
    SYSDATE,
    '1. 물기를 빼고 2cm 정도의 크기로 썰은 부추와 양파를 양념장에 섞어 양념속을 만든다. 2. 깨끗이 씻은 방울토마토는 꼭지를 떼고 윗부분에 칼로 십자모양으로 칼집을 낸다. 3. 칼집을 낸 방울토마토에 양념속을 사이사이에 넣어 버무린다.',
    0,  -- 추천 수 (초기값)
    0,  -- 평균 평점 (초기값)
    0,  -- 조회 수 (초기값)
    '방울토마토 150g(5개), 양파 10g(3×1cm), 부추 10g(5줄기), 고춧가루 4g(1작은술), 멸치액젓 3g(2/3작은술), 다진 마늘 2.5g(1/2쪽), 매실액 2g(1/3작은술), 설탕 2g(1/3작은술), 물 2ml(1/3작은술), 통깨 약간'
);

INSERT INTO recipe (
    name,
    recipe_category,
    description,
    created_by,
    created_at,
    instructions,
    recommend_number,
    avg_rating,
    view_count,
    ingredient_name
) VALUES (
    '순두부 사과 소스 오이무침',
    '반찬',
    '신선한 오이에 순두부 사과 소스를 더한 건강한 반찬입니다.',
    'ADMIN',  -- 작성자 ID를 필요에 따라 변경해 주세요.
    SYSDATE,
    '1. 사과, 순두부를 믹서에 넣고 곱게 갈아 소스를 만든다. 2. 오이는 소금으로 문질러 씻어 반을 갈라 씨를 제거하고 어슷썰기를 한다. 3. 썰어 놓은 오이에 순두부사과 소스를 넣고 버무린 후 다진 땅콩을 뿌려 마무리 한다.',
    0,  -- 추천 수 (초기값)
    0,  -- 평균 평점 (초기값)
    0,  -- 조회 수 (초기값)
    '오이 70g(1/3개), 다진 땅콩 10g(1큰술), 순두부 40g(1/8봉지), 사과 50g(1/3개)'
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

COMMENT ON COLUMN recipe_ingredient.allergy_id IS '연관된 알레르기 ID (allergy.allergy_id 참조)';
COMMENT ON COLUMN recipe_ingredient.ingredient_name IS '재료명';
COMMENT ON COLUMN recipe_ingredient.recipe_id IS '레시피 ID (recipe.recipe_id 참조)';
COMMENT ON COLUMN recipe_ingredient.ingredient_id IS '고유 ID';



INSERT INTO recipe_ingredient (recipe_id, ingredient_name, allergy_id) VALUES (3, '새우 ', NULL);
INSERT INTO recipe_ingredient (recipe_id, ingredient_name, allergy_id) VALUES (3, '달걀', 3);        -- 계란
INSERT INTO recipe_ingredient (recipe_id, ingredient_name, allergy_id) VALUES (3, '생크림', 2);       -- 우유

INSERT INTO recipe_ingredient (recipe_id, ingredient_name, allergy_id) VALUES (3, '무염버터 5g(1작은술)', 2);     -- 우유

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


COMMENT ON COLUMN report_post.report_id IS '신고 고유 ID (자동 생성)';
COMMENT ON COLUMN report_post.board_id IS '신고 대상 게시글 ID (board 테이블 참조)';
COMMENT ON COLUMN report_post.reason IS '신고 사유';
COMMENT ON COLUMN report_post.reporter_id IS '신고자 로그인 ID (users 테이블 참조)';
COMMENT ON COLUMN report_post.reported_at IS '신고 일시 (기본값 SYSDATE)';
COMMENT ON COLUMN report_post.is_checked IS '신고 처리 여부 (Y: 처리, N: 미처리, 기본값 N)';
COMMENT ON COLUMN report_post.checked_at IS '신고 처리 일시';


INSERT INTO report_post (board_id, reason, reporter_id) VALUES
(3, '부적절한 내용 포함', 'user01');

INSERT INTO report_post (board_id, reason, reporter_id, is_checked, checked_at) VALUES
(2, '스팸 게시물로 의심됨', 'user02', 'Y', SYSDATE);

INSERT INTO report_post (board_id, reason, reporter_id) VALUES
(2, '명예 훼손성 게시물', 'user03');



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

COMMENT ON COLUMN report_user.report_id IS '신고 고유 ID (자동 생성)';
COMMENT ON COLUMN report_user.reported_user_id IS '신고당한 사용자 login_id';
COMMENT ON COLUMN report_user.reason IS '신고 사유';
COMMENT ON COLUMN report_user.reporter_id IS '신고한 사용자 login_id';
COMMENT ON COLUMN report_user.reported_at IS '신고 일시 (기본값 SYSDATE)';
COMMENT ON COLUMN report_user.is_checked IS '신고 처리 여부 (Y: 처리, N: 미처리)';
COMMENT ON COLUMN report_user.checked_at IS '신고 처리 완료 일시';

INSERT INTO report_user (
    reported_user_id,
    reason,
    reporter_id,
    reported_at,
    is_checked,
    checked_at
) VALUES (
    'user01',  -- 신고당한 사용자 login_id
    '부적절한 게시물 작성',  -- 신고 사유
    'ADMIN',  -- 신고한 사용자 login_id
    SYSDATE,  -- 신고 일시 (기본값 SYSDATE이므로 생략 가능)
    'N',      -- 처리 여부 (기본값 'N'이므로 생략 가능)
    NULL      -- 처리 완료 일시 (아직 처리 전이라 NULL)
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

COMMENT ON COLUMN search_log.log_id IS '검색 로그 고유 ID (자동 생성)';
COMMENT ON COLUMN search_log.login_id IS '사용자 로그인 ID (users 테이블 참조)';
COMMENT ON COLUMN search_log.keyword IS '검색 키워드';
COMMENT ON COLUMN search_log.search_type IS '검색 유형 (예: 레시피, 게시글 등)';
COMMENT ON COLUMN search_log.searched_at IS '검색 일시 (기본값 SYSDATE)';


INSERT INTO search_log (login_id, keyword, search_type) VALUES
('user01', '닭가슴살 요리', 'recipe');

INSERT INTO search_log (login_id, keyword, search_type, searched_at) VALUES
('user02', '알레르기 없는 음식', 'recipe', TO_DATE('2025-04-18 10:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO search_log (login_id, keyword, search_type) VALUES
('user03', '건강 식단', 'recipe');


-- CREATE TABLE: user_allergy
CREATE TABLE user_allergy (
    login_id VARCHAR2(50) NOT NULL,
    allergy_id NUMBER NOT NULL,
    PRIMARY KEY (login_id, allergy_id),
    CONSTRAINT fk_user_allergy_login_id FOREIGN KEY (login_id) REFERENCES users(login_id),
    CONSTRAINT fk_user_allergy_allergy_id FOREIGN KEY (allergy_id) REFERENCES allergy(allergy_id)
);

COMMENT ON COLUMN user_allergy.login_id IS '사용자 로그인 ID (users 테이블 참조)';
COMMENT ON COLUMN user_allergy.allergy_id IS '알레르기 ID (allergy 테이블 참조)';


INSERT INTO user_allergy (login_id, allergy_id) VALUES ('user01', 1);  -- user01이 땅콩 알레르기 보유
INSERT INTO user_allergy (login_id, allergy_id) VALUES ('user02', 2);  -- user02가 우유 알레르기 보유
INSERT INTO user_allergy (login_id, allergy_id) VALUES ('user03', 3);  -- user03이 계란 알레르기 보유



-- CREATE TABLE: visit_log
CREATE TABLE visit_log (
    log_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login_id VARCHAR2(50) NOT NULL,
    ip_address VARCHAR2(50) NOT NULL,
    page_url VARCHAR2(255) NOT NULL,
    visited_at DATE NOT NULL,
    CONSTRAINT fk_visit_log_login_id FOREIGN KEY (login_id) REFERENCES users(login_id)
);


COMMENT ON COLUMN visit_log.log_id IS '방문 로그 고유 ID (자동 생성)';
COMMENT ON COLUMN visit_log.login_id IS '사용자 로그인 ID (users 테이블 참조)';
COMMENT ON COLUMN visit_log.ip_address IS '사용자 접속 IP 주소';
COMMENT ON COLUMN visit_log.page_url IS '사용자가 방문한 페이지 URL';
COMMENT ON COLUMN visit_log.visited_at IS '방문 일시';



INSERT INTO visit_log (login_id, ip_address, page_url, visited_at) VALUES
('user01', '192.168.0.1', '/home', SYSDATE);

INSERT INTO visit_log (login_id, ip_address, page_url, visited_at) VALUES
('user02', '203.0.113.15', '/recipe/123', TO_DATE('2025-04-18 14:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO visit_log (login_id, ip_address, page_url, visited_at) VALUES
('user03', '198.51.100.22', '/profile', TO_DATE('2025-04-17 09:15:00', 'YYYY-MM-DD HH24:MI:SS'));



-- CREATE TABLE: pairing
CREATE TABLE pairing (
    pairing_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    recipe_id NUMBER NOT NULL,
    drink_id NUMBER NOT NULL,
    reason VARCHAR2(300),
    CONSTRAINT fk_pairing_recipe FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    CONSTRAINT fk_pairing_drink FOREIGN KEY (drink_id) REFERENCES drink(drink_id)
);


COMMENT ON COLUMN pairing.drink_id IS '술 ID (drink.drink_id 참조)';
COMMENT ON COLUMN pairing.pairing_id IS '페어링 고유 ID';
COMMENT ON COLUMN pairing.reason IS '추천 이유';
COMMENT ON COLUMN pairing.recipe_id IS '레시피 ID (recipe.recipe_id 참조)';





INSERT INTO pairing (recipe_id, drink_id, reason) VALUES
(2, 4, '풍부한 맛이 고기의 풍미를 더욱 강조합니다.');

INSERT INTO pairing (recipe_id, drink_id, reason) VALUES
(2, 5, '양갈비와 잘 어울리며, 고기의 맛을 더욱 부각시킵니다.');

INSERT INTO pairing (recipe_id, drink_id, reason) VALUES
(2, 6, '다양한 요리와 조화를 이룹니다.');


-- CREATE TABLE: image
CREATE TABLE image (
    image_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    target_id NUMBER NOT NULL,
    target_type VARCHAR2(50) NOT NULL,
    image_url VARCHAR2(300) NOT NULL,
    description VARCHAR2(300)
);


COMMENT ON COLUMN image.image_id IS '이미지 고유 ID (자동 생성)';
COMMENT ON COLUMN image.target_id IS '이미지가 첨부된 대상 ID (예: 게시글, 레시피 등)';
COMMENT ON COLUMN image.target_type IS '이미지가 첨부된 대상 유형 (예: board, recipe 등)';
COMMENT ON COLUMN image.image_url IS '이미지 URL 또는 경로';
COMMENT ON COLUMN image.description IS '이미지에 대한 설명';


INSERT INTO image (target_id, target_type, image_url, description) VALUES
(10, 'board', 'https://example.com/images/dish1.jpg', '닭한마리 요리 사진');

INSERT INTO image (target_id, target_type, image_url, description) VALUES
(15, 'recipe', 'https://example.com/images/recipe_vegan.jpg', '비건 레시피 이미지');

INSERT INTO image (target_id, target_type, image_url, description) VALUES
(1, 'board', 'https://img.siksinhot.com/seeon/1691457106679833.jpg', NULL);

INSERT INTO image (target_id, target_type, image_url, description) VALUES
(2, 'board', 'https://cdn.3hoursahead.com/v2/content/image-comp/9eab277f-7a63-48fe-a8f1-35760b7d4687.webp', NULL);

INSERT INTO image (target_id, target_type, image_url, description) VALUES
(3, 'board', 'https://blogs.nvidia.co.kr/blog/geforce-rtx-studio-laptops-3050-ti/xps-17/', NULL);

INSERT INTO image (target_id, target_type, image_url, description) VALUES
(4, 'board', 'https://cdn.iconsumer.or.kr/news/photo/201701/14850944369080.png', NULL);

INSERT INTO image (target_id, target_type, image_url, description) VALUES
(5, 'board', 'https://sitem.ssgcdn.com/29/35/39/item/1000378393529_i1_750.jpg', NULL);

INSERT INTO image (target_id, target_type, image_url, description) VALUES
(4, 'recipe', 'http://www.foodsafetykorea.go.kr/uploadimg/cook/20_00032_2.png', '순두부 사과 소스 오이무침은 신선한 오이에 순두부 소스를 더한 건강한 반찬입니다.');

INSERT INTO image (target_id, target_type, image_url, description) VALUES
(4, 'recipe', 'http://www.foodsafetykorea.go.kr/uploadimg/cook/20_00032_3.png', '다른 각도에서 본 순두부 사과 소스 오이무침.');




-- CREATE TABLE: health_recommend
CREATE TABLE health_recommend (
    recommend_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reason VARCHAR2(300),
    recipe_id NUMBER NOT NULL,
    condition_id NUMBER NOT NULL,
    CONSTRAINT fk_health_recommend_recipe FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    CONSTRAINT fk_health_recommend_condition FOREIGN KEY (condition_id) REFERENCES health_condition(condition_id)
);

COMMENT ON COLUMN health_recommend.recommend_id IS '추천 고유 ID (자동 생성)';
COMMENT ON COLUMN health_recommend.reason IS '추천 사유 또는 설명';
COMMENT ON COLUMN health_recommend.recipe_id IS '추천 레시피 ID (recipe 테이블 참조)';
COMMENT ON COLUMN health_recommend.condition_id IS '건강 상태 ID (health_condition 테이블 참조)';


INSERT INTO health_recommend (reason, recipe_id, condition_id) VALUES
('당뇨 환자에게 적합한 저당 레시피', 1, 1);

INSERT INTO health_recommend (reason, recipe_id, condition_id) VALUES
('나트륨 섭취를 줄여 고혈압에 좋은 레시피', 2, 2);

INSERT INTO health_recommend (reason, recipe_id, condition_id) VALUES
('요산 수치 조절에 도움이 되는 레시피', 3, 3);

INSERT INTO health_recommend (reason, recipe_id, condition_id) VALUES
('지방 섭취 제한을 고려한 저지방 레시피', 4, 4);

INSERT INTO health_recommend (reason, recipe_id, condition_id) VALUES
('글루텐 민감증 환자도 안심하고 먹을 수 있는 레시피', 4, 5);



-- ADD INDEXES
CREATE INDEX idx_recipe_name ON recipe(name);
CREATE INDEX idx_search_log_keyword ON search_log(keyword);
CREATE INDEX idx_board_login_id ON board(login_id);




-- 04/24 추가

ALTER TABLE IMAGE
ADD IMAGE_DATA BLOB;


COMMENT ON COLUMN IMAGE.IMAGE_DATA IS '이미지 파일의 바이너리 데이터(BLOB 저장용)';

ALTER TABLE IMAGE MODIFY IMAGE_URL VARCHAR2(300 BYTE) NULL;


--04/25 추가
ALTER TABLE COMMENT ADD TARGET_TYPE VARCHAR2(20);


UPDATE comments
SET target_type = 'board'
WHERE target_type IS NULL;

alter table board
drop column recommend_number;

--04/28 추가
alter table board
drop column AVG_RATING;

alter table board
rename column login_id to writer

-- board, notice 테이블에 첨부파일 컬럼 추가 , post_file 테이블 삭제
drop table post_file cascade constraints;



ALTER TABLE recipe_INGREDIENT
DROP COLUMN RECIPE_ID;

-- 4/30 일 추가
-- CREATE TABLE: rating
CREATE TABLE rating (
    rating_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login_id VARCHAR2(50) NOT NULL,
    target_id NUMBER NOT NULL,
	 RATING_SCORE NUMBER(3, 1) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    TARGET_TYPE VARCHAR2(20),
    CONSTRAINT fk_rating_login_id FOREIGN KEY (login_id) REFERENCES users(login_id)
);

comment on column rating.rating_id is '평점 고유 ID';
comment on column rating.login_id is '평점 누른 사용자 ID';
comment on column rating.target_id is '대상 게시물의 ID';
comment on column rating.created_at is '평점 누른 시간';
comment on column rating.TARGET_TYPE is '평점 누른 게시글 타입';

-- 게시판 유형 영어로 변경
update board
set board_category = 'free'
where board_category = '자유';

update board
set board_category = 'review'
where board_category = '후기';

update board
set board_category = 'tip'
where board_category = '팁공유';

-- 5/1 일 추가

ALTER TABLE USERS
ADD (
    PHONE        	VARCHAR2(20 BYTE),     -- 전화번호
    AGE          	NUMBER,                	  -- 나이
    GENDER       	VARCHAR2(10 BYTE)      -- 성별 (예: '남', '여')
);

-- drink 데이터 추가

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('조니워커 블루 750ml', '40', 268900, '트러플 파스타', 'Aroma: 건포도, 스모키, 샌달우드, 다크 초콜릿; Taste: 헤이즐넛, 꿀, 장미꽃, 셰리, 오렌지; Finish: 스파이스, 블랙 페퍼, 스모키, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('더 글렌리', '40', 16400, '말린 과일', 'Aroma: 은은한, 꿀, 향신료, 오크; Taste: 바닐라, 토피, 오렌지, 가벼운; Finish: 부드러운, 크리미, 캐러멜', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('와일드 터키 레어브리드 1L', '58.4', 79900, '양고기 스튜', 'Aroma: 후추, 아몬드, 꿀, 건포도; Taste: 오렌지, 견과류, 구운 빵, 캐러멜; Finish: 스파이시, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('에반 윌리엄스 블랙', '43', 24900, '트러플 파스타', 'Aroma: 바닐라, 민트, 오렌지 껍질; Taste: 오크, 흑설탕, 캐러멜; Finish: 부드러운, 풍부한, 가죽', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('와일드 터키 12년 700ml', '50.5', 145000, '말린 과일', 'Aroma: 토피, 오렌지, 바닐라, 견과류, 오크, 가죽; Taste: 캐러멜, 오렌지, 바닐라, 버터스카치, 꿀, 허브, 육두구, 후추; Finish: 긴 여운, 크렘 브륄레, 메이플 시럽, 시나몬, 오크, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('맥캘란 12년 셰리 오크', '40', 139000, '블루치즈', 'Aroma: 말린 과일, 오크, 향신료; Taste: 육두구, 부드러운, 향신료; Finish: 긴 여운, 따뜻한, 생강', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('히비키 하모니', '43', 198000, '블루치즈', 'Aroma: 과일, 로즈마리, 장미; Taste: 화이트 초콜릿, 꿀, 오렌지; Finish: 긴 여운, 부드러운, 은은한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('포 로지스 스트레이트 버번 1L', '40', 34900, '양고기 스튜', 'Aroma: 플로럴, 꿀, 캐러멜, 레몬 껍질, 오렌지; Taste: 사과, 오크, 배, 바닐라, 꽃, 부드러운; Finish: 긴 여운, 스파이시, 오크, 오렌지', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발렌타인 21년', '40', 202300, '트러플 파스타', 'Aroma: 풍부한, 달콤한, 사과, 꽃; Taste: 감초, 스파이스, 균형 잡힌; Finish: 긴 여운, 그윽한, 말린 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('커티 삭 프로히비션', '50', 34900, '고르곤졸라 피자', 'Aroma: 건포도, 배, 감귤, 시트러스, 자두; Taste: 복숭아, 다크 초콜릿, 바닐라 퍼지; Finish: 견과류, 몰트, 캐러멜, 토피', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('미스터 보스턴 아이리시 1L', '40', 16500, '양고기 스튜', 'Aroma: 사과, 배, 꿀, 은은한; Taste: 달콤한, 부드러운, 토피; Finish: 견과류, 몰트, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('로얄살루트 21년 700ml', '40', 219000, '말린 과일', 'Aroma: 감귤, 꽃, 바닐라, 서양 배, 체리; Taste: 마멀레이드, 멜론, 스모키, 헤이즐넛; Finish: 향긋한, 풍부한, 긴 여운, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('산토리 가쿠빈', '40', 37900, '그릴드 스테이크', 'Aroma: 바닐라, 벌집, 아이스크림, 꽃; Taste: 감귤, 시트러스, 계피, 자몽; Finish: 꿀, 몰트, 후추, 견과류', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('포 로지스 싱글배럴', '50', 99900, '블루치즈', 'Aroma: 메이플 시럽, 배, 코코아, 향신료; Taste: 잘 익은 자두, 바닐라, 체리; Finish: 긴 여운, 부드러운, 섬세한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('짐빔 화이트 750ml', '40', 23900, '초콜릿 디저트', 'Aroma: 부드러운, 바닐라, 향긋한; Taste: 달콤한, 캐러멜, 조화로운; Finish: 오크, 견과류, 꿀', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('조니워커 블랙 700ml', '40', 43800, '크림치즈 베이글', 'Aroma: 사과, 배, 시트러스, 오크; Taste: 바닐라, 크리미, 말린 과일; Finish: 스모키, 달콤한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌피딕 15년', '40', 117900, '트러플 파스타', 'Aroma: 꿀, 바닐라, 구운 사과, 호두, 오렌지; Taste: 달콤한, 셰리, 스파이스, 건포도; Finish: 설탕에 절인 과일, 향신료, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('듀어스 12년', '40', 44900, '돼지 바비큐', 'Aroma: 과일, 레몬, 몰트, 바닐라; Taste: 꿀, 버터스카치, 피트; Finish: 달콤한, 부드러운, 가벼운 스모키', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('와일드 터키 레어브리드', '58.4', 89900, '트러플 파스타', 'Aroma: 풍부한, 꽃, 후추, 아몬드, 꿀, 대추야자; Taste: 따뜻한, 스모키, 곡물, 향신료; Finish: 긴 여운, 풍부한, 스파이시', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌드로낙 12년(구형)', '43', 105000, '매운 닭강정', 'Aroma: 달콤한, 바닐라, 견과류; Taste: 사과, 오크, 캐러멜, 토피; Finish: 건포도, 과일, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('하이랜드 퀸 셰리 캐스크 피니시', '40', 17900, '크림치즈 베이글', 'Aroma: 셰리, 건포도, 바닐라; Taste: 견과류, 달콤한, 고소한; Finish: 복합적인, 크리미, 스모키', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아드벡 10년', '46', 92000, '트러플 파스타', 'Aroma: 스모키, 다크 초콜릿, 레몬, 라임, 흑후추; Taste: 피트, 구운 파인애플, 배, 아몬드, 토피; Finish: 허브, 배, 소나무, 바닐라, 계피, 헤이즐넛', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('네이키드 몰트', '40', 49900, '호두 크래커', 'Aroma: 셰리, 말린 과일, 시트러스; Taste: 캐러멜, 달콤한, 몰트, 과수원; Finish: 부드러운, 오크, 버터, 토피', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('잭 다니엘스', '40', 38000, '초콜릿 디저트', 'Aroma: 달콤한, 바닐라, 과일; Taste: 캐러멜, 토피, 향신료; Finish: 부드러운, 그을린 오크, 커피', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발렌타인 30년', '40', 600000, '초콜릿 디저트', 'Aroma: 오크, 바닐라, 과일; Taste: 셰리, 바닐라, 벌꿀, 꽃; Finish: 긴 여운, 우아한, 복합적인', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌피딕 12년 셰리 캐스크 피니시', '43', 92900, '훈제 연어', 'Aroma: 배, 말린 과일, 스파이스; Taste: 구운 사과, 육두구, 오크, 계피; Finish: 긴 여운, 말린 과일, 스파이스', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('로크로몬드 12년 700ml', '46', 89000, '초콜릿 디저트', 'Aroma: 감귤, 배, 청사과; Taste: 레몬, 바닐라, 복숭아, 비스킷; Finish: 부드러운, 스모키', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌라씨', '40', 18500, '블루치즈', 'Aroma: 피트, 시트러스, 몰트; Taste: 달콤한, 바닐라, 부드러운; Finish: 스모키, 가벼운, 몰트', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('라가불린 16년', '43', 145000, '초콜릿 디저트', 'Aroma: 강한 피트, 스모키, 홍차, 셰리, 바닐라; Taste: 베이컨, 해초, 말린 과일, 몰트, 따뜻한; Finish: 드라이한, 스파이시, 달콤한, 바닐라', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌파클라스 15년', '46', 139000, '치즈 플래터', 'Aroma: 말린 과일, 복합적인, 셰리, 버터스카치; Taste: 건포도, 견과류, 달콤한, 몰트, 셰리; Finish: 긴 여운, 달콤한, 셰리, 크리스마스 케이크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아란 10년', '46', 89000, '매운 닭강정', 'Aroma: 과일, 시트러스; Taste: 바닐라, 시나몬, 오렌지, 오크; Finish: 사과, 달콤한, 시트러스', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('미스터 보스턴 캐나디안 1L', '40', 16500, '트러플 파스타', 'Aroma: 캐러멜, 오크, 시나몬; Taste: 옥수수, 달콤한, 향신료; Finish: 부드러운, 스파이시', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('달모어 12년', '40', 120000, '말린 과일', 'Aroma: 스파이시, 열대 과일, 초콜릿; Taste: 바닐라, 셰리, 열대 과일; Finish: 로스팅한 커피, 스모키, 초콜릿', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('맥캘란 18년 더블 캐스크', '43', 489000, '트러플 파스타', 'Aroma: 말린 과일, 생강, 오렌지; Taste: 바닐라, 생강, 스파이스, 캐러멜; Finish: 생강, 오렌지, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('러셀 리저브 15년', '58.6', 519000, '훈제 연어', 'Aroma: 말린 과일, 캐러멜, 넛맥, 클로브, 흙내음; Taste: 체리, 자두, 과일, 커피, 오크, 타바코; Finish: 코코아, 캐러멜, 부드러운, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌알라키 15년', '46', 189000, '호두 크래커', 'Aroma: 다크 체리, 시럽, 향신료, 토피; Taste: 헤더 꿀, 오렌지 껍질, 코코아, 생강; Finish: 흑설탕, 무화과 절임, 헤이즐넛', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('시바스 리갈 18년', '40', 129000, '호두 크래커', 'Aroma: 말린 과일, 향신료, 버터, 토피; Taste: 다크 초콜릿, 꽃, 스모키; Finish: 부드러운, 긴 여운, 온화한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('더 글렌그란트 10년', '40', 49000, '블루치즈', 'Aroma: 달콤한, 페이스트리, 바닐라, 배; Taste: 몰트, 프루티, 달콤한; Finish: 과수원, 버터스카치', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('기원 유니콘', '46', 118800, '그릴드 스테이크', 'Aroma: 피트, 낙엽, 장작; Taste: 오렌지 껍질, 스파이스, 떫은; Finish: 오크, 꿀, 자두', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('더 글렌리벳 15년', '40', 126000, '호두 크래커', 'Aroma: 스파이시, 견과류, 과일; Taste: 과일, 토피 초콜릿, 오크; Finish: 헤이즐넛, 진한, 풍부한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌피딕 14년 버번 배럴 리저브', '43', 98000, '감자튀김', 'Aroma: 레몬, 리치, 파인애플; Taste: 망고, 패션프루트, 아몬드; Finish: 달콤한, 사과, 시나몬', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌피딕 18년 500ml', '40', 124000, '훈제 연어', 'Aroma: 포도, 사과, 나무, 시나몬; Taste: 과일, 생강, 셰리; Finish: 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발렌타인 17년 750ml', '40', 169000, '크림치즈 베이글', 'Aroma: 오크, 바닐라, 스모키; Taste: 벌꿀, 감초, 스파이시; Finish: 긴 여운, 달콤한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('보모어 18년 Deep & Complex', '43', 224000, '초콜릿 디저트', 'Aroma: 다크 초콜릿, 당밀, 토피, 대추; Taste: 오렌지, 시트러스, 피트, 스모키, 커피; Finish: 실키, 모카, 마카다미아, 초콜릿', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌 기어리 12년', '48', 129000, '고르곤졸라 피자', 'Aroma: 꿀, 헤더 꽃, 배, 몰트, 달콤한; Taste: 크렘 브륄레, 바나나, 오크, 배, 부드러운; Finish: 향긋한, 균형 잡힌, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('조니워커 골드 750ml', '40', 71900, '치즈 플래터', 'Aroma: 달콤한, 스모키, 부드러운; Taste: 과일, 꿀, 크리미, 화려한; Finish: 긴 여운, 달콤한, 스모키', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('잭 다니엘스 맥라렌 에디션', '40', 44900, '불고기', 'Aroma: 달콤한, 바닐라, 과일; Taste: 캐러멜, 토피, 향신료; Finish: 부드러운, 그을린 오크, 커피', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌파클라스 105 CS', '60', 127000, '훈제 연어', 'Aroma: 달콤한, 오크, 사과, 서양 배, 토피, 견과류; Taste: 대담한, 스파이시, 오크, 셰리, 과일; Finish: 실키, 따뜻한, 스모키, 후추', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('오켄토션 아메리칸 오크', '40', 39000, '트러플 파스타', 'Aroma: 바닐라, 코코넛, 시트러스, 감귤; Taste: 바닐라, 부드러운, 백도, 상쾌한; Finish: 크리스피, 설탕을 뿌린 자몽, 향신료', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌피딕 21년', '43.2', 378000, '초콜릿 디저트', 'Aroma: 꿀, 오렌지, 초콜릿, 흑설탕; Taste: 과일, 바닐라, 생강, 스파이스, 오크; Finish: 마멀레이드, 긴 여운, 모카', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('조니워커 더블 블랙 700ml', '40', 48900, '말린 과일', 'Aroma: 강렬한, 사과, 배, 시트러스; Taste: 스모키, 바닐라, 크리미, 말린 과일; Finish: 달콤한, 오크, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('더 글렌드로낙 12년', '43', 85000, '블루치즈', 'Aroma: 캐러멜, 시트러스, 후추, 서양 배; Taste: 셰리, 바닐라, 무화과, 생강, 오크; Finish: 건포도, 견과류, 중후한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 더블우드 12년', '40', 120000, '초콜릿 디저트', 'Aroma: 과일, 셰리, 벌꿀, 바닐라; Taste: 견과류, 계피, 셰리, 스파이스; Finish: 긴 여운, 복합적인, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 캐리비안 캐스크 14년', '43', 163000, '불고기', 'Aroma: 토피, 바닐라, 과일, 신선한; Taste: 바닐라, 오크, 과일, 달콤한; Finish: 따뜻한, 부드러운, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 15년 마데이라 캐스크', '43', 263000, '불고기', 'Aroma: 블랙커런트, 브램블, 생강, 스파이시, 잘 익은 자두; Taste: 시트러스, 오렌지, 헤이즐넛, 잘 익은 자두; Finish: 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 16년 프렌치 오크', '47.6', 330000, '트러플 파스타', 'Aroma: 다채로운, 셰리, 사과; Taste: 꿀, 달콤한, 자몽, 스파이시; Finish: 복숭아, 생강, 오크, 후추', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 더블우드 17년', '43', 650000, '치즈 플래터', 'Aroma: 오크, 바닐라, 벌꿀, 그린 애플; Taste: 말린 과일, 샤베트, 구운 아몬드, 계피, 토피, 바닐라; Finish: 바닐라, 오크, 벌꿀, 스파이시, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 25년 레어 메리지', '48', 1245900, '훈제 연어', 'Aroma: 오크, 꽃, 꿀, 구운 마시멜로; Taste: 서양 배, 바닐라, 시트러스, 감귤; Finish: 생강, 향신료, 시나몬, 사과 파이', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('맥캘란 12년 셰리 오크', '40', 139000, '양고기 스튜', 'Aroma: 말린 과일, 오크, 향신료; Taste: 육두구, 부드러운, 향신료; Finish: 긴 여운, 따뜻한, 생강', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('맥캘란 18년 셰리 오크 2024', '43', 550000, '트러플 파스타', 'Aroma: 타르트, 생강 줄기, 셰리에 절인 건포도, 오렌지, 시나몬; Taste: 다크 초콜릿, 생강, 대추야자, 말린 살구, 오크, 바닐라; Finish: 긴 여운, 말린 과일, 생강, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('벡스 리슬링', '11.5', 12800, '불고기', 'Aroma: 오렌지 꽃, 라임, 시트러스; Taste: 복숭아, 청사과, 살구; Finish: 깔끔한, 감귤, 미네랄리티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('스톤 베이 소비뇽 블랑', '12.5', 22100, '고르곤졸라 피자', 'Aroma: 허브, 건초, 레몬, 시트러스; Taste: 풋사과, 풀, 산뜻한, 청포도; Finish: 부드러운, 청량한, 상쾌한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('유 원 프리미티보 디 만두리아', '14.5', 22000, '치즈 플래터', 'Aroma: 라즈베리, 블루베리, 바닐라, 허브; Taste: 체리, 자두, 초콜릿; Finish: 라즈베리, 부드러운, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('무초 마스 레드', '13~14', 19900, '돼지 바비큐', 'Aroma: 블랙베리, 발사믹, 가죽, 바닐라; Taste: 오크, 자두, 체리, 초콜릿; Finish: 타바코, 코코아, 미네랄리티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('킨즈마라울리 마라니 킨즈마라울리 레드 세미 스위트', '11.5', 36900, '초콜릿 디저트', 'Aroma: 레드베리, 딸기, 플로럴; Taste: 달콤한, 잘 익은 포도, 쥬시, 홍차; Finish: 붉은 과일, 흙내음, 신선한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('보시오 트로피칼 모스카토 망고', '5.5', 13200, '감자튀김', 'Aroma: 청포도, 망고, 꽃; Taste: 산뜻한, 과일, 달콤한; Finish: 복숭아, 꿀, 향긋한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('그라함 20년 토니 포트 와인', '20', 115000, '훈제 연어', 'Aroma: 오크, 초콜릿, 캐러멜, 타바코, 토피; Taste: 견과류, 바닐라, 오렌지 껍질, 커피; Finish: 긴 여운, 달콤한, 우아한, 잘 익은 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('칸티 모스카토 다스티 DOCG', '5.5', 14500, '감자튀김', 'Aroma: 은은한, 아카시아, 달콤한; Taste: 자스민, 꿀, 배, 탄산감; Finish: 상쾌한, 부드러운, 균형 잡힌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('프로메사 모스카토', '7~8', 11100, '불고기', 'Aroma: 사과, 감귤, 시트러스, 그린 애플; Taste: 복숭아, 파인애플, 망고, 미네랄리티; Finish: 꽃, 구아바, 체리, 달콤한, 오렌지', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('오트 쿠튀르 프렌치 버블스', '11', 25000, '치즈 플래터', 'Aroma: 빵, 아몬드, 고소한; Taste: 배, 복숭아; Finish: 달콤한, 부드러운, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('싸베 씨 말보로 소비뇽 블랑', '13', 25000, '크림치즈 베이글', 'Aroma: 멜론, 자몽, 패션프루트, 허브; Taste: 구스베리, 멜론, 자몽, 열대 과일, 복숭아, 미네랄리티; Finish: 깔끔한, 신선한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('투 리버즈 소비뇽 블랑', '13~13.5', 32000, '크림치즈 베이글', 'Aroma: 감귤, 미네랄리티, 시트러스, 허브; Taste: 열대 과일, 파인애플, 패션프루트; Finish: 구스베리, 라임, 아스파라거스, 자몽', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('레이크 찰리스 네스트 소비뇽 블랑', '12~13', 23700, '호두 크래커', 'Aroma: 레몬, 감귤, 시트러스, 자몽; Taste: 망고, 청사과, 파인애플, 패션프루트; Finish: 구스베리, 미네랄리티, 열대 과일, 풀', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('테일러 파인 토니 포트 와인', '20', 19900, '그릴드 스테이크', 'Aroma: 베리, 부드러운; Taste: 버터스카치, 무화과, 자두, 견과류, 스파이시; Finish: 둥근, 부드러운, 풍부한, 딸기 잼', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('투 리버즈 소비뇽 블랑', '13~13.5', 32000, '트러플 파스타', 'Aroma: 감귤, 미네랄리티, 시트러스, 허브; Taste: 열대 과일, 파인애플, 패션프루트; Finish: 구스베리, 라임, 아스파라거스, 자몽', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('루이 페드리에 브뤼', '11', 9900, '치즈 플래터', 'Aroma: 사과, 살구, 복숭아, 멜론; Taste: 청사과, 배, 시트러스, 감귤, 미네랄리티; Finish: 레몬, 라임, 자몽, 꿀', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아리온, 러스치케토 로쏘', '6.5', 10000, '양고기 스튜', 'Aroma: 플로럴, 향긋한, 신선한; Taste: 달콤한, 붉은 베리류, 쥬시; Finish: 균형 잡힌, 풍부한, 탄산감', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('마스카 델 타코 수수마니엘로', '14.5', 31000, '트러플 파스타', 'Aroma: 블루베리, 바닐라, 허브, 초콜릿; Taste: 자두, 블랙베리, 라즈베리, 체리; Finish: 우아한, 신선한, 부드러운, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('텍스트북 나파 까베르네 소비뇽', '13.3', 74000, '감자튀김', 'Aroma: 후추, 블랙커런트, 담배, 연필심; Taste: 자두, 체리, 유칼립투스, 블루베리; Finish: 부드러운 타닌, 자두, 카시스', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('로버트 몬다비 빈트 프라이빗 셀렉션 버터리 샤르도네', '12~14', 25800, '고르곤졸라 피자', 'Aroma: 파인애플, 타르트, 달콤한, 크렘 브륄레; Taste: 풍부한, 커스터드, 파이, 바닐라빈; Finish: 토스트, 오크, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('칸티 모스카토 다스티 DOCG', '5.5', 13800, '말린 과일', 'Aroma: 은은한, 아카시아, 달콤한; Taste: 자스민, 꿀, 배, 탄산감; Finish: 상쾌한, 부드러운, 균형 잡힌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('루이 에슈너 골드 22K 스파클링', '11', 30500, '돼지 바비큐', 'Aroma: 열대 과일, 복숭아, 향긋한; Taste: 핵과류, 상큼한, 자두; Finish: 상쾌한, 산뜻한, 경쾌한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('유 원 프리미티보 디 만두리아', '14.5', 24500, '매운 닭강정', 'Aroma: 라즈베리, 블루베리, 바닐라, 허브; Taste: 체리, 자두, 초콜릿; Finish: 라즈베리, 부드러운, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('로쉐 마제, 까베르네 소비뇽', '12.5', 12000, '말린 과일', 'Aroma: 블랙베리, 오크, 체리, 가죽; Taste: 강렬한, 건포도, 구운 견과류; Finish: 타닌, 스모키, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('배비치 블랙 라벨 말보로 소비뇽 블랑', '13~14', 38000, '호두 크래커', 'Aroma: 자몽, 레몬, 열대 과일, 패션프루트; Taste: 청사과, 감귤, 파인애플, 라임; Finish: 신선한, 깔끔한, 싱그러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('마츠 엘 비에호', '15', 55000, '블루치즈', 'Aroma: 잘 익은 과일; Taste: 타닌, 초콜릿; Finish: 복합적인', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('레 부흐가헬 피노 누아', '12~14', 25000, '훈제 연어', 'Aroma: 바닐라, 코코아, 오크; Taste: 스모키, 후추, 체리; Finish: 풀잎, 딸기, 허브', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('브레드 앤 버터 피노 누아', '13.5', 30900, '그릴드 스테이크', 'Aroma: 체리, 카시스, 오크; Taste: 라즈베리, 산딸기, 스모키; Finish: 긴 여운, 부드러운 타닌, 섬세한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('구에리에로 델라 테라', '15', 66500, '돼지 바비큐', 'Aroma: 블랙베리, 체리, 자두 잼, 향신료, 멘톨; Taste: 라즈베리, 바닐라, 잘 익은 과일, 초콜릿; Finish: 풍성한, 향긋한, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('포지오 마루 프리미티보 디 만두리아', '14.5', 24300, '양고기 스튜', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('싸베 씨 말보로 소비뇽 블랑', '13', 25000, '불고기', 'Aroma: 멜론, 자몽, 패션프루트, 허브; Taste: 구스베리, 멜론, 자몽, 열대 과일, 복숭아, 미네랄리티; Finish: 깔끔한, 신선한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('루이 페드리에 브뤼', '11', 9900, '훈제 연어', 'Aroma: 사과, 살구, 복숭아, 멜론; Taste: 청사과, 배, 시트러스, 감귤, 미네랄리티; Finish: 레몬, 라임, 자몽, 꿀', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('무초 마스 레드 매그넘 1.5L', '13~15', 31100, '초콜릿 디저트', 'Aroma: 블랙베리, 발사믹, 가죽, 바닐라; Taste: 오크, 자두, 체리, 초콜릿; Finish: 타바코, 코코아, 미네랄리티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('라파우라 스프링스 소비뇽 블랑', '13.5', 21000, '블루치즈', 'Aroma: 자몽, 시트러스, 레몬 껍질; Taste: 열대 과일, 패션프루트, 신선한; Finish: 향긋한, 복숭아, 청사과', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('바이올렛 7', '7', 32900, '트러플 파스타', 'Aroma: 플로럴, 상큼한, 열대 과일; Taste: 자몽, 자스민, 레몬; Finish: 섬세한, 부드러운, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('루이 페드리에 브뤼', '11', 11200, '말린 과일', 'Aroma: 사과, 살구, 복숭아, 멜론; Taste: 청사과, 배, 시트러스, 감귤, 미네랄리티; Finish: 레몬, 라임, 자몽, 꿀', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('베서니 블루 쿼리 쉬라즈', '14.5', 49500, '고르곤졸라 피자', 'Aroma: 블랙 체리, 정향, 향긋한; Taste: 오크, 다크 초콜릿, 블랙베리; Finish: 향신료, 풍부한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아마란타 몬테풀치아노 다브루쪼', '14', 41000, '크림치즈 베이글', 'Aroma: 바닐라, 오크, 초콜릿; Taste: 자두, 블랙베리, 블랙커런트; Finish: 블랙 체리, 라즈베리, 체리', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('롱반 샤르도네', '13~14', 18500, '호두 크래커', 'Aroma: 오크, 바닐라, 버터, 아몬드; Taste: 바닐라, 오일리, 사과; Finish: 파인애플, 열대 과일, 망고', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('서브미션 샤르도네', '13.5', 23000, '치즈 플래터', 'Aroma: 오크, 바닐라, 배, 청사과, 타임; Taste: 바닐라, 버터, 파인애플, 오렌지, 망고; Finish: 꿀, 미네랄리티, 레몬, 라임', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('캔달 잭슨 빈트너스 리저브 샤르도네', '13~14', 47000, '돼지 바비큐', 'Aroma: 청사과, 사과, 복숭아, 멜론, 살구; Taste: 버터, 바닐라, 파인애플, 캐러멜, 배; Finish: 오크, 삼나무, 코코넛, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('델링퀀트 스크리밍 베티', '12', 25900, '훈제 연어', 'Aroma: 매실, 복숭아; Taste: 시트러스, 감귤, 신선한, 자몽; Finish: 멜론, 미네랄리티, 배, 사과', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('오스틴 호프, 까베르네 소비뇽 2021', '14.5', 112000, '크림치즈 베이글', 'Aroma: 블루베리, 검은 과일, 커피; Taste: 타닌, 후추, 바닐라; Finish: 균형 잡힌, 미묘한, 허브', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('유 원 프리미티보 디 만두리아', '14.5', 24500, '트러플 파스타', 'Aroma: 라즈베리, 블루베리, 바닐라, 허브; Taste: 체리, 자두, 초콜릿; Finish: 라즈베리, 부드러운, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('브레드 앤 버터 피노 누아', '13.5', 30900, '그릴드 스테이크', 'Aroma: 체리, 카시스, 오크; Taste: 라즈베리, 산딸기, 스모키; Finish: 긴 여운, 부드러운 타닌, 섬세한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('구에리에로 델라 테라', '15', 66500, '말린 과일', 'Aroma: 블랙베리, 체리, 자두 잼, 향신료, 멘톨; Taste: 라즈베리, 바닐라, 잘 익은 과일, 초콜릿; Finish: 풍성한, 향긋한, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('생마차 라거 캔 500ml', 'NULL', 1900, '불고기', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('안동맥주 경화수월 만취 에디션', '7', 13900, '초콜릿 디저트', 'Aroma: 플로럴, 향기로운, 배; Taste: 달콤한, 쌉쌀한, 바나나; Finish: 은은한, 향신료, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('듀체스 드 부르고뉴 750ml', '6.2', 17000, '고르곤졸라 피자', 'Aroma: 블랙베리, 건자두, 체리; Taste: 와인, 상큼한, 효모; Finish: 상큼한, 풍부한, 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파울라너 바이스비어 캔 500ml', 'NULL', 4500, '트러플 파스타', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('홉스플래쉬 IPA 500ml', '6.7', 6900, '매운 닭강정', 'Aroma: 파인애플, 오렌지; Taste: 열대 과일, 시트러스; Finish: 쌉쌀한, 달콤한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('빅웨이브 캔 473ml', 'NULL', 4500, '호두 크래커', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('올드라스푸틴 캔 473ml', 'NULL', 6900, '고르곤졸라 피자', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('트리펠 까르멜리엇 750ml', '8.4', 14900, '매운 닭강정', 'Aroma: 감귤, 시트러스, 우아한, 허브; Taste: 레몬, 귀리, 달콤한, 밀, 바나나, 향신료; Finish: 깔끔한, 부드러운, 진한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아사히 슈퍼 드라이 생맥주 캔 340ml', '5', 4900, '불고기', 'Aroma: 풍부한, 맥아, 은은한; Taste: 홉, 보리, 고소한; Finish: 시원한, 청량감, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('기린 이치방 캔 500ml', '5', 4500, '그릴드 스테이크', 'Aroma: 몰트, 진한, 풍부한; Taste: 부드러운, 보리, 맑은; Finish: 깨끗한, 섬세한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('산토리 캔 500ml', 'NULL', 4900, '크림치즈 베이글', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('오리지널비어컴퍼니 불락 스타우트', '9', 35000, '돼지 바비큐', 'Aroma: 커피, 다크 초콜릿; Taste: 캐러멜, 견과류; Finish: 참나무, 오크, 바닐라', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('구스 아일랜드 IPA 캔 473ml', 'NULL', 4900, '호두 크래커', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아잉거 우르바이스', '5.8', 5800, '트러플 파스타', 'Aroma: 토스트, 바나나, 정향; Taste: 부드러운, 고소한; Finish: 균형 잡힌, 알싸한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('오드 괴즈 분', '7', 13900, '고르곤졸라 피자', 'Aroma: 상큼한, 레몬, 청사과; Taste: 포도, 브렛, 균형 잡힌; Finish: 풍부한, 탄산감, 쿰쿰한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아사히 병 640ml', 'NULL', 4900, '양고기 스튜', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('첫사랑 IPA 캔 500ml', 'NULL', 6900, '양고기 스튜', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카스 캔 740ml', 'NULL', 4500, '불고기', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('라 트라페 쿼드루펠', '10', 19500, '매운 닭강정', 'Aroma: 정향, 견과류, 바닐라, 건포도, 바나나; Taste: 묵직한, 대추, 캐러멜, 몰트; Finish: 부드러운, 쌉쌀한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('기네스 드래프트 캔 440ml', '4.2', 4900, '불고기', 'Aroma: 구운 몰트, 로스팅한 커피, 다크 초콜릿; Taste: 로스팅한 커피, 카카오; Finish: 긴 여운, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('태평양조 토마 호프', '5.3', 6900, '트러플 파스타', 'Aroma: 향긋한, 신선한, 홉; Taste: 토마토, 허브, 산뜻한; Finish: 깔끔한, 부드러운, 상쾌한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('삿포로 캔 500ml', 'NULL', 4500, '블루치즈', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('기네스 콜드브루 캔 440ml', 'NULL', 4900, '블루치즈', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('고양이가 우주를 구한다 선생', '5.5', 7500, '호두 크래커', 'Aroma: 시트러스, 향긋한, 망고; Taste: 열대 과일, 화사한, 코코넛; Finish: 부드러운, 풍성한, 오렌지', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아사히 캔 500ml', '5', 4900, '매운 닭강정', 'Aroma: 향긋한, 시트러스, 홉; Taste: 맥아, 고소한, 상쾌한; Finish: 청량한, 경쾌한 탄산, 가벼운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('대만 망고 맥주', '2.8', 3900, '감자튀김', 'Aroma: 향긋한, 망고, 열대 과일; Taste: 신선한, 달콤한, 상큼한; Finish: 깔끔한, 상쾌한, 가벼운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('로덴바흐 그랑 크뤼', '6', 16900, '고르곤졸라 피자', 'Aroma: 레드베리, 체리, 오크; Taste: 붉은 과일, 레드 커런트, 상큼한; Finish: 나무, 긴 여운, 발사믹', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('노을 수제 에일 캔 500ml', '4.5', 4000, '매운 닭강정', 'Aroma: 신선한, 캐러멜, 비스킷; Taste: 몰트, 빵, 곡물; Finish: 홉, 감귤, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('델리리움 트레멘스 750ml', '8.5', 18500, '그릴드 스테이크', 'Aroma: 스파이시, 청량한, 몰트, 꽃; Taste: 달콤한, 향긋한, 사과, 배; Finish: 긴 여운, 쌉쌀한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('블루문 캔 500ml', 'NULL', 4500, '호두 크래커', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카스 캔 500ml', '4.5', 2800, '그릴드 스테이크', 'Aroma: 레몬, 홉, 보리; Taste: 비스킷, 캐러멜, 깔끔한; Finish: 몰트, 고소한, 상쾌한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('기린 당류 제로 캔 500ml', 'NULL', 4500, '양고기 스튜', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('스트라프 헨드릭 트리펠 750ml', '9', 14900, '크림치즈 베이글', 'Aroma: 흑후추, 진저, 향긋한; Taste: 캐러멜, 시트러스, 잘 익은 바나나; Finish: 균형 잡힌, 긴 여운, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('생 라임 맥주 캔 500ml', 'NULL', 4500, '고르곤졸라 피자', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('프로젝트 해피 호빵이', '7', 7900, '매운 닭강정', 'Aroma: 신선한, 시트러스, 향긋한; Taste: 망고, 파파야, 청포도; Finish: 은은한, 싱그러운, 풍성한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('호가든 캔 500ml', '4.9', 4900, '훈제 연어', 'Aroma: 향긋한, 코리앤더 씨드; Taste: 시트러스, 산뜻한, 부드러운; Finish: 오렌지 껍질, 가벼운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('이네딧 담 750ml', '5', 22000, '감자튀김', 'Aroma: 가벼운, 상쾌한, 가벼운; Taste: 상쾌한, 깔끔한, 과일; Finish: 가벼운, 상큼한, 깔끔한, 상쾌한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아잉거 브로바이스', '5.1', 5800, '매운 닭강정', 'Aroma: 부드러운, 달콤한, 바닐라, 꽃; Taste: 달콤한, 부드러운; Finish: 쌉쌀한, 가벼운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('세인트 버나두스 앱 12', '10', 15900, '트러플 파스타', 'Aroma: 흑설탕, 건포도, 캐러멜, 꿀; Taste: 초콜릿, 구운 빵, 복합적인; Finish: 부드러운, 쌉쌀한, 커피, 체리', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파우웰 콱 750ml', '8.4', 14900, '트러플 파스타', 'Aroma: 캐러멜, 달콤한, 사탕; Taste: 오렌지 마멀레이드, 비스킷, 바나나; Finish: 쌉쌀한, 허브, 스파이시', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카스 레몬 스퀴즈 캔 500ml', 'NULL', 2800, '고르곤졸라 피자', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('에비스 캔 500ml', '5', 5000, '호두 크래커', 'Aroma: 꽃, 몰트, 은은한; Taste: 청량한, 고소한, 부드러운; Finish: 깔끔한, 쌉쌀한, 은은한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아잉거 알트 바이리쉬 둔켈', '5.8', 5800, '양고기 스튜', 'Aroma: 구운 몰트, 캐러멜, 꽃; Taste: 커피, 견과류, 토피, 부드러운; Finish: 쌉쌀한, 홉, 초콜릿', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('슈무커 헤페바이젠', '5', 5200, '치즈 플래터', 'Aroma: 바나나, 효모, 사과; Taste: 바나나, 부드러운, 효모; Finish: 꽃, 부드러운, 풍부한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카프리 병 330ml', 'NULL', 2250, '고르곤졸라 피자', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('오리지널비어컴퍼니 코스모스 에일', '4.5', 26000, '돼지 바비큐', 'Aroma: 향긋한, 유자, 제피; Taste: 프루티, 시트러스, 감귤; Finish: 청량한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('듀체스 드 부르고뉴 750ml', '6.2', 21000, '초콜릿 디저트', 'Aroma: 블랙베리, 건자두, 체리; Taste: 와인, 상큼한, 효모; Finish: 상큼한, 풍부한, 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('테라 라이트 캔 500ml', 'NULL', 2800, '호두 크래커', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아사히 쇼쿠사이 340ml', 'NULL', 4900, '초콜릿 디저트', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('테라 캔 500ml', 'NULL', 2800, '불고기', 'Aroma: 레몬, 몰트, 비스킷; Taste: 보리, 홉, 은은한, 빵; Finish: 경쾌한, 탄산감', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('크로넨버그 1664 블랑 캔 500ml', '5', 4500, '그릴드 스테이크', 'Aroma: 열대 과일, 몰트, 은은한; Taste: 균형 잡힌, 달콤한, 쌉쌀한, 홉; Finish: 긴 여운, 부드러운, 오렌지', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('듀퐁 본 뵈', '9.5', 13000, '치즈 플래터', 'Aroma: 바나나, 오렌지, 향긋한; Taste: 시트러스, 헤이즐넛, 캐러멜; Finish: 레몬, 가죽, 스파이스', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('스텔라 아르투아 캔 740ml', '5', 5400, '초콜릿 디저트', 'Aroma: 오렌지, 홉, 은은한, 레몬; Taste: 빵, 보리, 고소한; Finish: 경쾌한 탄산, 깔끔한, 청량한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('스트라프 헨드릭 쿼드루펠 750ml', '11', 18400, '치즈 플래터', 'Aroma: 구운 오크, 다크 초콜릿, 우아한; Taste: 깔끔한, 단단한 구조감, 복합적인, 코리앤더 씨드, 다크 베리; Finish: 균형 잡힌, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('세인트 버나두스 앱 12', '10', 24900, '말린 과일', 'Aroma: 흑설탕, 건포도, 캐러멜, 꿀; Taste: 초콜릿, 구운 빵, 복합적인; Finish: 부드러운, 쌉쌀한, 커피, 체리', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('고양이가 우주를 구한다 타이 얌이', '5.5', 7500, '불고기', 'Aroma: 시트러스, 향긋한, 화사한; Taste: 열대 과일, 레몬, 라임; Finish: 풍성한, 오렌지, 후추', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('세종 듀퐁', '6.5', 10900, '매운 닭강정', 'Aroma: 후추, 향신료, 꽃; Taste: 레몬, 청포도, 풀; Finish: 부드러운, 쌉쌀한, 복합적인', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아트몬스터 사랑범벅', '5.9', 6000, '고르곤졸라 피자', 'Aroma: 초콜릿, 구운 몰트, 땅콩; Taste: 땅콩 버터, 부드러운, 달콤한; Finish: 캐러멜, 초콜릿, 커피', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('사이공 스페셜 캔 330ml', '4.9', 2500, '고르곤졸라 피자', 'Aroma: 풀, 꽃, 홉, 맥아; Taste: 신선한, 상쾌한, 청량감; Finish: 은은한 단맛, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('슈무커 헤페바이젠', '5', 5200, '초콜릿 디저트', 'Aroma: 바나나, 효모, 사과; Taste: 바나나, 부드러운, 효모; Finish: 꽃, 부드러운, 풍부한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('슈렝케를라 메르첸', '5.1', 10500, '돼지 바비큐', 'Aroma: 숯불, 훈제 베이컨, 토스트; Taste: 보리, 오크, 로스팅한 커피; Finish: 은은한, 쌉쌀한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('켈리 병 500ml', 'NULL', 2400, '고르곤졸라 피자', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('슈렝케를라 메르첸', '5.1', 10500, '양고기 스튜', 'Aroma: 숯불, 훈제 베이컨, 토스트; Taste: 보리, 오크, 로스팅한 커피; Finish: 은은한, 쌉쌀한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('하이네켄 캔 500ml', '5', 4900, '돼지 바비큐', 'Aroma: 레몬, 보리, 홉, 은은한; Taste: 몰트, 빵, 곡물; Finish: 깔끔한, 탄산감, 깔끔한 탄산감', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('하이네켄 실버 캔 500ml', '4', 4900, '크림치즈 베이글', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('타이거 포멜로 캔 500ml', 'NULL', 4500, '트러플 파스타', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('크릭 분', '4', 17300, '매운 닭강정', 'Aroma: 체리, 검붉은 과일, 과일; Taste: 상큼한, 과일 잼, 레드 와인; Finish: 산미, 부드러운, 은은한 탄산감', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('오리지널비어컴퍼니 월롱 블랑', '4.5', 26000, '돼지 바비큐', 'Aroma: 오렌지 껍질, 코리앤더 씨드; Taste: 시트러스, 감귤, 상쾌한; Finish: 부드러운, 우아한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('안동맥주 석복', '4.1', 19900, '고르곤졸라 피자', 'Aroma: 상큼한, 시트러스, 상쾌한; Taste: 짭짤한, 감칠맛, 방아 잎; Finish: 가벼운, 산뜻한, 복합적인', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('코젤 다크 캔 500ml', '3.8', 4900, '돼지 바비큐', 'Aroma: 시나몬, 커피, 고소한; Taste: 달콤한, 다크 초콜릿; Finish: 청량한, 깔끔한 탄산감', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('혁명소주 42% 500ml', '42', 6900, '그릴드 스테이크', 'Aroma: 파인애플, 달콤한, 향긋한; Taste: 사과, 깔끔한, 산뜻한; Finish: 배, 부드러운, 곡물', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('토끼소주 블랙 750ml', '40', 35800, '호두 크래커', 'Aroma: 바나나, 배, 바닐라; Taste: 계피, 무화과, 메이플 시럽, 오크; Finish: 강렬한, 스파이시, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('원소주 하이볼 페어', 'NULL', 1100, '호두 크래커', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('원소주 하이볼 유자', 'NULL', 1100, '매운 닭강정', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('일품진로 오크 25', '25', 12000, '훈제 연어', 'Aroma: 오크, 쌀, 향긋한; Taste: 은은한, 부드러운, 깔끔한; Finish: 긴 여운, 은은한, 매끄러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 X.P 500ml', '41', 85900, '초콜릿 디저트', 'Aroma: 오크, 블랙커런트, 복숭아; Taste: 곡물, 코코넛, 캐러멜; Finish: 오크, 부드러운, 흑설탕', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 53 청사 에디션 750ml', '53', 86000, '호두 크래커', 'Aroma: 꽃, 은은한, 쌀 고유의 단맛; Taste: 몰트, 풍부한, 부드러운; Finish: 과일, 깔끔한, 강렬한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 41 500ml', '41', 29900, '돼지 바비큐', 'Aroma: 쌀, 꽃, 구수한; Taste: 곡물, 균형 잡힌, 원숙한; Finish: 부드러운, 섬세한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('일품진로 오크 43', '43', 23000, '감자튀김', 'Aroma: 오크, 쌀, 향긋한; Taste: 깊은, 부드러운, 깔끔한; Finish: 은은한, 긴 여운, 나무', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 X.P 500ml', '41', 135000, '훈제 연어', 'Aroma: 오크, 블랙커런트, 복숭아; Taste: 곡물, 코코넛, 캐러멜; Finish: 오크, 부드러운, 흑설탕', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 25 750ml', '25', 20500, '양고기 스튜', 'Aroma: 달콤한, 쌀, 은은한; Taste: 곡물, 과일, 깔끔한; Finish: 부드러운, 우아한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 41 나혼렙 에디션', '41', 40900, '그릴드 스테이크', 'Aroma: 쌀, 꽃, 곡물; Taste: 구수한, 균형 잡힌, 원숙한; Finish: 부드러운, 섬세한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('사락 33%', '33', 18800, '훈제 연어', 'Aroma: 깊은, 보리, 향긋한; Taste: 진한, 부드러운, 고소한; Finish: 깊은, 깔끔한, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 17 375ml', '17', 12900, '크림치즈 베이글', 'Aroma: 달콤한, 쌀, 은은한; Taste: 곡물, 과일, 깔끔한; Finish: 부드러운, 순수한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 25 375ml', '25', 14500, '크림치즈 베이글', 'Aroma: 달콤한, 쌀, 은은한; Taste: 곡물, 과일, 깔끔한; Finish: 부드러운, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('일품진로', '25', 13000, '치즈 플래터', 'Aroma: 쌀, 깔끔한, 달콤한; Taste: 쌀, 담백한, 고소한, 부드러운; Finish: 부드러운, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('한라산 1950', '25', 12000, '크림치즈 베이글', 'Aroma: 가벼운 오크, 쌀, 은은한; Taste: 쌀 고유의 단맛, 깊은, 깨끗한; Finish: 부드러운, 풍부한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('한라산 1950', '25', 10200, '감자튀김', 'Aroma: 가벼운 오크, 쌀, 은은한; Taste: 쌀 고유의 단맛, 깊은, 깨끗한; Finish: 부드러운, 풍부한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('일품진로 오크 43', '43', 21600, '불고기', 'Aroma: 오크, 쌀, 향긋한; Taste: 깊은, 부드러운, 깔끔한; Finish: 은은한, 긴 여운, 나무', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 25 750ml', '25', 19500, '호두 크래커', 'Aroma: 달콤한, 쌀, 은은한; Taste: 곡물, 과일, 깔끔한; Finish: 부드러운, 우아한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('다이야메 900ml 25%', '25', 47800, '말린 과일', 'Aroma: 화려한, 리치, 장미, 사과, 배; Taste: 부드러운, 달콤한, 과일; Finish: 라임, 오렌지 껍질, 상쾌한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 53 750ml', '53', 75000, '돼지 바비큐', 'Aroma: 꽃, 쌀, 은은한; Taste: 몰트, 풍부한, 쌀 고유의 단맛; Finish: 과일, 깔끔한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('삼해 소주', '45', 38000, '훈제 연어', 'Aroma: 고소한, 쌀, 누룩; Taste: 쌀 고유의 단맛, 곡물, 풍부한; Finish: 부드러운, 깔끔한, 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('명인 안동소주 35%', '35', 8000, '블루치즈', 'Aroma: 부드러운, 은은한, 깊은; Taste: 맑은, 달콤한, 쌉쌀한; Finish: 감칠맛, 부드러운, 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('명인 안동소주 22%', '22', 5500, '감자튀김', 'Aroma: 부드러운, 은은한, 깊은; Taste: 맑은, 달콤한, 쌉쌀한; Finish: 감칠맛, 부드러운, 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 53 750ml', '53', 78000, '불고기', 'Aroma: 꽃, 쌀, 은은한; Taste: 몰트, 풍부한, 쌀 고유의 단맛; Finish: 과일, 깔끔한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 17 750ml', '17', 20000, '블루치즈', 'Aroma: 달콤한, 쌀, 은은한; Taste: 곡물, 과일, 깔끔한; Finish: 부드러운, 순수한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 41 375ml', '41', 27000, '양고기 스튜', 'Aroma: 꽃, 쌀; Taste: 구수한, 곡물, 원숙한, 균형 잡힌; Finish: 부드러운, 섬세한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('안동소주 양반탈 800ml', '45', 43000, '호두 크래커', 'Aroma: 쌀, 은은한, 달콤한; Taste: 부드러운, 감칠맛, 쌀 고유의 단맛; Finish: 깨끗한, 알코올감, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('비잔 클리어', '25', 24800, '고르곤졸라 피자', 'Aroma: 쌀, 부드러운, 스파이시; Taste: 쌀, 부드러운, 은은한, 누룽지; Finish: 깔끔한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 25 나혼렙 에디션', '25', 19900, '말린 과일', 'Aroma: 달콤한, 쌀, 은은한; Taste: 곡물, 과일, 깔끔한; Finish: 부드러운, 우아한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('가무치 소주 43%', '43', 38000, '불고기', 'Aroma: 신선한, 은은한, 과일; Taste: 묵직한, 쌀 고유의 단맛, 곡물; Finish: 달콤한, 부드러운, 오일리', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('동해 소주 22%', '22', 7000, '매운 닭강정', 'Aroma: 쌀, 향기로운, 은은한; Taste: 청량감, 미네랄리티, 쌀 고유의 단맛; Finish: 깔끔한, 부드러운, 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('명인 박재서 안동소주 호리병 800ml', '45', 36500, '돼지 바비큐', 'Aroma: 쌀, 은은한; Taste: 부드러운, 은은한, 감칠맛, 쌀 고유의 단맛; Finish: 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 53 500ml', '53', 47900, '불고기', 'Aroma: 꽃, 은은한, 쌀; Taste: 풍부한, 몰트; Finish: 과일, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('고소리술 40%', '375', 28800, '훈제 연어', 'Aroma: 신선한, 꽃, 곡물; Taste: 달콤한, 감칠맛; Finish: 강렬한, 복합적인, 스파이시', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('허벅술', '35', 31500, '초콜릿 디저트', 'Aroma: 그윽한, 담백한, 쌀; Taste: 강렬한, 은은한, 달콤한; Finish: 부드러운, 산뜻한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('요카이치 이모', '25', 37700, '매운 닭강정', 'Aroma: 고구마, 달콤한, 향기로운; Taste: 감칠맛, 깊은, 복합적인; Finish: 달콤한, 풍부한, 균형 잡힌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('독도 제로 슈거 375ml', 'NULL', 4500, '호두 크래커', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('가무치 소주 25%', '25', 18000, '초콜릿 디저트', 'Aroma: 꽃, 배, 쌀; Taste: 은은한, 달콤한, 곡물; Finish: 깔끔한, 고소한, 바닐라', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 53 청사 에디션 750ml', '53', 75000, '그릴드 스테이크', 'Aroma: 꽃, 은은한, 쌀 고유의 단맛; Taste: 몰트, 풍부한, 부드러운; Finish: 과일, 깔끔한, 강렬한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 41 750ml', '41', 44800, '크림치즈 베이글', 'Aroma: 쌀, 꽃; Taste: 곡물, 구수한, 균형 잡힌, 원숙한; Finish: 부드러운, 섬세한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('코즈루 쿠로', '24~25', 41700, '고르곤졸라 피자', 'Aroma: 고구마, 달콤한; Taste: 감칠맛, 달콤한, 깊은; Finish: 고구마, 부드러운, 은은한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('토끼소주 골드 750ml', '46', 69900, '블루치즈', 'Aroma: 바닐라, 캐러멜, 오크; Taste: 다크 체리, 다크 초콜릿; Finish: 구운 견과류, 유칼립투스', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('려 고구마 증류 소주 25%', '25', 21900, '말린 과일', 'Aroma: 달콤한, 고구마, 풋사과, 풀; Taste: 달콤한, 볼륨감, 감칠맛; Finish: 깔끔한, 부드러운, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('구로 기리시마 900ml', '25', 47000, '매운 닭강정', 'Aroma: 과일, 향긋한, 은은한; Taste: 부드러운, 고구마, 섬세한; Finish: 신선한, 깔끔한, 감칠맛', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('사락 33%', '33', 28000, '블루치즈', 'Aroma: 깊은, 보리, 향긋한; Taste: 진한, 부드러운, 고소한; Finish: 깊은, 깔끔한, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('키 소주 38%', '38', 35000, '그릴드 스테이크', 'Aroma: 우아한, 은은한, 플로럴; Taste: 달콤한, 부드러운, 감칠맛, 곡물; Finish: 개운한, 깔끔한, 시원한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('이이치코 실루엣', '25', 44000, '감자튀김', 'Aroma: 깊은, 그윽한, 가벼운; Taste: 보리, 향긋한, 균형 잡힌; Finish: 섬세한, 과일, 풍성한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('잔파 블랙 아와모리', '30', 31300, '호두 크래커', 'Aroma: 산뜻한, 누룩, 과일, 레몬; Taste: 진한, 산미; Finish: 부드러운, 은은한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('담솔 500ml', '40', 27800, '초콜릿 디저트', 'Aroma: 소나무, 향긋한, 시원한; Taste: 솔잎, 부드러운, 알싸한; Finish: 진한, 깔끔한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화요 X.P 750ml', '41', 300000, '불고기', 'Aroma: 풍부한, 오크; Taste: 열대 과일, 은은한, 곡물; Finish: 오크, 부드러운, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('일품진로 오크 25', '25', 15000, '감자튀김', 'Aroma: 오크, 쌀, 향긋한; Taste: 은은한, 부드러운, 깔끔한; Finish: 긴 여운, 매끄러운, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('세키토바 720ml', '25', 59000, '매운 닭강정', 'Aroma: 깨끗한, 상쾌한, 과일; Taste: 담백한, 부드러운, 고소한; Finish: 섬세한, 은은한, 고구마', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('려 고구마 증류 소주 40%', '40', 39900, '훈제 연어', 'Aroma: 풋사과, 달콤한, 고구마; Taste: 볼륨감, 진한, 감칠맛; Finish: 깔끔한, 부드러운, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('황금보리 17%', '17', 8100, '초콜릿 디저트', 'Aroma: 부드러운, 보리, 청량한, 구수한; Taste: 시원한, 누룩, 산뜻한; Finish: 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('한주 35% 360ml', '35', 13400, '고르곤졸라 피자', 'Aroma: 그윽한, 누룩, 쌀; Taste: 맑은, 부드러운, 밀; Finish: 깔끔한, 묵직한, 균형 잡힌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('백년의 고독', '40', 180000, '불고기', 'Aroma: 보리, 향긋한, 오크; Taste: 곡물, 깔끔한, 위스키; Finish: 깊은, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('삼해 소주', '45', 40000, '호두 크래커', 'Aroma: 고소한, 쌀, 누룩; Taste: 쌀 고유의 단맛, 곡물, 풍부한; Finish: 부드러운, 깔끔한, 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('가무치 소주 43%', '43', 34000, '말린 과일', 'Aroma: 신선한, 은은한, 과일; Taste: 묵직한, 쌀 고유의 단맛, 곡물; Finish: 달콤한, 부드러운, 오일리', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('민속주 안동소주 600ml', '45', 39000, '매운 닭강정', 'Aroma: 쌀, 구수한, 누룩; Taste: 쌀 고유의 단맛, 곡물, 담백한; Finish: 부드러운, 향긋한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('일엽편주 소주 38%', '38', 98000, '감자튀김', 'Aroma: 쌀, 누룩, 과일; Taste: 풍부한, 감미로운, 고소한; Finish: 깊은, 은은한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('요카이치 무기', '25', 38000, '말린 과일', 'Aroma: 보리, 구수한; Taste: 보리, 향긋한, 깔끔한; Finish: 깨끗한, 담백한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('킨타로', '24', 59000, '트러플 파스타', 'Aroma: 피트, 위스키, 누룽지; Taste: 스모키, 보리; Finish: 부드러운, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('화심소주 군쌀 40%', '40', 39000, '트러플 파스타', 'Aroma: 누룽지, 고소한, 곡물; Taste: 쌀 고유의 단맛, 배, 녹차; Finish: 스모키, 과일, 균형 잡힌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('운암 오크 32%', '32', 12900, '그릴드 스테이크', 'Aroma: 오크, 곡물, 누룩; Taste: 산뜻한, 쌀 고유의 단맛, 누룩; Finish: 부드러운, 깔끔한, 알코올감', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('안동 진맥 소주 40% 500ml', '40', 47000, '호두 크래커', 'Aroma: 비스킷, 빵, 고소한; Taste: 밀, 참깨, 깔끔한; Finish: 온화한, 은은한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('고쿠', '25', 43800, '감자튀김', 'Aroma: 바닐라, 고구마, 가벼운 오크; Taste: 달콤한, 오크, 몰트; Finish: 부드러운, 진한 여운, 고소한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('콘노 1.8L', '25', 73400, '돼지 바비큐', 'Aroma: 화사한, 달콤한, 고구마; Taste: 부드러운, 구수한, 달콤한; Finish: 은은한, 매끄러운, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('사츠마 시라나미 1.8L', 'NULL', 55800, '훈제 연어', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아까 기리시마', '25', 65300, '그릴드 스테이크', 'Aroma: 향기로운, 군고구마, 은은한; Taste: 달콤한, 부드러운, 깔끔한; Finish: 섬세한, 긴 여운, 풍부한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글로우 EP05', '25', 53000, '매운 닭강정', 'Aroma: 머스캣, 바나나, 향긋한; Taste: 화려한, 프루티, 매끄러운; Finish: 체리, 리치, 자몽', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('비잔 클리어', '25', 23900, '말린 과일', 'Aroma: 쌀, 부드러운, 스파이시; Taste: 쌀, 은은한, 부드러운, 누룽지; Finish: 깔끔한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('텟칸 이모 25%', '25', 54700, '훈제 연어', 'Aroma: 고구마, 부드러운, 달콤한; Taste: 진한, 풍부한, 누룩; Finish: 긴 여운, 은은한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('요카이치 이모', '25', 38000, '치즈 플래터', 'Aroma: 고구마, 달콤한, 향기로운; Taste: 감칠맛, 깊은, 복합적인; Finish: 달콤한, 풍부한, 균형 잡힌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('세키토바 1.8L', '25', 149000, '양고기 스튜', 'Aroma: 깨끗한, 상쾌한, 과일; Taste: 담백한, 부드러운, 고소한; Finish: 섬세한, 은은한, 고구마', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('하쿠타케 쿠마몬 900ml', '25', 35000, '말린 과일', 'Aroma: 은은한, 쌀, 고소한; Taste: 깨끗한, 선명한, 가벼운; Finish: 산뜻한, 부드러운, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('잔파 화이트 아와모리', '25', 45900, '호두 크래커', 'Aroma: 신선한, 청사과; Taste: 시트러스, 상쾌한; Finish: 산미, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('독산 53%', '53', 35000, '돼지 바비큐', 'Aroma: 쌀, 곡물, 고소한, 향긋한; Taste: 깔끔한, 풍부한, 담백한; Finish: 부드러운, 섬세한, 은은한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('키위 술', '40', 39300, '양고기 스튜', 'Aroma: 키위, 과일, 새콤한; Taste: 상큼한, 산미, 달콤한; Finish: 부드러운, 깔끔한, 향긋한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('명인 박재서 안동소주 호리병 800ml', '45', 38000, '고르곤졸라 피자', 'Aroma: 쌀, 은은한; Taste: 부드러운, 은은한, 감칠맛, 쌀 고유의 단맛; Finish: 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('빛 24 375ml', 'NULL', 6900, '크림치즈 베이글', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('문배술 호리병 400ml', '40', 29200, '초콜릿 디저트', 'Aroma: 과일, 문배, 구수한; Taste: 달콤한, 향기로운, 풍부한; Finish: 깔끔한, 시원한, 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('느린 마을 소주 21%', '21', 13500, '치즈 플래터', 'Aroma: 쌀, 은은한, 향긋한; Taste: 곡물, 쌀 고유의 단맛, 누룩; Finish: 부드러운, 쌉쌀한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('진로 1924 헤리티지', '30', 125000, '크림치즈 베이글', 'Aroma: 쌀, 풍부한; Taste: 달콤한, 부드러운; Finish: 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('토끼소주 블랙 750ml', '40', 63000, '말린 과일', 'Aroma: 바나나, 배, 바닐라; Taste: 계피, 무화과, 메이플 시럽, 오크; Finish: 강렬한, 스파이시, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('한라산 1950', '25', 15000, '크림치즈 베이글', 'Aroma: 가벼운 오크, 쌀, 은은한; Taste: 쌀 고유의 단맛, 깊은, 깨끗한; Finish: 부드러운, 풍부한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('동해 소주 22%', '22', 10500, '매운 닭강정', 'Aroma: 쌀, 향기로운, 은은한; Taste: 청량감, 미네랄리티, 쌀 고유의 단맛; Finish: 깔끔한, 부드러운, 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('쿠보타 준마이 다이긴죠', '15', 42900, '양고기 스튜', 'Aroma: 배, 사과, 멜론, 화려한; Taste: 꽃, 달콤한, 산뜻한, 균형 잡힌; Finish: 은은한, 서양 배, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('고래 사케 720ml', '15', 8500, '양고기 스튜', 'Aroma: 곡물, 산뜻한, 은은한; Taste: 쌀, 쌀 고유의 단맛, 부드러운; Finish: 깔끔한, 신선한, 온화한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('준마이 북극곰의 눈물', '14.5', 19900, '크림치즈 베이글', 'Aroma: 쌀, 은은한, 순수한; Taste: 산뜻한, 쌀 고유의 단맛, 담백한; Finish: 깔끔한, 부드러운, 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('닷사이 준마이 다이긴죠 39', '15~16', 61000, '크림치즈 베이글', 'Aroma: 꽃, 과일, 은은한; Taste: 풍부한, 과일, 부드러운; Finish: 깔끔한, 풍성한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('하나 기자쿠라 준마이 긴죠', '12', 17600, '훈제 연어', 'Aroma: 꽃, 과일; Taste: 과일, 달콤한; Finish: 부드러운, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('츠루우메 유즈', '7', 52000, '훈제 연어', 'Aroma: 유자, 향긋한, 산뜻한; Taste: 달콤한, 상큼한, 시트러스; Finish: 감칠맛, 부드러운, 싱그러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('닷사이 준마이 다이긴죠 39', '15~16', 59000, '크림치즈 베이글', 'Aroma: 꽃, 과일, 은은한; Taste: 풍부한, 과일, 부드러운; Finish: 깔끔한, 풍성한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('닷사이 준마이 다이긴죠 45', '15~16', 46200, '감자튀김', 'Aroma: 복숭아, 은은한, 상큼한; Taste: 꿀, 섬세한, 화려한; Finish: 깨끗한, 달콤한, 시트러스', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('닷사이 준마이 다이긴죠 23', '15~16', 158000, '호두 크래커', 'Aroma: 온화한, 꽃, 꿀, 은은한; Taste: 경쾌한, 감칠맛, 섬세한; Finish: 부드러운, 시원한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('닷사이 준마이 다이긴죠 45', '15~16', 45000, '그릴드 스테이크', 'Aroma: 복숭아, 은은한, 상큼한; Taste: 꿀, 섬세한, 화려한; Finish: 깨끗한, 달콤한, 시트러스', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('월계관 준마이 750', '15.6', 16200, '양고기 스튜', 'Aroma: 향긋한, 쌀, 순수한; Taste: 쌀 고유의 단맛, 과일; Finish: 깨끗한, 깔끔한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('쿠보타 준마이 다이긴죠', '15', 48700, '치즈 플래터', 'Aroma: 배, 사과, 멜론, 화려한; Taste: 꽃, 달콤한, 산뜻한, 균형 잡힌; Finish: 은은한, 서양 배, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('준마이 북극곰의 눈물', '14.5', 20000, '트러플 파스타', 'Aroma: 쌀, 은은한, 순수한; Taste: 산뜻한, 쌀 고유의 단맛, 담백한; Finish: 깔끔한, 부드러운, 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('라쿠엔 유즈슈 900ml', '8.5', 19500, '트러플 파스타', 'Aroma: 향긋한, 유자, 신선한; Taste: 달콤한, 시트러스, 산뜻한; Finish: 가벼운, 상쾌한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카오리 하나야구 준마이', '15.5', 17000, '그릴드 스테이크', 'Aroma: 향긋한, 과일; Taste: 산미, 달콤한; Finish: 균형 잡힌, 묵직한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('스바루 나마죠조', '14.5', 16500, '크림치즈 베이글', 'Aroma: 신선한, 화사한, 향긋한; Taste: 과일, 화려한, 부드러운, 곡물; Finish: 깔끔한, 풍부한, 균형 잡힌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('월계관 준마이 다이긴죠', '16.5~17', 39500, '훈제 연어', 'Aroma: 산뜻한, 시트러스; Taste: 감칠맛, 달콤한, 부드러운; Finish: 쌀 고유의 단맛, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('송죽매 클래식 준마이 1.5L', '15', 23600, '양고기 스튜', 'Aroma: 은은한, 풋사과, 과일, 멜론; Taste: 감칠맛, 곡물; Finish: 부드러운, 은은한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('간바레 오또상 팩', '14.5', 18500, '불고기', 'Aroma: 사과; Taste: 달콤한, 새콤한; Finish: 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('하쿠시카 준마이 긴죠 팩', '14.5', 14900, '크림치즈 베이글', 'Aroma: 산뜻한; Taste: 달콤한; Finish: 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('송죽매 준마이 750', '15', 12500, '훈제 연어', 'Aroma: 풋사과, 멜론, 은은한, 과일; Taste: 감칠맛, 곡물; Finish: 상쾌한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('다이야메 900ml 25%', '25', 47800, '그릴드 스테이크', 'Aroma: 화려한, 리치, 장미, 사과, 배; Taste: 부드러운, 달콤한, 과일; Finish: 라임, 오렌지 껍질, 상쾌한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('월계관 준마이 750', '15.6', 18900, '호두 크래커', 'Aroma: 향긋한, 쌀, 순수한; Taste: 쌀 고유의 단맛, 과일; Finish: 깨끗한, 깔끔한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('쿠보타 만쥬', '15~15.5', 112000, '호두 크래커', 'Aroma: 과일, 부드러운, 복합적인, 멜론; Taste: 복숭아, 꿀, 토피, 후추, 견과류; Finish: 균형 잡힌, 부드러운, 실키', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('월계관 준마이 750', '15.6', 15900, '불고기', 'Aroma: 향긋한, 쌀, 순수한; Taste: 쌀 고유의 단맛, 과일; Finish: 깨끗한, 깔끔한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('신세이 다이긴죠', '15~16', 29500, '그릴드 스테이크', 'Aroma: 배, 사과, 멜론, 꽃; Taste: 감칠맛, 새콤한, 달콤한; Finish: 은은한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('준마이 북극곰의 눈물 벚꽃 에디션', '14.5', 22000, '치즈 플래터', 'Aroma: 쌀, 은은한, 순수한; Taste: 산뜻한, 쌀 고유의 단맛; Finish: 깔끔한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('킷도 준마이 다이긴죠', '15', 41900, '불고기', 'Aroma: 화사한, 열대 과일, 산뜻한; Taste: 부드러운, 달콤한, 산미; Finish: 경쾌한, 가벼운, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('쿠보타 센쥬', '15~16', 39600, '블루치즈', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('라쿠엔 유즈슈 900ml', '8.5', 19700, '크림치즈 베이글', 'Aroma: 향긋한, 유자, 신선한; Taste: 달콤한, 시트러스, 산뜻한; Finish: 가벼운, 상쾌한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('신세이 다이긴죠', '15~16', 29000, '호두 크래커', 'Aroma: 배, 사과, 멜론, 꽃; Taste: 감칠맛, 새콤한, 달콤한; Finish: 은은한, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('하쿠시카 혼죠조 팩', '15.3', 13900, '매운 닭강정', 'Aroma: 산뜻한, 향긋한, 부드러운; Taste: 미디엄 드라이, 상쾌한, 감칠맛; Finish: 가벼운, 깔끔한, 은은한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('오카네(금사케)', '13.5', 16200, '돼지 바비큐', 'Aroma: 핵과류, 화사한, 쌀; Taste: 쌀 고유의 단맛, 산미; Finish: 달콤한, 부드러운, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('핫카이산 토쿠베츠 준마이', '15.5', 29100, '고르곤졸라 피자', 'Aroma: 쌀, 흰 꽃; Taste: 부드러운, 깔끔한, 달콤한; Finish: 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('라쿠 준마이 골드', '13.5', 25600, '치즈 플래터', 'Aroma: 누룩, 달콤한, 열대 과일; Taste: 고소한, 스모키, 멜론; Finish: 깔끔한, 부드러운, 깨끗한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('하나 기자쿠라 준마이 긴죠', '12', 34500, '훈제 연어', 'Aroma: 꽃, 과일; Taste: 과일, 달콤한; Finish: 부드러운, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('요카이치 이모', '25', 37700, '크림치즈 베이글', 'Aroma: 고구마, 달콤한, 향기로운; Taste: 감칠맛, 깊은, 복합적인; Finish: 달콤한, 풍부한, 균형 잡힌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('쿠보타 만쥬', '15~15.5', 109000, '양고기 스튜', 'Aroma: 과일, 부드러운, 복합적인, 멜론; Taste: 복숭아, 꿀, 토피, 후추, 견과류; Finish: 균형 잡힌, 부드러운, 실키', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('쿠보타 센쥬', '15~16', 38300, '고르곤졸라 피자', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 디스틸러리 셀렉트', '40', 110000, '그릴드 스테이크', 'Aroma: 열대 과일, 토피, 오크, 바닐라; Taste: 열대 과일, 달콤한, 토피, 부드러운; Finish: 산뜻한, 바닐라', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 솔리스트 올로로쏘 셰리 캐스크 CS', '50~59.5', 363000, '고르곤졸라 피자', 'Aroma: 마지팬, 견과류, 바닐라; Taste: 달콤한, 말린 과일, 풍부한; Finish: 복합적인, 견과류, 향신료', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 클래식 싱글몰트', '40', 206000, '블루치즈', 'Aroma: 꽃, 열대 과일, 배, 바닐라, 우아한; Taste: 망고, 코코넛, 초콜릿, 달콤한; Finish: 시트러스, 감귤, 스파이시, 복합적인, 따뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 솔리스트 포트 CS', '54~60', 332000, '불고기', 'Aroma: 과일, 견과류, 시트러스; Taste: 과일, 초콜릿; Finish: 레몬, 패션프루트', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 솔리스트 비노 바리끄 싱글 캐스크 CS', '54~59', 370000, '고르곤졸라 피자', 'Aroma: 키위, 멜론, 망고, 달콤한, 셰리; Taste: 열대 과일, 감귤, 시트러스, 후추; Finish: 복합적인, 부드러운, 풍부한, 섬세한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 솔리스트 브랜디 CS', '50~60', 299000, '훈제 연어', 'Aroma: 복숭아, 패션프루트, 딸기, 망고; Taste: 바닐라, 토피, 향신료, 꿀, 오일리; Finish: 긴 여운, 복합적인, 달콤한, 리치', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 솔리스트 포트 CS', '54~60', 360000, '트러플 파스타', 'Aroma: 과일, 견과류, 시트러스; Taste: 과일, 초콜릿; Finish: 레몬, 패션프루트', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 솔리스트 올로로쏘 셰리 캐스크 CS', '50~59.5', 346700, '트러플 파스타', 'Aroma: 마지팬, 견과류, 바닐라; Taste: 달콤한, 말린 과일, 풍부한; Finish: 복합적인, 견과류, 향신료', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 트리플 셰리 캐스크', '40', 209500, '양고기 스튜', 'Aroma: 포도, 초콜릿, 토피, 베리; Taste: 셰리, 캐러멜, 꿀, 말린 과일; Finish: 로즈마리, 스파이시, 열대 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 솔리스트 피노 셰리 CS 1L', '50~59.9', 580000, '고르곤졸라 피자', 'Aroma: 파인애플, 계피, 사과 파이, 짭짤한, 홍차, 꿀; Taste: 살구, 건포도, 자두, 당근, 모카, 팝콘; Finish: 오렌지 껍질, 체리, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 솔리스트 올로로쏘 셰리 캐스크 CS 1L', '50~59.5', 369000, '매운 닭강정', 'Aroma: 마지팬, 견과류, 바닐라; Taste: 달콤한, 말린 과일, 풍부한; Finish: 복합적인, 견과류, 향신료', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('카발란 포디움', '46', 209000, '양고기 스튜', 'Aroma: 우아한, 플로럴, 열대 과일, 바닐라, 코코넛; Taste: 망고, 청사과, 꿀, 체리, 포도, 화이트 페퍼; Finish: 긴 여운, 복합적인, 부드러운, 벨벳', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('탈리스커 10년', '45.8', 76800, '치즈 플래터', 'Aroma: 강한 피트, 바다 내음, 굴, 감귤; Taste: 과일, 스모키, 몰트, 후추; Finish: 긴 여운, 달콤한, 스파이시', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('탈리스커 8년 SR 2024', '58.7', 129800, '매운 닭강정', 'Aroma: 바다 내음, 굴, 이끼, 젖은 흙, 과일, 바닐라; Taste: 후추, 향신료, 사과, 배, 소금; Finish: 긴 여운, 스파이시, 상쾌한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('탈리스커 다크스톰', '45.8', 165000, '돼지 바비큐', 'Aroma: 피트, 스모키, 바다 내음, 짭짤한, 사과 조림; Taste: 신선한, 감초; Finish: 스모키, 강렬한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('탈리스커 더 디스틸러스 에디션 2022', '45.8', 177000, '매운 닭강정', 'Aroma: 깔끔한, 피트, 시트러스, 열대 과일; Taste: 과일, 달콤한, 피트, 후추, 깊은; Finish: 긴 여운, 달콤한, 코코아, 바닐라, 흙내음, 토탄', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('탈리스커 18년', '45.8', 438000, '감자튀김', 'Aroma: 스모키, 신선한, 오크, 풋사과, 피트; Taste: 생강, 오크, 커피, 향신료, 후추; Finish: 긴 여운, 스파이시, 오크, 피트, 후추', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아드벡 10년', '46', 92000, '훈제 연어', 'Aroma: 스모키, 다크 초콜릿, 레몬, 라임, 흑후추; Taste: 피트, 구운 파인애플, 배, 아몬드, 토피; Finish: 허브, 배, 소나무, 바닐라, 계피, 헤이즐넛', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아드벡 우거다일', '54.2', 150000, '그릴드 스테이크', 'Aroma: 호두 기름, 당밀, 토피, 초콜릿, 건포도, 모카 에스프레소; Taste: 스모키, 스파이스; Finish: 모카, 스모키, 진한, 긴 여운, 건포도', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('빅 피트', '46', 60000, '초콜릿 디저트', 'Aroma: 몰트, 짭짤한, 달콤한; Taste: 피트, 달콤한, 스모키; Finish: 짭짤한, 스모키, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 라피트 로칠드 2017', '13~14', 1590000, '호두 크래커', 'Aroma: 오크, 담배, 가죽, 스모키; Taste: 블랙베리, 후추, 라벤더; Finish: 풍부한, 부드러운, 강렬한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 데스클랑, 위스퍼링 엔젤', '12~13', 27400, '양고기 스튜', 'Aroma: 체리, 자스민, 살구; Taste: 복숭아, 체리, 미네랄리티, 멜론; Finish: 긴 여운, 상쾌한, 산딸기', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 몽페라 화이트', '12.5', 27500, '훈제 연어', 'Aroma: 청사과, 파인애플, 자몽, 흰 꽃, 상쾌한; Taste: 구운 아몬드, 견과류, 고소한, 균형 잡힌; Finish: 우아한, 신선한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 딸보 2021', '13  ~ 14.1', 123800, '말린 과일', 'Aroma: 오크, 향신료, 타바코, 감초, 민트; Taste: 산딸기, 블랙커런트, 블랙베리, 가죽; Finish: 균형 잡힌, 묵직한, 타닌, 스모키', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 생 미셸, 콜럼비아 밸리 리슬링', '11~12', 27000, '호두 크래커', 'Aroma: 사과, 미네랄리티, 배; Taste: 상쾌한; Finish: 균형 잡힌, 달콤한, 마시기 쉬운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('벡스 리슬링', '11.5', 12800, '그릴드 스테이크', 'Aroma: 오렌지 꽃, 라임, 시트러스; Taste: 복숭아, 청사과, 살구; Finish: 깔끔한, 감귤, 미네랄리티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파이크, 트레디셔날 리슬링', '11~12', 38000, '감자튀김', 'Aroma: 시트러스, 청사과, 꿀; Taste: 레몬, 라임, 미네랄리티; Finish: 복숭아, 살구, 젖은 돌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('릴랙스 리슬링', '9', 26000, '크림치즈 베이글', 'Aroma: 사과, 서양 배, 복숭아; Taste: 시트러스, 레몬, 포도; Finish: 꿀, 미네랄리티, 젖은 돌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('미스티힐 비달 아이스 와인', '11', 27000, '트러플 파스타', 'Aroma: 열대 과일, 멜론; Taste: 꿀, 복숭아, 살구; Finish: 부드러운, 무화과, 커피, 바닐라', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('트웬티 비스 비달 아이스 와인', '10~12', 29900, '양고기 스튜', 'Aroma: 복숭아, 벌꿀, 신선한, 살구; Taste: 진한, 달콤한, 생동감, 산미; Finish: 긴 여운, 우아한, 시트러스', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('필리터리 프로즌 툰드라 비달 아이스 와인', '10~12', 38000, '말린 과일', 'Aroma: 꿀, 배, 살구, 오렌지 껍질, 자몽; Taste: 복숭아, 말린 과일, 파인애플; Finish: 긴 여운, 달콤한, 열대 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('스위트 듀 까베르네 프랑 아이스와인', '11', 22900, '트러플 파스타', 'Aroma: 시트러스, 감귤류, 포도; Taste: 열대 과일, 망고, 포도; Finish: 꿀, 달콤한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('스위트 듀 비달 아이스와인', '10~12', 22900, '치즈 플래터', 'Aroma: 열대 과일, 블랙베리, 시트러스; Taste: 말린 과일, 부드러운, 달콤한; Finish: 꿀, 파인애플, 자두', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('스위트 듀 까베르네 프랑 아이스와인', '11', 25000, '블루치즈', 'Aroma: 시트러스, 감귤류, 포도; Taste: 열대 과일, 망고, 포도; Finish: 꿀, 달콤한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('도미니오 데 라 베가, 디 엔드 아이스 와인', '13~14', 37800, '초콜릿 디저트', 'Aroma: 산뜻한, 파인애플, 시트러스, 패션프루트; Taste: 흰 꽃, 부드러운, 달콤한, 신선한, 산미; Finish: 견과류, 가벼운, 시트러스, 열대 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('시즌스 비달 아이스 와인', '11.5', 39000, '매운 닭강정', 'Aroma: 복숭아, 살구; Taste: 감귤, 시트러스, 열대 과일; Finish: 꿀, 리치, 복숭아', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아스코니 리슬링 아이스와인', '9.8', 34000, '치즈 플래터', 'Aroma: 복숭아, 감귤류, 레몬 제스트, 살구, 흰 꽃; Taste: 과일, 달콤한; Finish: 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('매그노타, 까베르네 프랑 아이스 와인', '9.5', 90000, '트러플 파스타', 'Aroma: 딸기, 라즈베리, 달콤한; Taste: 과일 잼, 블랙베리, 베리류; Finish: 꿀, 발사믹, 진한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('라다치니 아이스 와인', '11~13', 42000, '트러플 파스타', 'Aroma: 열대 과일, 살구, 복숭아, 멜론, 모과 잼; Taste: 농축된, 꿀, 균형 잡힌; Finish: 신선한, 산미, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('필리터리 아티장 비달 아이스와인', '11~12', 37000, '고르곤졸라 피자', 'Aroma: 복숭아, 꽃, 살구, 오렌지; Taste: 꿀, 리치, 복숭아, 파인애플; Finish: 사과, 배, 아카시아', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아스코니 무스캇 아이스 와인 레드 라벨', '10~11', 36000, '매운 닭강정', 'Aroma: 복숭아, 시트러스; Taste: 열대 과일, 망고, 살구 잼; Finish: 미네랄리티, 달콤한, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아스코니 무스캇 아이스 와인 레드 라벨', '10~11', 36000, '훈제 연어', 'Aroma: 복숭아, 시트러스; Taste: 열대 과일, 망고, 살구 잼; Finish: 미네랄리티, 달콤한, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('스위트 듀 비달 아이스와인', '10~12', 30000, '돼지 바비큐', 'Aroma: 열대 과일, 블랙베리, 시트러스; Taste: 말린 과일, 부드러운, 달콤한; Finish: 꿀, 파인애플, 자두', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('누보몽드 비달 아이스 와인', '11', 36000, '크림치즈 베이글', 'Aroma: 레몬, 배, 사과; Taste: 달콤한, 꿀, 모과, 무화과, 토피, 사과; Finish: 오렌지 껍질, 파인애플', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('더 글렌그란트 60년', '52.8', 38000000, '불고기', 'Aroma: 오렌지, 풍부한, 과일, 견과류, 시가; Taste: 풍부한, 과일, 다크 초콜릿, 토피; Finish: 무화과, 대추, 감초, 긴 여운, 스모키', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('노주노교 교령 60년', '52', 150000, '고르곤졸라 피자', 'Aroma: 스파이시, 향신료, 허브; Taste: 곡물, 달콤한, 허브; Finish: 긴 여운, 복합적인, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('달위니 15년', '43', 95000, '그릴드 스테이크', 'Aroma: 부드러운, 바닐라, 꽃; Taste: 헤더 꿀, 감미로운, 보리빵; Finish: 긴 여운, 감귤류, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('달위니 30년 2019', '54.7', 1500000, '트러플 파스타', 'Aroma: 꽃, 나무, 담배, 달콤한; Taste: 스파이시, 후추, 허브, 가죽; Finish: 긴 여운, 스파이시, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 포트우드 21년', '40', 599000, '호두 크래커', 'Aroma: 과일, 건포도, 견과류; Taste: 과일, 벌꿀, 스파이스; Finish: 긴 여운, 고소한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 싱글배럴 21년', '47.8', 945000, '블루치즈', 'Aroma: 바닐라, 시나몬, 꿀, 메이플 시럽, 브리오슈, 플로럴; Taste: 오크, 호두, 메이플 시럽, 당밀, 토피; Finish: 오크, 꿀, 풍부한, 바닐라', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 30년 레어 메리지', '44.2', 4999000, '감자튀김', 'Aroma: 꿀, 오크, 오렌지 껍질; Taste: 다크 초콜릿, 자두, 설탕에 절인 배; Finish: 스파이스, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 25년 레어 메리지', '48', 1245900, '그릴드 스테이크', 'Aroma: 오크, 꽃, 꿀, 구운 마시멜로; Taste: 서양 배, 바닐라, 시트러스, 감귤; Finish: 생강, 향신료, 시나몬, 사과 파이', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('발베니 더블우드 25년', '43', 2500000, '초콜릿 디저트', 'Aroma: 가죽, 스파이시, 달콤한; Taste: 향신료, 달콤한, 설탕에 절인 오렌지, 꿀, 말린 과일; Finish: 스파이스, 프루티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('탈리스커 25년', '45.8', 589000, '트러플 파스타', 'Aroma: 바나나, 사과, 스파이시, 오크, 짭짤한; Taste: 강렬한, 달콤한, 스모키, 짭짤한, 후추; Finish: 긴 여운, 따뜻한, 복숭아, 장미, 캐러멜, 피트', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파논 토카이 아수 5 푸토뇨스', '10', 56900, '초콜릿 디저트', 'Aroma: 꿀, 꽃, 라임, 오크, 견과류; Taste: 배, 살구, 오렌지, 사과, 멜론; Finish: 달콤한, 부드러운, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파논 토카이 아수 6 푸토뇨스', '9~10', 79300, '매운 닭강정', 'Aroma: 무화과, 대추, 설탕에 절인 오렌지, 아몬드; Taste: 복숭아, 살구, 청사과, 건포도, 오렌지, 꿀; Finish: 산뜻한, 긴 여운, 달콤한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('패트리셔스 카틴카 레이트 하베스트 토카이', '12~13', 45000, '감자튀김', 'Aroma: 벌꿀, 살구, 사과; Taste: 복숭아, 진저, 서양 배, 시트러스; Finish: 긴 여운, 스타프루트, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 데레즐라 토카이 푸르민트 드라이', '11', 19900, '훈제 연어', 'Aroma: 풋사과, 시트러스, 감귤; Taste: 미네랄리티, 사과, 살구; Finish: 산뜻한, 라임', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('그랜드 토카이 이수 5 푸토뇨스', '9~11', 105000, '불고기', 'Aroma: 꿀, 살구, 마멀레이드; Taste: 시트러스, 복숭아, 서양 배, 오렌지 마멀레이드; Finish: 스모키, 마멀레이드, 프루티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파논 토카이 사모로드니', '10', 33500, '그릴드 스테이크', 'Aroma: 헤이즐넛, 열대 과일, 리치, 망고; Taste: 배, 아몬드, 말린 살구, 청사과; Finish: 달콤한, 산뜻한, 오렌지', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 데레즐라 토카이 아수 5 푸토뇨스', '12.5', 62000, '말린 과일', 'Aroma: 오렌지, 꽃, 꿀, 시트러스, 감귤; Taste: 달콤한, 신선한, 꿀, 라임; Finish: 살구, 파인애플, 꿀, 복숭아, 멜론', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('패트리셔스, 토카이 푸르민트', '11~13', 31900, '초콜릿 디저트', 'Aroma: 복숭아, 아몬드, 레몬 껍질; Taste: 꿀, 산미, 가벼운; Finish: 균형 잡힌, 산미, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('클래식 토카이 푸르민트 미디움 스위트', '11~13', 28000, '감자튀김', 'Aroma: 배, 시트러스, 말린 복숭아; Taste: 프루티, 허브, 산미, 복숭아; Finish: 가벼운, 미네랄리티, 꿀', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 데레즐라 토카이 아수 에센시아', '9.5', 165000, '돼지 바비큐', 'Aroma: 꿀, 복숭아, 말린 살구, 열대 과일, 오렌지 껍질, 스모키; Taste: 긴 여운, 꿀, 달콤한, 산뜻한, 진한, 미네랄리티; Finish: 긴 여운, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('그랜드 토카이, 클래식 토카이 하르쉬레벨루', '12', 35000, '블루치즈', 'Aroma: 백도, 꿀, 꽃; Taste: 시트러스, 살구, 레몬; Finish: 향신료, 생강, 미네랄리티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('로얄 토카이 레이트 하비스트', '10~12', 50000, '트러플 파스타', 'Aroma: 모과, 배, 진저 브레드, 민트; Taste: 풍성한, 우아한, 산미; Finish: 긴 여운, 균형 잡힌, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('그랜드 토카이, 클래식 토카이 아라니푸르트 뀌베', '10', 24000, '그릴드 스테이크', 'Aroma: 감귤, 민트, 꿀; Taste: 시트러스, 파인애플, 자몽; Finish: 서양 배, 사과, 장미꽃', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 데레즐라 토카이 아수 5 푸토뇨스 250ml', '12.5', 34500, '초콜릿 디저트', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('폴레츠키 빈 크리스마스 토카이', '12', 40000, '훈제 연어', 'Aroma: 복숭아, 살구, 향긋한; Taste: 달콤한, 설탕에 절인 오렌지, 벌꿀; Finish: 긴 여운, 시트러스, 농밀한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('바라 토카이 아수 5 푸토뇨스', '13', 59000, '크림치즈 베이글', 'Aroma: 복숭아, 오렌지 꽃, 말린 살구; Taste: 벌꿀, 모과, 살구, 라임, 밀랍; Finish: 달콤한, 파인애플, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('가무치 낫포세일 토카이 캐스크 스웨이드 파우치 패키지', '59.4', 97000, '치즈 플래터', 'Aroma: 살구, 머스캣, 꿀, 리치, 마카다미아, 헤이즐넛; Taste: 복숭아 조림, 밀크 초콜릿, 리치, 산미, 바닐라; Finish: 허브, 오크, 구운 견과류, 산뜻한, 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('부다니 토카이 아수 5 푸토뇨스', '11~12', 59000, '크림치즈 베이글', 'Aroma: 캐러멜, 건포도, 살구; Taste: 꿀, 호두, 아몬드, 담뱃잎; Finish: 긴 여운, 달콤한, 산미, 균형 잡힌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('바라 토카이 아수 6 푸토뇨스', '10', 63000, '호두 크래커', 'Aroma: 구운 사과, 열대 과일, 미묘한 향신료; Taste: 설탕에 절인 살구, 복숭아 잼, 감귤; Finish: 민트, 은은한, 벌꿀, 레몬', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('디즈노코 토카이 아수 5 푸토뇨스', '11~13', 99000, '고르곤졸라 피자', 'Aroma: 살구, 시트러스, 꿀; Taste: 달콤한, 건포도, 아몬드, 진한; Finish: 달콤한, 긴 여운, 복합적인', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('메종 오 포아 사모로드니', '11', 54000, '훈제 연어', 'Aroma: 오크, 살구, 미네랄리티, 버터; Taste: 꿀, 달콤한, 살구, 라임, 산미; Finish: 긴 여운, 균형 잡힌, 화이트 초콜릿', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('메종 오 포아 게쇠이 쉬렛(레이트 하비스트)', '12', 42000, '치즈 플래터', 'Aroma: 배, 바나나, 꿀, 흰 꽃, 청포도; Taste: 우아한, 달콤한, 균형 잡힌, 산미; Finish: 미네랄리티, 꽃, 긴 여운, 생동감', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('로얄 토카이 아수 6 푸토뇨스 골드 라벨 500ml', '10.5', 189000, '블루치즈', 'Aroma: 꿀, 생강, 버섯; Taste: 살구, 복숭아, 사과; Finish: 오렌지, 마멀레이드, 시트러스', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파논 토카이 아수 6 푸토뇨스', '9~10', 79000, '돼지 바비큐', 'Aroma: 무화과, 대추, 설탕에 절인 오렌지, 아몬드; Taste: 복숭아, 살구, 청사과, 건포도, 오렌지, 꿀; Finish: 산뜻한, 긴 여운, 달콤한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파논 토카이 아수 5 푸토뇨스', '10', 55000, '초콜릿 디저트', 'Aroma: 꿀, 꽃, 라임, 오크, 견과류; Taste: 배, 살구, 오렌지, 사과, 멜론; Finish: 달콤한, 부드러운, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('로얄 토카이 아수 5 푸토뇨스 블루 라벨', '11', 50000, '호두 크래커', 'Aroma: 살구, 향신료, 복합적인; Taste: 열대 과일, 라임, 자몽; Finish: 신선한, 복합적인, 잘 익은 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('페넬로페 토카이 캐스크 피니시 라이 배치 1', '53.5', 310000, '매운 닭강정', 'Aroma: 잘 익은 포도, 꿀, 오크, 갈색 설탕, 건포도; Taste: 산딸기, 휘핑크림, 스파이스; Finish: 꿀, 오크, 가죽, 페퍼콘, 견과류, 시트러스, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('로얄 토카이 레이트 하비스트', '10~12', 29300, '고르곤졸라 피자', 'Aroma: 모과, 배, 진저 브레드, 민트; Taste: 풍성한, 우아한, 산미; Finish: 긴 여운, 균형 잡힌, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('토카이 머스캣 루넬 드라이', '11~12', 25000, '초콜릿 디저트', 'Aroma: 풍부한, 캐모마일, 아카시아; Taste: 복숭아, 그린 애플, 리치; Finish: 미네랄리티, 짭짤한, 신선한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('바라 토카이 아수 6 푸토뇨스', '10', 52000, '크림치즈 베이글', 'Aroma: 구운 사과, 열대 과일, 미묘한 향신료; Taste: 설탕에 절인 살구, 복숭아 잼, 감귤; Finish: 민트, 은은한, 벌꿀, 레몬', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('바라 토카이 아수 5 푸토뇨스', '13', 42000, '매운 닭강정', 'Aroma: 복숭아, 오렌지 꽃, 말린 살구; Taste: 벌꿀, 모과, 살구, 라임, 밀랍; Finish: 달콤한, 파인애플, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('그랜드 토카이, 토카이 에센시아', '2', 990000, '불고기', 'Aroma: 꽃, 꿀, 미네랄리티; Taste: 시트러스, 감귤, 자몽; Finish: 복숭아, 살구, 건포도', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('그랜드 토카이, 클래식 토카이 살가무쉬코타이', '11', 25000, '고르곤졸라 피자', 'Aroma: 복숭아, 감귤, 서양 배; Taste: 시트러스, 레몬, 라임; Finish: 꿀, 젖은 돌, 미네랄리티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('그랜드 토카이, 토카이 아수 6 푸토뇨스', '9', 143000, '감자튀김', 'Aroma: 오렌지, 과일 잼, 꿀; Taste: 말린 살구, 건자두, 사과; Finish: 젖은 돌, 생강, 미네랄리티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 데레즐라 토카이 아수 6 푸토뇨스', '10.5~11.5', 113500, '감자튀김', 'Aroma: 꿀, 꽃, 레몬, 살구, 복숭아; Taste: 말린 살구, 아몬드, 배, 사과, 버터; Finish: 긴 여운, 오렌지, 마멀레이드, 미네랄리티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('헤네시 VSOP', '40', 88200, '돼지 바비큐', 'Aroma: 살구, 오크, 바닐라, 균형 잡힌; Taste: 풍부한, 과일, 정향, 시나몬; Finish: 긴 여운, 크리미, 플로럴', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('헤네시 XO', '40', 328900, '호두 크래커', 'Aroma: 잼, 설탕에 절인 과일, 오크; Taste: 스파이시, 다크 초콜릿, 후추; Finish: 바닐라, 복합적인, 따뜻한, 초콜릿', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('헨리 무니에 VSOP', '40', 59900, '치즈 플래터', 'Aroma: 말린 과일, 자두, 살구, 꽃; Taste: 견과류, 과일, 복숭아, 건포도; Finish: 부드러운, 달콤한, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('레미 마틴 VSOP', '40', 88000, '초콜릿 디저트', 'Aroma: 바닐라, 오크, 꽃, 감초; Taste: 구운 사과, 복숭아, 달콤한; Finish: 부드러운, 살구, 복합적인', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('생 레미 XO', '40', 51000, '돼지 바비큐', 'Aroma: 바닐라, 나무, 과일 잼, 진한 꿀, 잘 익은 과일; Taste: 진저 브레드, 설탕에 절인 살구, 무화과, 견과류; Finish: 우아한, 섬세한, 향긋한, 부드러운, 우디', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('쿠론니에 나폴레옹 VSOP', '40', 19000, '크림치즈 베이글', 'Aroma: 달콤한, 포도, 블랙베리; Taste: 농밀한, 농익은 포도, 검은 과일; Finish: 부드러운, 진한 여운, 진득한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('미스터 보스턴 피치 슈냅스 1L', '15', 15000, '양고기 스튜', 'Aroma: 복숭아, 시트러스, 향긋한; Taste: 달콤한, 부드러운, 시트러스; Finish: 깨끗한, 복숭아, 상큼한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('딕타도르 헤라키아 버번 1990 럼', '44', 750900, '블루치즈', 'Aroma: 오크, 오렌지 껍질, 시가, 바닐라, 정향; Taste: 다크 초콜릿, 생강, 오렌지 꽃, 자스민, 키위; Finish: 홍차, 핵과류, 블루베리, 가죽, 라벤더', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('리카 파스티스', '45', 35000, '크림치즈 베이글', 'Aroma: 허브, 팔각, 회향; Taste: 아니스, 허브, 감초; Finish: 쌉쌀한, 허브', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('로랑 퐁소 뫼르소 프리미에 크뤼 블라니 뀌베 뒤 미오조티스 2019', '14', 449000, '감자튀김', 'Aroma: 레몬, 라임, 잘 익은 과일; Taste: 풍부한, 버터, 둥근; Finish: 긴 여운, 섬세한, 미네랄리티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('까베르네 당주 샴 오죠', '10~12', 25900, '돼지 바비큐', 'Aroma: 강렬한, 라즈베리, 레드커런트; Taste: 신선한, 풍부한, 과일; Finish: 상쾌한, 산미, 깔끔한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아라스 블랑 드 블랑', '12~14', 49000, '초콜릿 디저트', 'Aroma: 허니 서클, 복숭아, 굴; Taste: 시트러스, 미네랄리티, 깨끗한; Finish: 복합적인, 균형 잡힌, 향기로운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('웨스트콕 칼바도스 캐스크 피니시', '43', 56000, '치즈 플래터', 'Aroma: 배, 아몬드, 신선한, 사과; Taste: 말린 과일, 바닐라; Finish: 사과, 배, 아몬드, 복합적인', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('크리스찬 드루앵 25년', '42', 509000, '치즈 플래터', 'Aroma: 달콤한, 사과, 미묘한; Taste: 토피, 꽃, 스모키; Finish: 사과, 달콤한, 과일, 균형 잡힌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('불라 깔바도스 VSOP', '40', 82000, '양고기 스튜', 'Aroma: 과일, 헤이즐넛, 토스트, 브리오슈; Taste: 균형 잡힌, 바닐라, 오크, 원숙한; Finish: 잘 익은 사과, 긴 여운, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('깔바도스 페르 마그루아 파인 VS', '40', 51800, '고르곤졸라 피자', 'Aroma: 신선한, 사과, 달콤한; Taste: 사과 주스, 바닐라, 설탕에 절인 사과; Finish: 산뜻한, 싱그러운, 우아한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파코리 3년', '42', 59000, '불고기', 'Aroma: 바닐라, 열대 과일, 캐러멜; Taste: 프루티, 우디, 파인애플; Finish: 달콤한, 말린 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('깔바도스 페르 마그루아 VSOP', '40', 65000, '말린 과일', 'Aroma: 플로럴, 자스민, 살구; Taste: 꿀, 버터스카치, 헤이즐넛; Finish: 설탕에 절인 사과, 시나몬, 바닐라', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샤또 드 브뤼이 핀 깔바도스 VSOP', '40', 65000, '매운 닭강정', 'Aroma: 사과, 아몬드, 오렌지; Taste: 라임, 모과, 아몬드; Finish: 부드러운, 잘 익은 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('불라 깔바도스 오구스트', '40', 335000, '호두 크래커', 'Aroma: 풋사과, 바닐라, 사과 잼, 사과 파이, 꿀; Taste: 과일 잼, 말린 과일, 아몬드, 계피, 우아한, 부드러운; Finish: 섬세한, 균형 잡힌, 긴 여운, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파코리 16년', '41', 154000, '크림치즈 베이글', 'Aroma: 배, 소나무, 후추, 사과, 파워풀; Taste: 강렬한, 신선한, 풍부한; Finish: 우디, 긴 여운, 사과', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파코리 30년', '41', 257000, '말린 과일', 'Aroma: 강렬한, 배, 장미, 커피; Taste: 눅진한, 리치, 배, 잼, 패션프루트, 사과; Finish: 산미, 생동감, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('글렌모렌지 깔바도스 캐스크 피니시 12년', '46', 164000, '그릴드 스테이크', 'Aroma: 구운 사과, 헤더 꿀, 플로럴, 자스민, 아몬드, 배, 바닐라; Taste: 사과, 프랄린 초콜릿, 토피, 유칼립투스, 마지팬, 구운 배; Finish: 풍부한, 오일리, 스파이시, 부드러운, 달콤한, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('깔바도스 페르 마그루아 XO', '40', 136700, '말린 과일', 'Aroma: 설탕에 절인 오렌지, 시나몬, 블랙 페퍼; Taste: 사과 조림, 오렌지 꿀, 코코아; Finish: 구운 향신료, 사과 파이, 복합적인', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('깔바도스 미셸 유아 2018', '46', 118800, '불고기', 'Aroma: 신선한, 청사과, 서양 배, 가벼운, 꽃, 시트러스; Taste: 사과, 미묘한, 향신료, 달콤한, 과일, 생동감; Finish: 상쾌한, 맑은, 바닐라, 우디', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('듀퐁 깔바도스 30년 노 리덕션(CS)', '50', 700000, '그릴드 스테이크', 'Aroma: 향신료, 구운 설탕, 사과; Taste: 쌉쌀한, 구운 사과, 달콤한; Finish: 젖은 흙, 오크, 미네랄리티', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('론디아즈 151 럼 750ml', '75.5', 23600, '매운 닭강정', 'Aroma: 달콤한, 체리, 오렌지; Taste: 바닐라, 럼, 복합적인; Finish: 강렬한, 긴 여운, 스파이시', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('말리부 오리지널 200ml', '21', 10200, '트러플 파스타', 'Aroma: 코코넛, 열대 과일; Taste: 바닐라, 코코넛; Finish: 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('바카디 카르타블랑카', '40', 28000, '치즈 플래터', 'Aroma: 바닐라, 아몬드; Taste: 우드, 스모키; Finish: 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('디플로마티코 리제르바 익스클루시바', '40', 73900, '매운 닭강정', 'Aroma: 토피, 오렌지 껍질, 감초; Taste: 오크, 바닐라, 코코아; Finish: 커피, 균형 잡힌, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('말리부 오리지널 750ml', '21', 26900, '크림치즈 베이글', 'Aroma: 코코넛, 열대 과일; Taste: 바닐라, 코코넛; Finish: 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('군트럼 리슬링 루이스 콘스탄틴', '9~11', 22000, '블루치즈', 'Aroma: 청사과, 파인애플, 멜론; Taste: 가벼운, 시트러스, 달콤한; Finish: 산미, 열대 과일, 우아한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('론디아즈 151 럼 750ml', '75.5', 23500, '양고기 스튜', 'Aroma: 달콤한, 체리, 오렌지; Taste: 바닐라, 럼, 복합적인; Finish: 강렬한, 긴 여운, 스파이시', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('하바나 클럽 3년 700ml', '37~40', 34000, '크림치즈 베이글', 'Aroma: 과일, 사탕수수, 신선한; Taste: 가벼운, 달콤한, 바나나, 부드러운; Finish: 과일, 깔끔한, 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('플랜테이션 O.F.T.D', '69', 48000, '고르곤졸라 피자', 'Aroma: 오렌지, 바닐라, 커피, 초콜릿, 잘 익은 바나나, 크리스마스 향신료; Taste: 열대 과일, 자두, 블랙커런트, 당밀, 오크, 넛맥, 시나몬, 후추; Finish: 정향, 흑후추, 시나몬', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('드럼브이', '40', 52000, '그릴드 스테이크', 'Aroma: 꿀, 꽃, 몰트; Taste: 스파이시, 달콤한, 꿀; Finish: 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('플랜테이션 파인애플 럼', '40', 64000, '그릴드 스테이크', 'Aroma: 열대 과일, 파인애플, 감귤, 정향, 시트러스, 스모키; Taste: 잘 익은 바나나, 파인애플, 달콤한; Finish: 스파이시, 스모키', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('산토리 우메슈 플럼 야마자키', '20', 215000, '고르곤졸라 피자', 'Aroma: 핵과류, 견과류, 말린 과일; Taste: 달콤한, 매실, 아몬드, 말린 살구; Finish: 우아한, 깊은, 구운 오크', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('잭 다니엘스 애플', '35', 39900, '초콜릿 디저트', 'Aroma: 청사과, 달콤한, 바닐라, 가벼운, 오크; Taste: 꿀, 커스터드, 잘 익은 배, 오렌지 껍질; Finish: 졸인 사과, 가벼운 스모키, 달콤한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('디사론노', '28', 42000, '매운 닭강정', 'Aroma: 꽃, 아몬드, 체리; Taste: 아몬드, 살구, 달콤한, 쌉쌀한; Finish: 부드러운, 긴 여운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('디카이퍼 피치트리', '20', 22900, '훈제 연어', 'Aroma: 복숭아, 상큼한, 농익은; Taste: 달콤한, 핵과류, 과일 잼; Finish: 부드러운, 산뜻한, 농밀한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('코앵트로', '40', 29900, '고르곤졸라 피자', 'Aroma: 신선한, 감귤, 시트러스, 오렌지; Taste: 쌉쌀한, 과일, 허브, 달콤한, 바닐라; Finish: 균형 잡힌, 복합적인, 우아한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파마 석류 리큐르', '17', 39800, '트러플 파스타', 'Aroma: 상큼한, 신선한, 석류; Taste: 달콤한, 부드러운, 석류; Finish: 시트러스, 베리류, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('깔루아 1L', '16-20', 29800, '말린 과일', 'Aroma: 바닐라, 초콜릿, 커피; Taste: 다크 초콜릿, 바닐라, 달콤한, 커피, 스모키; Finish: 모카 에스프레소, 화이트 초콜릿', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('파마 석류 리큐르', '17', 39800, '크림치즈 베이글', 'Aroma: 상큼한, 신선한, 석류; Taste: 달콤한, 부드러운, 석류; Finish: 시트러스, 베리류, 산뜻한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('베일리스', '17', 40000, '감자튀김', 'Aroma: 초콜릿, 이국적인, 바닐라; Taste: 초콜릿, 크림, 바닐라, 부드러운; Finish: 복합적인, 은은한, 크림, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('마리브리자드 블루큐라소', '23', 18900, '불고기', 'Aroma: 시트러스, 오렌지, 감귤; Taste: 오렌지, 달콤한, 상큼한; Finish: 은은한, 달콤한, 시트러스', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('디카이퍼 트리플 섹', '40', 18000, '말린 과일', 'Aroma: 시트러스, 감귤, 오렌지; Taste: 오렌지; Finish: 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('엑스레이티드', '17', 39000, '크림치즈 베이글', 'Aroma: 자몽, 시트러스, 향긋한; Taste: 망고, 오렌지, 패션프루트; Finish: 긴 여운, 달콤한, 상큼한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('디카이퍼 카시스', '15', 18000, '호두 크래커', 'Aroma: 블랙커런트; Taste: 베리, 달콤한, 새콤한; Finish: 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('볼스 트리플 섹', '38', 17000, '치즈 플래터', 'Aroma: 오렌지, 시트러스, 감귤; Taste: 달콤한, 쌉쌀한; Finish: 오렌지 껍질', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('볼스 카시스', '17', 14000, '양고기 스튜', 'Aroma: 와인, 체리, 블랙커런트; Taste: 블랙커런트, 새콤한, 달콤한; Finish: 달콤한, 묵직한, 와인', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('마리브리자드 아마레또', '23', 17500, '돼지 바비큐', 'Aroma: 아몬드, 고소한, 강렬한; Taste: 아몬드, 달콤한, 체리; Finish: 부드러운, 달콤한, 쌉쌀한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('미도리 750ml', '20', 39000, '블루치즈', 'Aroma: 꿀, 멜론, 신선한, 향긋한; Taste: 멜론, 시트러스, 달콤한; Finish: 부드러운, 멜론, 새콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('르제 크렘 드 카시스', '16', 36300, '매운 닭강정', 'Aroma: 꽃, 과일 잼, 체리, 다크 초콜릿; Taste: 블랙커런트, 산뜻한, 검은 과일; Finish: 균형 잡힌, 긴 여운, 우아한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('볼스 블루 큐라소', '21', 17000, '호두 크래커', 'Aroma: 감귤, 시트러스, 오렌지; Taste: 달콤한, 쌉쌀한, 상큼한; Finish: 부드러운, 깔끔한, 오렌지', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('말리부 오리지널', '21', 28000, '초콜릿 디저트', 'Aroma: 열대 과일, 코코넛; Taste: 달콤한, 코코넛, 버터, 바닐라; Finish: 달콤한, 코코넛, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아페롤', '11', 30000, '감자튀김', 'Aroma: 오렌지 껍질, 바닐라, 허브; Taste: 달콤한, 쌉쌀한, 오렌지, 허브; Finish: 부드러운, 긴 여운, 향긋한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('힙노틱 700ml', '17', 55000, '양고기 스튜', 'Aroma: 망고, 배, 파인애플; Taste: 오렌지, 꼬냑, 패션프루트; Finish: 달콤한, 부드러운, 열대 과일', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('잭 다니엘스 허니', '35', 38000, '블루치즈', 'Aroma: 꿀, 바닐라, 셰리, 캐러멜; Taste: 바닐라, 오크, 버번, 벌꿀; Finish: 풍부한, 달콤한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('디카이퍼 애플 퍼커', '15', 24500, '양고기 스튜', 'Aroma: 사과, 산뜻한; Taste: 신선한, 달콤한; Finish: 사과, 새콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('볼스 바나나', '17~24', 14000, '훈제 연어', 'Aroma: 과일, 달콤한, 바나나; Taste: 잘 익은 바나나, 바닐라; Finish: 부드러운, 섬세한, 아몬드', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('생 제르맹', '20', 71000, '크림치즈 베이글', 'Aroma: 엘더플라워, 열대 과일; Taste: 복숭아, 배, 시트러스, 감귤, 달콤한; Finish: 부드러운, 긴 여운, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('베네딕틴 돔 750ml', '40', 61900, '치즈 플래터', 'Aroma: 허브', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('샴보드 700ml', '16.5', 38000, '크림치즈 베이글', 'Aroma: 라즈베리, 블랙베리, 블랙커런트; Taste: 라즈베리, 시트러스, 감귤; Finish: 우아한, 꼬냑, 달콤한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('진로 토닉워터 300ml', 'NULL', 1000, '초콜릿 디저트', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('진로이즈백 병 360ml', '16.5', 1600, '트러플 파스타', 'Aroma: 알코올; Taste: 깔끔한; Finish: 알코올', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('진로 레드 와인', '14', 25000, '고르곤졸라 피자', 'Aroma: 체리, 자두, 석류; Taste: 건자두, 과일, 풍부한, 말린 꽃; Finish: 진한, 과일, 긴 여운, 부드러운 타닌', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('디스틸러리 드 파리 진 토닉', '43', 75000, '돼지 바비큐', 'Aroma: 발사믹, 시트러스, 오렌지 껍질; Taste: 선명한, 부드러운, 쌉쌀한; Finish: 신선한, 둥근, 우아한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('선비 진토닉', 'NULL', 4000, '고르곤졸라 피자', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('봄베이 사파이어', '47', 36000, '훈제 연어', 'Aroma: 주니퍼 베리, 레몬, 후추; Taste: 섬세한, 레몬, 향신료, 허브; Finish: 라벤더, 고수, 복합적인', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('참이슬 병 360ml', '16.5', 1500, '양고기 스튜', 'Aroma: 알코올; Taste: 깨끗한; Finish: 알코올', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('참이슬 오리지널 360ml', 'NULL', 2000, '양고기 스튜', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('처음처럼 병 360ml', 'NULL', 1500, '돼지 바비큐', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('하이트 논알콜 캔 500ml', 'NULL', 1800, '그릴드 스테이크', '', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아녹 18년', '46', 280000, '블루치즈', 'Aroma: 초콜릿, 오렌지, 가죽, 레몬, 파인애플; Taste: 말린 과일, 초콜릿, 오렌지, 바닐라, 캐러멜; Finish: 달콤한, 부드러운', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아녹 12년', '40', 98000, '훈제 연어', 'Aroma: 꽃, 레몬, 산뜻한, 벌꿀, 달콤한; Taste: 짭짤한, 몰트, 고소한, 과일, 달콤한; Finish: 풍부한, 우아한', DEFAULT, DEFAULT);

INSERT INTO drink (name, alcohol_content, price, pairing_food, description, avg_rating, view_count)
VALUES ('아녹 24년', '46', 468000, '감자튀김', 'Aroma: 크리스마스 케이크, 바닐라, 토피, 레몬 주스; Taste: 설탕에 절인 오렌지, 꿀, 가죽; Finish: 오크, 오렌지 껍질, 둥근, 스파이시', DEFAULT, DEFAULT);
