package io.epam;

import java.io.IOException;

public interface TextEditor {
    String openText(String fileName) throws IOException;
    String editText(String content, String path);
}
