--======================================
-- 일단 관리자계정으로 접속하세요
--======================================
--ADSTORY계정 생성 
--CREATE USER adstory 
--IDENTIFIED BY adstory 
--DEFAULT TABLESPACE USERS;

--권한부여
--GRANT CONNECT, RESOURCE TO adstory;

--============================
--조회
--============================
--시퀀스 일괄 조회
SELECT * FROM USER_SEQUENCES;

--테이블 조회
SELECT * FROM ALL_OBJECTS WHERE OBJECT_TYPE = 'TABLE';
SELECT * FROM tabs;

--======================================
-- 삭제
--======================================
-- 시퀀스 일괄 삭제

--Begin
--for c in (SELECT * FROM all_sequences WHERE SEQUENCE_OWNER='ADSTORY') loop
--  execute immediate 'drop SEQUENCE '||c.sequence_name;
--end loop;
--End;

--테이블 싹다 초기화 (결과 긁어서 실행)
--1. 일단 조회
--SELECT  'DROP TABLE ' || object_name || ' CASCADE CONSTRAINTS;'
--  FROM    user_objects
--WHERE   object_type = 'TABLE';

-- 테이블 일괄삭제
DROP TABLE AD_POST_CATEG CASCADE CONSTRAINTS;
DROP TABLE AD_POST CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE PNT_EX_LOG CASCADE CONSTRAINTS;
DROP TABLE WISH_LIST CASCADE CONSTRAINTS;
DROP TABLE ENQUIRY CASCADE CONSTRAINTS;
DROP TABLE M_POST CASCADE CONSTRAINTS;
DROP TABLE M_POST_CATEG CASCADE CONSTRAINTS;
DROP TABLE FIXED_URL CASCADE CONSTRAINTS;
DROP TABLE IP_LOG CASCADE CONSTRAINTS;
DROP TABLE PNT_LOG CASCADE CONSTRAINTS;
DROP TABLE AD_POST_COMM CASCADE CONSTRAINTS;
DROP TABLE AD_LIST CASCADE CONSTRAINTS;
DROP TABLE T_POST_COMM CASCADE CONSTRAINTS;
DROP TABLE T_POST CASCADE CONSTRAINTS;

--시퀀스 일괄 삭제
DROP SEQUENCE SEQ_AD_POST;
DROP SEQUENCE SEQ_AD_POST_CATEG;
DROP SEQUENCE SEQ_AD_POST_COMM;
DROP SEQUENCE SEQ_FIXED_URL;
DROP SEQUENCE SEQ_IP_LOG;
DROP SEQUENCE SEQ_MEMBER;
DROP SEQUENCE SEQ_M_POST;
DROP SEQUENCE SEQ_M_POST_CATEG;
DROP SEQUENCE SEQ_PNT_EX_LOG;
DROP SEQUENCE SEQ_PNT_LOG;
DROP SEQUENCE SEQ_ENQUIRY;
DROP SEQUENCE SEQ_WISH_LIST;
DROP SEQUENCE SEQ_AD_LIST;
DROP SEQUENCE SEQ_T_POST;
DROP SEQUENCE SEQ_T_POST_COMM;




--======================================
-- 생성
--======================================
--시퀀스 생성
CREATE SEQUENCE SEQ_MEMBER;
CREATE SEQUENCE SEQ_AD_POST_CATEG;
CREATE SEQUENCE SEQ_AD_POST;
CREATE SEQUENCE SEQ_PNT_EX_LOG;
CREATE SEQUENCE SEQ_WISH_LIST;
CREATE SEQUENCE SEQ_ENQUIRY;
CREATE SEQUENCE SEQ_M_POST;
CREATE SEQUENCE SEQ_M_POST_CATEG;
CREATE SEQUENCE SEQ_AD_LIST;
CREATE SEQUENCE SEQ_IP_LOG;
CREATE SEQUENCE SEQ_PNT_LOG;
CREATE SEQUENCE SEQ_AD_POST_COMM;
CREATE SEQUENCE SEQ_T_POST;
CREATE SEQUENCE SEQ_T_POST_COMM;

-- 테이블 생성
 
CREATE TABLE "T_POST_COMM" (
    "KEY"   NUMBER      NOT NULL,
    "USER_KEY"  NUMBER      NOT NULL,
    "POST_KEY"  NUMBER      NOT NULL,
    "CONTENT"   VARCHAR2(2000)      NOT NULL,
    "POST_DATE" DATE    DEFAULT SYSDATE NOT NULL,
    "COMM_LEVEL"    NUMBER  DEFAULT 1   NOT NULL,
    "COMM_REF"  NUMBER      NULL,
    "STATUS"    CHAR(1) DEFAULT 'F' NOT NULL
);

