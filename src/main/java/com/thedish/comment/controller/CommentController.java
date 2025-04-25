package com.thedish.comment.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thedish.comment.model.service.CommentService;
import com.thedish.comment.model.vo.Comment;
import com.thedish.recipe.service.impl.RecipeService;

@Controller

public class CommentController {

	private static final Logger logger = LoggerFactory.getLogger(CommentController.class);

	@Autowired
	private RecipeService recipeService;

	@Autowired
	private CommentService commentService;

	
	// 레시피 댓글등록 처리용 
	@RequestMapping(value = "insertComment.do", method = RequestMethod.POST)
	public String insertComment(@RequestParam("recipeId") int recipeId, @RequestParam("content") String content,
			@RequestParam("writer") String writer) {

		logger.info("댓글 작성 요청: recipeId={}, writer={}, content={}", recipeId, writer, content);

		Comment comment = new Comment();
		comment.setTargetId(recipeId);
		comment.setTargetType("recipe");
		comment.setContent(content);
		comment.setLoginId(writer);

		commentService.insertComment(comment);

// 작성 후 레시피 상세 페이지로 리다이렉트
		return "redirect:/recipeDetail.do?no=" + recipeId + "&page=1";
	}
	
	
	// 레시피상세 페이지 댓글 삭제용
	@RequestMapping(value = "/deleteComment.do", method = RequestMethod.POST)
	public String deleteComment(@RequestParam("commentId") int commentId,
	                            @RequestParam("recipeId") int recipeId,
	                            @RequestParam("targetType") String targetType,
	                            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
	                            RedirectAttributes redirectAttributes) {

	    boolean isDeleted = commentService.deleteComment(commentId, targetType);

	    if (isDeleted) {
	        redirectAttributes.addFlashAttribute("message", "댓글이 삭제되었습니다.");
	    } else {
	        redirectAttributes.addFlashAttribute("message", "댓글 삭제에 실패했습니다.");
	    }

	    return "redirect:/recipeDetail.do?no=" + recipeId + "&page=" + page;
	}


	

	

}
