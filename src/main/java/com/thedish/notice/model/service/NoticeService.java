package com.thedish.notice.model.service;

import java.util.ArrayList;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.notice.model.vo.Notice;

public interface NoticeService {
	
	int selectListCount();
	ArrayList<Notice> selectList(Paging paging);
	Notice selectNotice(int noticeId);
	
	//메인페이지 목록 출력
	ArrayList<Notice> selectTop10();
	//dml -------------------------------------------
	void updateAddReadCount (int noticeId);
	
	//search
	int selectSearchTitleCount(String keyword);
	int selectSearchContentCount(String keyword);
	ArrayList<Notice> selectSearchTitle(Search search);
	ArrayList<Notice> selectSearchContent(Search search);
}