ALTER TABLE "T_POST_COMM" ADD CONSTRAINT "PK_T_POST_COMM" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "T_POST_COMM" ADD CONSTRAINT "FK_MEMBER_TO_T_POST_COMM_1" FOREIGN KEY (
    "USER_KEY"
)
REFERENCES "MEMBER" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "T_POST_COMM" ADD CONSTRAINT "FK_T_POST_TO_T_POST_COMM_1" FOREIGN KEY (
    "POST_KEY"
)
REFERENCES "T_POST" (
    "KEY"
)ON DELETE CASCADE ;

DROP TABLE T_POST CASCADE CONSTRAINTS;

CREATE TABLE "T_POST" (
    "KEY"   NUMBER      NOT NULL,
    "USER_KEY"  NUMBER      NOT NULL,
    "TITLE" VARCHAR2(50)        NOT NULL,
    "CONTENT" CLOB NOT NULL,
    "POST_DATE" DATE    DEFAULT SYSDATE NOT NULL,
    "READ_COUNT"    NUMBER  DEFAULT 0   NOT NULL,
    "RECOMMEND" NUMBER  DEFAULT 0   NOT NULL
);

ALTER TABLE "T_POST" ADD CONSTRAINT "PK_T_POST" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "T_POST" ADD CONSTRAINT "FK_MEMBER_TO_T_POST_1" FOREIGN KEY (
    "USER_KEY"
)
REFERENCES "MEMBER" (
    "KEY"
)ON DELETE CASCADE ;


CREATE TABLE "MEMBER" (
    "KEY"   NUMBER      NOT NULL,
    "MEMBER_ID" VARCHAR2(15)        NOT NULL,
    "PASSWORD"  VARCHAR2(300)       NOT NULL,
    "MEMBER_ROLE"   CHAR(1) DEFAULT 'U' NOT NULL,
    "POINT" NUMBER  DEFAULT 0   NOT NULL,
    "PHONE_NUM" CHAR(11)        NOT NULL,
    "ACCOUNT_NAME"  VARCHAR2(20)        NOT NULL,
    "ACCOUNT_NUM"   CHAR(30)        NOT NULL,
    "BUSINESS_NUM"  CHAR(20)        NULL,
    "NAME"  VARCHAR2(30)        NOT NULL,
    "EMAIL" VARCHAR2(100)       NOT NULL,
    "ADDRESS"   VARCHAR2(300)       NULL,
    "ENROLL_DATE"   DATE    DEFAULT SYSDATE NOT NULL
);

CREATE TABLE "AD_POST_CATEG" (
    "KEY"   NUMBER      NOT NULL,
    "CATEGORY_NAME" VARCHAR2(30)        NOT NULL
);

CREATE TABLE "AD_POST" (
    "KEY"   NUMBER      NOT NULL,
    "CATEGORY_KEY"  NUMBER      NOT NULL,
    "USER_KEY"  NUMBER      NOT NULL,
    "TITLE" VARCHAR2(50)        NOT NULL,
    "CONTENT"   VARCHAR2(2000)      NOT NULL,
    "ENROLL_DATE"   DATE    DEFAULT SYSDATE NOT NULL,
    "STATUS"    CHAR(1) DEFAULT 'F' NOT NULL,
    "CLICK_PRICE"   NUMBER      NOT NULL,
    "POINT" NUMBER      NOT NULL,
    "URL"   VARCHAR2(100)       NOT NULL,
    "ORIGINAL_FILE_NAME"    VARCHAR2(200)       NULL,
    "RENAMED_FILE_NAME" VARCHAR2(200)       NULL,
    "APPLY_NUM" NUMBER  DEFAULT 0   NOT NULL,
    "MAIN_IMAGE_ORIGIN" VARCHAR2(200)       NULL,
    "MAIN_IMAGE_RENAME" VARCHAR2(200)       NULL
);

CREATE TABLE "PNT_EX_LOG" (
    "KEY"   NUMBER      NOT NULL,
    "USER_KEY"  NUMBER      NOT NULL,
    "WITHDRAW"  NUMBER      NOT NULL,
    "STATUS"    CHAR(1) DEFAULT 'F' NOT NULL,
    "APPLY_DATE"    DATE    DEFAULT SYSDATE NOT NULL,
    "REQUIREMENTS"  VARCHAR2(100)       NOT NULL
);

