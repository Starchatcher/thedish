package com.thedish.image;

import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;

public interface FileStorageService {
    String storeFileAndGetUrl(MultipartFile file) throws IOException;
}