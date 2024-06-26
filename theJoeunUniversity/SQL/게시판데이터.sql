delete from board;

 commit;

-- 게시판DB 생성
CREATE TABLE Board (
	No number NOT NULL,
	Title varchar2(50) NULL,
	Writer varchar2(50) NULL,
	Content varchar2(2000) NULL,
	Reg_date date DEFAULT SYSDATE,
	Upd_date date DEFAULT SYSDATE,
	Views number NULL,
	Like_cnt number NULL,
	CheckStaus number NULL
);

ALTER TABLE Board ADD CONSTRAINT PK_BOARD PRIMARY KEY (No);

-- 시퀀스
CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 9999;

-- 게시판 데이터
INSERT into board (NO, title, WRITER, CONTENT, REG_DATE, upd_date) 
VALUES 
('1', '[학생지원]국제학생증 발급비 지원', '김교수', 
   '가. 온라인 신청서 등록 : isic.co.kr/hbr/324005',
 '2024-04-04','2024-04-04 ');
 
 INSERT into board (NO, title, WRITER, CONTENT, REG_DATE, upd_date) 
VALUES 
('2', '조교(학부TA) 모집 공고', '안교수', 
   '1. 모집인원 : TA1 1명
    2. 자격 : 학부 재학생 
(교비근로, 국가근로 중복 근무 불가)
    3. 담당 업무: 연구소 업무 보조 (주10시간 근무)',
 '2024-04-09','2024-04-09');
 
 INSERT into board (NO, title, WRITER, CONTENT, REG_DATE, upd_date) 
VALUES 
('3', '장학생 선발 안내', '박교수', 
   '1. 추천 인원 : 2024학년도 정규 등록 재학생 1명 (※1학년 제외)
    
    2. 장학금액 : 200만 원 (생활비성 장학금)
  ※ 최대 2개 학기 지급 
    
    3. 지원 자격
  가. 소득 : 한국장학재단 소득 0 ~ 1구간
  나. 성적 : 직전 두 학기 평점 평균 3.5 이상 (4.5 만점 기준) 
    
    4. 제출 서류 (원본 제출)
  가. 장학생 신청 및 추천서 (재단 양식)
  나. 자기소개서 (재단 양식) 
  다. 장학금 지급 규정 준수 동의서 (재단 양식)
  라. 한국장학재단 학자금 지원 구간 통지서
  마. 성적 증명서
    
    5. 신청 방법 : 인하대학교 장학복지팀 방문 접수 (학생회관 3층 장학복지팀)
    
    6. 접수 기한 : ~ 4. 15. (월) 18:00',
 '2024-04-12','2024-04-14 ');
 
 
 INSERT into board (NO, title, WRITER, CONTENT, REG_DATE, upd_date) 
VALUES 
('4', '중간고사 대비 프로그램 운영', '강조교', 
   '비교과 프로그램을 아래와 같이 운영하오니 학생들의 많은 관심과 참여 부탁 드립니다.
   비교과 과목으로는 C언어, JAVA, JSP, PYTHON이 있습니다. 
   과목 신청 페이지는 4월 14일 열릴 예정으로 해당 페이지는13일에 안내가 있을 예정입니다.',
 '2024-04-12','2024-04-14 ');
 
 INSERT into board (NO, title, WRITER, CONTENT, REG_DATE, upd_date) 
VALUES 
('5', '2024학년도 1학기 재입학 전형 안내', '유교수', 
   '1. 지원자격

  가. 2023-2 이전(~2023년 9월 제적일) 미등록, 복학불이행 및 학사경고로 제적된 자
나. 2023-1 이전(~2023년 8월 자퇴) 자퇴한 자
다. 「학칙」 제50조 제6항에 따라 징계로 퇴학당한 학생에게는 재입학을 불허

2. 모집인원 : 총 62명(정원내: 35명, 정원외: 27명)
  ※ 의과대학 및 사범대학 재입학 모집인원 없음

  ※ 자세한 내용은 재입학 모집인원 참조',
 '2024-06-01','2024-06-01 ');
 
 INSERT into board (NO, title, WRITER, CONTENT, REG_DATE, upd_date) 
VALUES 
('6', '하계 계절학기 시행 안내', '김교수', 
   '수업 기간 : 2024. 06. 24.(월) ~ 2024. 07. 10.(수)

수강 신청
기 간 : 2024. 06. 15.(월) 15:30 ~ . 22.(화) 17:00
방 법
인터넷 수강신청(수강신청 홈페이지 http://sugang.inha.ac.kr)
모바일 수강신청(모바일 홈페이지 http://m.inha.ac.kr)
※ 스마트폰 등 이동통신기기는 사용자환경(네트워크, 브라우저 설정 등) 에 따라 불안정할 수 있으므로, 반드시 수강신청 보조 수단으로만 사용

신청 학점 : 학기당 신청학점에 제한은 없으나 재학 중 총 24학점까지 가능

등록
기 간: 2022. 12. 08.(목) 09:00 – 12. 9.(금) 17:00
방 법: 포털 → 등록 → 계절학기 등록금 납부 메뉴를 통해 가상계좌 확인 및 실시간 계좌이체 납부
(입금 후 입금일자 확인 가능)
수강료: 1학점당 90,000원
등록금 입금 시 지정된 금액을 납부하여야 등록이 됨 (지정금액 외 납부 불가)
※ 예를 들어, 2과목 수강신청 후 1과목 포기하려면 우선은 전액 납부 후 전액환불 수강포기기간에 1과목을 포기해야 함(1과목 금액만 납부는 불가)

',
 '2024-06-15','2024-06-16');
 
 INSERT into board (NO, title, WRITER, CONTENT, REG_DATE, upd_date) 
VALUES 
('7', '2024-2학기 수강신청 안내', '민교수', 
   '. 우선수강신청 결과 확인: 2024. 8. 12.(금) 13:00 부터

2. 확인 방법

가. 수강신청 홈페이지(deoJoeun.univer.ac.kr) -> 수강신청 -> 우선수강신청 결과확인

나. 우선 수강신청 결과 확인의 「결과」가 「Y」로 표시된 과목은 일괄(자동) 수강신청 처리하므로 별도의 수강신청이 필요 없음.   

    ⇒ 단, 본 수강신청 기간에 삭제/변경 가능함.

다. 우선 수강신청 결과 확인의「결과」가 「N」으로 표시된 과목은 수강을 희망하는 경우 수강신청 기간에「수강신청」프로그램에서 반드시 선착순 수강신청을 하여야 함. ',
 '2024-08-01','2024-08-01 ');