CREATE TABLE "WISH_LIST" (
    "KEY"   NUMBER      NOT NULL,
    "USER_KEY"  NUMBER      NOT NULL,
    "C_USER_KEY"    NUMBER      NOT NULL
);

CREATE TABLE "ENQUIRY" (
    "KEY"   NUMBER      NOT NULL,
    "USER_KEY"  NUMBER      NOT NULL,
    "TITLE" VARCHAR2(50)        NULL,
    "ENQUIRY_DATE"  DATE    DEFAULT SYSDATE NOT NULL,
    "CONTENT"   VARCHAR2(2000)      NOT NULL,
    "ANSWER"    VARCHAR2(2000)      NULL,
    "STATUS"    CHAR(1) DEFAULT 'F' NOT NULL
);

CREATE TABLE "M_POST" (
    "KEY"   NUMBER      NOT NULL,
    "CATEGORY_KEY"  NUMBER      NOT NULL,
    "TITLE" VARCHAR2(50)        NULL,
    "CONTENT"   VARCHAR2(2000)      NULL,
    "DATE"  DATE    DEFAULT SYSDATE NULL
);

CREATE TABLE "M_POST_CATEG" (
    "KEY"   NUMBER      NOT NULL,
    "CATEGORY_NAME" VARCHAR2(50)        NOT NULL
);

CREATE TABLE "AD_LIST" (
    "KEY"   NUMBER      NOT NULL,
    "USER_KEY"  NUMBER      NOT NULL,
    "POST_KEY"  NUMBER      NOT NULL,
    "REVENUE"   NUMBER  DEFAULT 0   NOT NULL
);

CREATE TABLE "IP_LOG" (
    "KEY"   NUMBER      NOT NULL,
    "AD_LIST_KEY"   NUMBER      NOT NULL,
    "IP"    VARCHAR2(30)        NOT NULL
);

CREATE TABLE "PNT_LOG" (
    "KEY"   NUMBER      NOT NULL,
    "USER_KEY"  NUMBER      NOT NULL,
    "POST_KEY"  NUMBER      NULL,
    "LOG_DATE"  DATE    DEFAULT SYSDATE NOT NULL,
    "POINT" NUMBER      NOT NULL,
    "STATUS"    CHAR(1)     NOT NULL,
    "REMAIN_POINT"  NUMBER      NOT NULL
);

CREATE TABLE "AD_POST_COMM" (
    "KEY"   NUMBER      NOT NULL,
    "POST_KEY"  NUMBER      NOT NULL,
    "USER_KEY"  NUMBER      NOT NULL,
    "CONTENT"   VARCHAR2(2000)      NOT NULL,
    "COMMENT_DATE"  DATE    DEFAULT SYSDATE NOT NULL,
    "COMMENT_LEVEL" NUMBER  DEFAULT 1   NOT NULL,
    "COMMENT_REF"   NUMBER      NULL,
    "STATUS"    CHAR(1) DEFAULT 'F' NOT NULL
);

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "AD_POST_CATEG" ADD CONSTRAINT "PK_AD_POST_CATEG" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "AD_POST" ADD CONSTRAINT "PK_AD_POST" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "PNT_EX_LOG" ADD CONSTRAINT "PK_PNT_EX_LOG" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "WISH_LIST" ADD CONSTRAINT "PK_WISH_LIST" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "ENQUIRY" ADD CONSTRAINT "PK_ENQUIRY" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "M_POST" ADD CONSTRAINT "PK_M_POST" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "M_POST_CATEG" ADD CONSTRAINT "PK_M_POST_CATEG" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "AD_LIST" ADD CONSTRAINT "PK_AD_LIST" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "IP_LOG" ADD CONSTRAINT "PK_IP_LOG" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "PNT_LOG" ADD CONSTRAINT "PK_PNT_LOG" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "AD_POST_COMM" ADD CONSTRAINT "PK_AD_POST_COMM" PRIMARY KEY (
    "KEY"
);

