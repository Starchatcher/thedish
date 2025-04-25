package com.thedish.notice.model.service;

import java.util.ArrayList;

import com.thedish.common.Paging;
import com.thedish.notice.model.vo.Notice;

public interface NoticeService {
	
	int selectListCount();
	ArrayList<Notice> selectList(Paging paging);
	Notice selectNotice(int noticeId);
	//dml -------------------------------------------
	void updateAddReadCount (int noticeId);
}
