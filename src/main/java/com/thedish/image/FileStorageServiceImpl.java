package com.thedish.image;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;

@Service
public class FileStorageServiceImpl implements FileStorageService {

    private final Path uploadDir = Paths.get("C:/upload"); // 저장 경로 설정

    @Override
    public String storeFileAndGetUrl(MultipartFile file) throws IOException {
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }

        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

        Path targetLocation = uploadDir.resolve(fileName);
        Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);

        // 예: 웹에서 접근 가능한 URL 경로 반환 (서버 설정에 따라 다름)
        return "/uploads/" + fileName;
    }
}