ALTER TABLE "AD_POST" ADD CONSTRAINT "FK_AD_POST_CATEG_TO_AD_POST_1" FOREIGN KEY (
    "CATEGORY_KEY"
)
REFERENCES "AD_POST_CATEG" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "AD_POST" ADD CONSTRAINT "FK_MEMBER_TO_AD_POST_1" FOREIGN KEY (
    "USER_KEY"
)
REFERENCES "MEMBER" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "PNT_EX_LOG" ADD CONSTRAINT "FK_MEMBER_TO_PNT_EX_LOG_1" FOREIGN KEY (
    "USER_KEY"
)
REFERENCES "MEMBER" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "WISH_LIST" ADD CONSTRAINT "FK_MEMBER_TO_WISH_LIST_1" FOREIGN KEY (
    "USER_KEY"
)
REFERENCES "MEMBER" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "ENQUIRY" ADD CONSTRAINT "FK_MEMBER_TO_ENQUIRY_1" FOREIGN KEY (
    "USER_KEY"
)
REFERENCES "MEMBER" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "M_POST" ADD CONSTRAINT "FK_M_POST_CATEG_TO_M_POST_1" FOREIGN KEY (
    "CATEGORY_KEY"
)
REFERENCES "M_POST_CATEG" (
    "KEY"
)ON DELETE CASCADE ;


ALTER TABLE "AD_LIST" ADD CONSTRAINT "FK_MEMBER_TO_AD_LIST_1" FOREIGN KEY (
    "USER_KEY"
)
REFERENCES "MEMBER" (
    "KEY"
 
) ON DELETE CASCADE ;

ALTER TABLE "AD_LIST" ADD CONSTRAINT "FK_AD_POST_TO_AD_LIST_1" FOREIGN KEY (
    "POST_KEY"
)
REFERENCES "AD_POST" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "IP_LOG" ADD CONSTRAINT "FK_AD_LIST_TO_IP_LOG_1" FOREIGN KEY (
    "AD_LIST_KEY"
)
REFERENCES "AD_LIST" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "PNT_LOG" ADD CONSTRAINT "FK_MEMBER_TO_PNT_LOG_1" FOREIGN KEY (
    "USER_KEY"
)
REFERENCES "MEMBER" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "PNT_LOG" ADD CONSTRAINT "FK_AD_POST_TO_PNT_LOG_1" FOREIGN KEY (
    "POST_KEY"
)
REFERENCES "AD_POST" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "AD_POST_COMM" ADD CONSTRAINT "FK_AD_POST_TO_AD_POST_COMM_1" FOREIGN KEY (
    "POST_KEY"
)
REFERENCES "AD_POST" (
    "KEY"
)ON DELETE CASCADE ;

ALTER TABLE "AD_POST_COMM" ADD CONSTRAINT "FK_MEMBER_TO_AD_POST_COMM_1" FOREIGN KEY (
    "USER_KEY"
)
REFERENCES "MEMBER" (
    "KEY"
)ON DELETE CASCADE ;


ALTER TABLE "MEMBER" ADD CONSTRAINT "CK_MEMBER_ROLE" CHECK (MEMBER_ROLE IN ('A', 'U', 'C'));

ALTER TABLE "MEMBER" ADD CONSTRAINT "UQ_MEMBER_ID" UNIQUE (MEMBER_ID);

ALTER TABLE "PNT_LOG" ADD CONSTRAINT "CK_STATUS" CHECK (STATUS IN ('I', 'O', 'E', 'C', 'A'));






-- ======================================
--  회원 추가
-- ======================================
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'kimdh','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','A',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김관리자','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'honggd','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'홍지디','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'sinsa','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','C',1000000,'01000000000','신한은행','123-123-123123',NULL,'신사','kimdh@naver.com','서울시 강남',DEFAULT );

INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test1','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트1','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test2','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트2','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test3','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트3','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test4','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트4','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test5','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트5','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test6','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트6','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test7','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트7','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test8','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트8','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test9','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트9','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test10','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트10','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'test11','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김테스트11','kimdh@naver.com','서울시 강남',DEFAULT );
INSERT INTO MEMBER VALUES(SEQ_MEMBER.NEXTVAL,'blank','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','U',DEFAULT,'01000000000','신한은행','123-123-123123',NULL,'김블랭','kimdh@naver.com','서울시 강남',DEFAULT );


-- ======================================
--  게시글 카테고리 추가
-- ======================================
INSERT INTO AD_POST_CATEG VALUES(SEQ_AD_POST_CATEG.NEXTVAL, '식품');
INSERT INTO AD_POST_CATEG VALUES(SEQ_AD_POST_CATEG.NEXTVAL, '교육');

-- ======================================
--  게시글 추가
-- ======================================

