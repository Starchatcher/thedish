# 🍽️ The Dish 프로젝트

**"The Dish"**는 음식과 술을 사랑하는 사용자들에게  
**레시피, 알레르기 정보, 건강 맞춤 추천, 술 페어링** 기능을 제공하는  
**웹 기반 음식 정보 플랫폼**입니다.

---

## 📌 핵심 기능

- 🔐 회원가입 / 로그인 / 마이페이지
- 🍲 음식 레시피 검색 및 등록
- 🧠 건강 상태 기반 음식 추천
- 🍷 음식 ↔ 술 페어링 추천
- 📍 위치 기반 맛집 추천 (Kakao Map API)
- 💬 커뮤니티 (자유게시판, 팁 공유, Q&A)
- 📊 관리자 전용 FAQ / 공지 / 신고 관리

---

## ⚙️ 개발 환경

| 항목 | 사용 기술 |
|------|-----------|
| Backend | Java, Spring MVC, MyBatis |
| Frontend | JSP, HTML/CSS/JS |
| Database | Oracle 11g |
| 협업 도구 | GitHub, Notion, VS Code |
| 배포 환경 | (추후: EC2, Tomcat, etc) |

---

## 🛠️ 프로젝트 구조

> 전체 디렉토리 구조는 [여기서 보기](./docs/README_DIRECTORY.md)  
(→ 또는 자동 생성 스크립트 참고)

---

## 🗂️ 주요 문서 링크

- 📘 [기획서 PDF](./docs/report/기획서.pdf)
- 🧩 [ERD 구조](./docs/erd/ERD설계.png)
- 🧑‍🎨 [UI 설계](./docs/ui/UI설계.pdf)
- 🔧 [DB 스크립트](./db/ddl/thedish_create_tables.sql)

---

## 🧑‍🤝‍🧑 팀원 소개

| 이름 | 역할 |
|------|------|
| 김요섭 | 팀장 / DB & 회원 기능 |
| 정세현 | 음식/술 기능, 클래스설계 |
| 박기범 | 화면 UI 설계 / 프론트 |
| 김준용 | 술 정보 / 페어링 / 관리자 기능 |
| 유다빈 | 커뮤니티 / Q&A / FAQ 관리 |

---

## 🚀 실행 방법

1. Oracle DB 실행 + `thedish_create_tables.sql` 실행
2. VS Code or IntelliJ에서 프로젝트 Import
3. Maven install (pom.xml 확인)
4. `http://localhost:8080/the-dish` 로 접속

---

## 📝 기여 가이드

1. 본인 브랜치에서 작업
2. 커밋 메시지는 기능 단위로 작성: `feat: 로그인 기능 구현`
3. 머지는 `세현`이 메인 브랜치로 통합

---

## ✅ 라이선스

본 프로젝트는 교육 목적이며, 비상업적으로 자유롭게 활용할 수 있습니다.
