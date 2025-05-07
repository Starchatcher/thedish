package com.thedish.like.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thedish.like.model.service.LikeService;
import com.thedish.like.model.vo.Like;


@Controller
public class LikeController {

	@Autowired
	private LikeService likeService;
	
	//클라이언트가 보낸 json 객체를 받아서 처리하는 컨트롤러 메소드
	//요청에 대한 응답으로 ResponseEntity 사용할 수 있음, Http 상태 코드도 함께 보낼 때 사용함
	//메소드 메개변수로 @RequestBody 를 통해 json 이 자동으로 Notice 객체로 매핑됨
	@RequestMapping("toggleLike.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> toggleLike(@RequestBody Like like) {
	    Map<String, Object> result = new HashMap<>();

	    if (likeService.checkLike(like) > 0) {
	        likeService.deleteLike(like);
	        result.put("status", "unliked");
	    } else {
	        likeService.insertLike(like);
	        result.put("status", "liked");
	    }

	    int likeCount = likeService.countLikes(like.getTargetId());
	    result.put("likeCount", likeCount);

	    return new ResponseEntity<Map<String, Object>>(result, HttpStatus.OK);
	}
}
