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

