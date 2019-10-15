package io.epam;

public interface FileCommentService {

    void createComment(String note, String path);
    void removeComment(String path);
    String resolve(String path);
}
