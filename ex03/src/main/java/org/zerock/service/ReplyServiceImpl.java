package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired) //spring 4.3부터 지원하는 자동주입은 멤버가 1개 일때만 가능하므로 @Setter로 의존성 주입을 해주야
	private BoardMapper boardMapper;
		
	@Transactional //리플 갯수 업데이트와 인설트는 하나의 트랜잭션임
	@Override
	public int register(ReplyVO vo) {
		log.info("register......" + vo); 
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		return mapper.insert(vo);
	}
	
	@Override
	public ReplyVO get(Long rno) {
		log.info("get......" + rno);
		return mapper.read(rno);
	}
	
	@Override
	public int modify(ReplyVO vo) {
		log.info("modify......" + vo);
		return mapper.update(vo);
	}

	@Transactional //댓글 카운트 감소와 댓글 삭제는 하나의 트랜잭션 
	@Override
	public int remove(Long rno) {
		log.info("remove......" + rno);
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}
	
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply List of a Board " + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(
		        mapper.getCountByBno(bno), 
		        mapper.getListWithPaging(cri, bno));
	}
	
}//class end
