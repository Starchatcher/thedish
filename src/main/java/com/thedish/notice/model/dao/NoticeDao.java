package com.thedish.notice.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.common.Paging;
import com.thedish.common.Search;
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
	
	public int selectSearchTitleCount(String keyword) {
		return sqlSessionTemplate.selectOne("noticeMapper.selectSearchTitleCount", keyword);
	}
	
	public int selectSearchContentCount(String keyword) {
		return sqlSessionTemplate.selectOne("noticeMapper.selectSearchContentCount", keyword);
	}
	
	public ArrayList<Notice> selectSearchTitle(Search search){
		List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectSearchTitle", search);
		return (ArrayList<Notice>)list;
	}
	
	public ArrayList<Notice> selectSearchContent(Search search){
		List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectSearchContent", search);
		return (ArrayList<Notice>)list;
	}
	
	// 최신 공지사항 10개 조회 (메인용)
	public ArrayList<Notice> selectTop10() {
	    List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectTop10");
	    return (ArrayList<Notice>) list;
	}
}
