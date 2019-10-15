package io.epam;

import java.io.File;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.List;

public interface FileService {

    class FileContainer{
        public String path;
        public boolean isDirectory;
        public boolean isTxt;
        public boolean isRead;
        public boolean isWrite;

        public FileContainer(String path, boolean isDirectory, boolean isTxt, boolean isRead, boolean isWrite) {
            this.path = path;
            this.isDirectory = isDirectory;
            this.isTxt = isTxt;
            this.isRead = isRead;
            this.isWrite = isWrite;
        }

        public String getPath() {
            return path;
        }

        public boolean getIsDirectory() {
            return isDirectory;
        }

        public boolean getIsTxt() {
            return isTxt;
        }

        public boolean getisRead() { return isRead; }

        public boolean getisWrite() { return isWrite; }
    }

    List<FileContainer> listFiles(String directory) throws IOException;

    void createFile(String path, boolean isRead, boolean isWrite, boolean isEx) throws IOException;

    void createFile(String path, byte[] content) throws IOException;

    void removeFile(String path) throws IOException;

    void createDirectory(String path) throws IOException;
}
