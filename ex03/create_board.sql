create database bbs deafult CHARACTER SET UTF8;

CREATE TABLE `tbl_board` (
  `bno` int(10) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `writer` varchar(50) NOT NULL,
  `regdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`bno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


 CREATE TABLE `tbl_reply` (
  `rno` int(10) NOT NULL DEFAULT '0',
  `bno` int(10) NOT NULL,
  `reply` varchar(1000) NOT NULL,
  `replyer` varchar(50) NOT NULL,
  `replyDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `replyfk01` (`bno`),
  CONSTRAINT `replyfk01` FOREIGN KEY (`bno`) REFERENCES `tbl_board` (`bno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/* seq_mysql 테이블 생성 */
CREATE TABLE seq_mysql(
id INT NOT NULL,
seq_name VARCHAR(50) NOT NULL
);

/* 생성된 펑션 삭제 */
DROP FUNCTION IF EXISTS get_seq;

/* Auto_increment 적용 */
DELIMITER $$
CREATE FUNCTION get_seq (p_seq_name VARCHAR(45))
RETURNS INT READS SQL DATA
BEGIN
DECLARE RESULT_ID INT;
UPDATE seq_mysql SET id = LAST_INSERT_ID(id+1)
WHERE seq_name = p_seq_name;
SET RESULT_ID = (SELECT LAST_INSERT_ID());
RETURN RESULT_ID;
END $$
DELIMITER ;

/* 시퀀스 생성 */
INSERT INTO seq_mysql
VALUES (0, 'boardSeq');

/* 시퀀스 삽입 */
get_seq('boardSeq')