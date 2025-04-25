package com.thedish.notice.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.common.Paging;
import com.thedish.notice.model.vo.Notice;

@Repository("noticeDao")
public class NoticeDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("noticeMapper.selectListCount");
	}

	public ArrayList<Notice> selectList(Paging paging){
		List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectList", paging);
		return (ArrayList<Notice>)list;
	}
	
	public Notice selectNotice(int noticeId) {
		return sqlSessionTemplate.selectOne("noticeMapper.selectNotice", noticeId);
	}
	
	public void updateAddReadDount(int noticeId) {
		sqlSessionTemplate.update("noticeMapper.updateAddReadCount", noticeId);
	}
}
