package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	
	//@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	//@Test
	public void testInsert() {
		
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글입니다.");
		board.setContent("새로 작성하는 내용입니다.");
		board.setWriter("newbie");
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	//@Test
	public void testInsertSelectKey() {
		
		BoardVO board = new BoardVO();
		board.setTitle("���� �ۼ��ϴ� �� select Key");
		board.setContent("���� �ۼ��ϴ� �� with select Key");
		board.setWriter("newbie");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	

	@Test
	public void testRead() {
		//5번 게시물로 테스트
		BoardVO board = mapper.read(10000L);
		log.info(board); 
	}
	

	//@Test
	public void testDelete() {
		log.info("DELETE COUNT: "+mapper.delete(500L));
	}
	
	@Test
	public void testUpdate() {
		
		BoardVO board = new BoardVO();
		//10000번으로 테스트
		board.setBno(10000L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 글");
		board.setWriter("user00");
		
		int count = mapper.update(board);
		log.info("UPDATE COUNT:"+count);
	}
	
	/**
	@Test
	public void testPaging() {
		
		Criteria cri = new Criteria();
		List<BoardVO> list = mapper.getListWithPaging(cri); 
		list.forEach(board -> log.info(board.getBno()));
	} **/
	
	@Test
	public void testSearch() {
		
		Criteria cri = new Criteria();
		cri.setKeyword("");
		cri.setType("C");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}
}
