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
   readcount number default 1 NOT NULL,
    CONSTRAINT fk_notice_created_by FOREIGN KEY (created_by) REFERENCES users(login_id)
);

COMMENT ON COLUMN NOTICE.NOTICE_ID IS '공지글번호';
COMMENT ON COLUMN NOTICE.CREATED_BY IS '공지글작성자';
COMMENT ON COLUMN NOTICE.CREATED_AT IS '공지등록일시';
COMMENT ON COLUMN NOTICE.TITLE IS '공지제목';
COMMENT ON COLUMN NOTICE.CONTENT IS '공지내용';
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



