package com.thedish.image.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.thedish.image.model.service.ImageService;
import com.thedish.image.model.vo.Image;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/image")
public class ImageController {

    @Autowired
    private ImageService imageService;

    @RequestMapping(value = "/view.do", method = RequestMethod.GET)

    public void viewImage(@RequestParam("imageId") int imageId, HttpServletResponse response) throws IOException {
        Image image = imageService.selectImageById(imageId);

        if (image == null || image.getImageData() == null || image.getImageData().length == 0) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // imageType 필드가 없으면 기본값 사용
        String imageType = "jpeg";

        System.out.println("imageId: " + imageId + ", imageData length: " + image.getImageData().length + ", imageType: " + imageType);

        response.setContentType("image/" + imageType);

        // 캐시 방지 헤더 추가
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        try (ServletOutputStream out = response.getOutputStream()) {
            out.write(image.getImageData());
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

}
