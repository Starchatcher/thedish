package com.thedish.board.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.board.model.vo.Board;
import com.thedish.common.Paging;

@Repository("BoardDao")
public class BoardDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("boardMapper.selectListCount");
	}
	
	public ArrayList<Board> selectList (Paging paging){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectList", paging);
		return (ArrayList<Board>)list;
	}
	
}