INSERT INTO AD_POST VALUES (SEQ_AD_POST.NEXTVAL, 1, 1, '5오렌지 상품 홍보','오렌지 어쩌구저쩌구 ㅁㄴㅇㄹ',SYSDATE, DEFAULT, 500, 1000000, 'https://kr.sunkist.com/', NULL, NULL, DEFAULT, 'test_img.jpg','test_img.jpg');
INSERT INTO AD_POST VALUES (SEQ_AD_POST.NEXTVAL, 2, 2, '강아지 훈련 사이트','강아지 훈련 잘해요 저희사이트 좋아요',SYSDATE, DEFAULT, 300, 2000000, 'https://www.bodeum.co.kr/html/edu_movie/', NULL, NULL, DEFAULT, 'puppy.png','puppy.png');
INSERT INTO AD_POST VALUES (SEQ_AD_POST.NEXTVAL, 2, 2, 'KH정보교육원','공부 잘되는곳임',SYSDATE, DEFAULT, 400, 3000000, 'https://www.iei.or.kr/main/main.kh', NULL, NULL, DEFAULT, 'kh.png', 'kh.png');
INSERT INTO AD_POST VALUES (SEQ_AD_POST.NEXTVAL, 2, 2, '테스트','테스트',SYSDATE, DEFAULT, 123, 44000, '#', NULL, NULL, DEFAULT, NULL,NULL);
INSERT INTO AD_POST VALUES (SEQ_AD_POST.NEXTVAL, 2, 3, '신사1 테스트','테스트',SYSDATE, DEFAULT, 123, 44000, '#', NULL, NULL, DEFAULT, NULL,NULL);
INSERT INTO AD_POST VALUES (SEQ_AD_POST.NEXTVAL, 2, 3, '신사2테스트','테스트',SYSDATE, DEFAULT, 123, 44000, '#', NULL, NULL, DEFAULT, NULL,NULL);
INSERT INTO AD_POST VALUES (SEQ_AD_POST.NEXTVAL, 2, 3, '신사3테스트','테스트',SYSDATE, DEFAULT, 123, 44000, '#', NULL, NULL, DEFAULT, NULL,NULL);
INSERT INTO AD_POST VALUES (SEQ_AD_POST.NEXTVAL, 2, 3, '신사4테스트','테스트',SYSDATE, DEFAULT, 123, 44000, '#', NULL, NULL, DEFAULT, NULL,NULL);
INSERT INTO AD_POST VALUES (SEQ_AD_POST.NEXTVAL, 2, 3, '신사5테스트','테스트',SYSDATE, DEFAULT, 123, 44000, '#', NULL, NULL, DEFAULT, NULL,NULL);

-- ======================================
--  공지사항 추가
-- ======================================

--공지사항 카테고리 추가 필수
insert into M_POST_CATEG values(SEQ_M_POST_CATEG.nextval, '공지사항');
insert into M_POST_CATEG values(SEQ_M_POST_CATEG.nextval, '문의사항');
insert into M_POST_CATEG values(SEQ_M_POST_CATEG.nextval, '자주묻는 질문');



insert into M_POST values(SEQ_M_POST.nextval, 1, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 1, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 2, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 1, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 1, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 1, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 1, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 3, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 3, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 1, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 2, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
insert into M_POST values(SEQ_M_POST.nextval, 1, '개인정보 보호 방침 수정','개인정보 보호 방침이 수정 되었습니다.',sysdate);
commit;
select * from m_post;
-- ======================================
-- 문의 추가
-- ======================================
insert into ENQUIRY values(SEQ_ENQUIRY.nextval, 3, '개인정보 보호 방침',sysdate, '개인정보 보호 방침이 수정 되었습니다.',null, 'F');
insert into ENQUIRY values(SEQ_ENQUIRY.nextval, 5, '개인정보 보호 방침',sysdate, '개인정보 보호 방침이 수정 되었습니다.','확인했습니다', 'T');
insert into ENQUIRY values(SEQ_ENQUIRY.nextval, 4, '개인정보 보호 방침',sysdate, '개인정보 보호 방침이 수정 되었습니다.',null, 'F');
insert into ENQUIRY values(SEQ_ENQUIRY.nextval, 6, '개인정보 보호 방침',sysdate, '개인정보 보호 방침이 수정 되었습니다.',null, 'F');
insert into ENQUIRY values(SEQ_ENQUIRY.nextval, 6, '개인정보 보호 방침',sysdate, '개인정보 보호 방침이 수정 되었습니다.',null, default);
insert into ENQUIRY values(SEQ_ENQUIRY.nextval, 7, '하...........',sysdate, '개인정보 보호 방침이 수정 되었습니다.',null, default);
insert into ENQUIRY values(SEQ_ENQUIRY.nextval, 7, '하...........',sysdate, '개인정보 보호 방침이 수정 되었습니다.',null, default);


