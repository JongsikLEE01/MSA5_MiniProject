DELETE FROM Users;

 SELECT sc.*, c.Subject_name, u.* 
				    FROM Score sc 
				   JOIN Course c ON sc.Coursecode = c.Coursecode 
				   JOIN Users u ON sc.uNo = u.uNo 
				   WHERE u.StudentID = '20220001';

-- 학생 관련DB 생성
CREATE TABLE Users (
	uNo number NOT NULL,
	StudentID varchar2(30) NOT NULL,
	Name varchar2(20) NULL,
	Birth varchar2(100) NULL,
	Mail varchar2(100) NULL,
	AcademicStatus varchar2(100) NULL,
	dNo number NOT NULL
);
CREATE TABLE Course (
	Coursecode varchar2(100) NOT NULL,
	Subject_name varchar2(100) NULL,
	dNo number NOT NULL
);
CREATE TABLE Score (
	No number NOT NULL,
	Subjectscore varchar2(50) NOT NULL,
	Input_date date DEFAULT SYSDATE,
	Upd_date date DEFAULT SYSDATE,
	Type varchar2(50) NULL,
	uNo number NOT NULL,
	Coursecode varchar2(30) NOT NULL
);
CREATE TABLE Department (
	dNo number NOT NULL,
	Majorname varchar2(100) NOT NULL
);
 CREATE TABLE userimg
(
  no       NUMBER        NOT NULL,
  filename VARCHAR2(255),
  usernum  NUMBER        NOT NULL,
  CONSTRAINT PK_userimg PRIMARY KEY (no)
);

ALTER TABLE Users ADD CONSTRAINT PK_USERS PRIMARY KEY (uNo);
ALTER TABLE Course ADD CONSTRAINT PK_COURSE PRIMARY KEY (Coursecode);
ALTER TABLE Department ADD CONSTRAINT PK_DEPARTMENT PRIMARY KEY (dNo);
ALTER TABLE Score ADD CONSTRAINT PK_SCORE PRIMARY KEY (No);

COMMENT ON TABLE userimg IS '학생사진';


-- 시퀀스
CREATE SEQUENCE SEQ_UIMG
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 9999;
CREATE SEQUENCE SEQ_USERS
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 9999;


-- 학생 관련 데이터
INSERT ALL
    INTO Score (No, Subjectscore, Type, uNo, Coursecode) VALUES (1, 'A', 'Midterm', 1, 'CSCI101')
    INTO Score (No, Subjectscore, Type, uNo, Coursecode) VALUES (2, 'B+', 'Final', 2, 'ENG101')
    INTO Score (No, Subjectscore, Type, uNo, Coursecode) VALUES (3, 'B', 'Midterm', 3, 'MATH101')
    INTO Score (No, Subjectscore, Type, uNo, Coursecode) VALUES (4, 'A', 'Final', 4, 'HIST101')
    INTO Score (No, Subjectscore, Type, uNo, Coursecode) VALUES (5, 'C', 'Midterm', 5, 'PHYS101')
SELECT * FROM dual;

INSERT ALL
    INTO Course (Coursecode, Subject_name, dNo) VALUES ('CSCI101', 'Introduction to Computer Science', 1)
    INTO Course (Coursecode, Subject_name, dNo) VALUES ('ENG101', 'English Composition', 2)
    INTO Course (Coursecode, Subject_name, dNo) VALUES ('MATH101', 'Calculus', 3)
    INTO Course (Coursecode, Subject_name, dNo) VALUES ('HIST101', 'World History', 4)
    INTO Course (Coursecode, Subject_name, dNo) VALUES ('PHYS101', 'Physics', 1)
SELECT * FROM dual;

INSERT ALL
    INTO Users (uNo, StudentID, Name, Birth, Mail, AcademicStatus, dNo) VALUES (1, '20220001', 'John Doe', '19900515', 'john@example.com', '재학', 1)
    INTO Users (uNo, StudentID, Name, Birth, Mail, AcademicStatus, dNo) VALUES (2, '20220002', 'Jane Smith', '19920820', 'jane@example.com', '재학', 2)
    INTO Users (uNo, StudentID, Name, Birth, Mail, AcademicStatus, dNo) VALUES (3, '20220003', 'Alice Johnson', '19881210', 'alice@example.com', '재학', 1)
    INTO Users (uNo, StudentID, Name, Birth, Mail, AcademicStatus, dNo) VALUES (4, '20220004', 'Bob Brown', '19910325', 'bob@example.com', '재학', 2)
    INTO Users (uNo, StudentID, Name, Birth, Mail, AcademicStatus, dNo) VALUES (5, '20220005', 'Emily Davis', '19930618', 'emily@example.com', '졸업', 1)
SELECT * FROM dual;

INSERT INTO department (Dno, majorname)
VALUES	(1, '컴퓨터 공학');
INSERT INTO department (Dno, majorname)
VALUES	(2, '전기 공학');
INSERT INTO department (Dno, majorname)
VALUES	(3, '화학 공학');