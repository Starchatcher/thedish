package com.thedish.notice.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.notice.model.dao.NoticeDao;
import com.thedish.notice.model.vo.Notice;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public int selectListCount() {
		return noticeDao.selectListCount();
	}

	@Override
	public ArrayList<Notice> selectList(Paging paging) {
		return noticeDao.selectList(paging);
	}

	@Override
	public Notice selectNotice(int noticeId) {
		return noticeDao.selectNotice(noticeId);
	}

	@Override
	public void updateAddReadCount(int noticeId) {
		noticeDao.updateAddReadDount(noticeId);
	}

	@Override
	public int selectSearchTitleCount(String keyword) {
		return noticeDao.selectSearchTitleCount(keyword);
	}

	@Override
	public int selectSearchContentCount(String keyword) {
		return noticeDao.selectSearchContentCount(keyword);
	}

	@Override
	public ArrayList<Notice> selectSearchTitle(Search search) {
		return noticeDao.selectSearchTitle(search);
	}

	@Override
	public ArrayList<Notice> selectSearchContent(Search search) {
		return noticeDao.selectSearchContent(search);
	}
	
	//메인페이지 출력
	@Override
	public ArrayList<Notice> selectTop10() {
	    return noticeDao.selectTop10();
	}

	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(notice);
	}

	@Override
	public int deleteNotice(int noticeId) {
		return noticeDao.deleteNotice(noticeId);
	}

	@Override
	public int updateNotice(Notice notice) {
		return noticeDao.updateNotice(notice);
	}
 
}
