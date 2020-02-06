package org.zerock.mapper;

import java.util.List; 

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	
	public List<BoardVO> getListWithPaging(Criteria cri);

	public List<BoardVO> getList();
	
	public int getTotalCount(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);	//select 
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
}
