package io.epam;

import org.springframework.stereotype.Service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class LocalFsFileService implements FileService {


    @Override
    public List<FileContainer> listFiles(String directory) throws IOException {
        List<Path> files = Files.list(Path.of(directory)).collect(Collectors.toList());
        return files.stream()
                .map(file -> new FileContainer(file.toAbsolutePath().toString(), Files.isDirectory(file), file.toAbsolutePath().toString().endsWith(".txt") && Files.isRegularFile(file), Files.isReadable(file), Files.isWritable(file)))
                .collect(Collectors.toList());
    }

    @Override
    public void createFile(String path, boolean isRead, boolean isWrite, boolean isEx) throws IOException {
        File file = new File(path);
        file.createNewFile();
        file.setExecutable(isEx);
        file.setReadable(isRead);
        file.setWritable(isWrite);
        //Files.createFile(Path.of(path));

    }

    @Override
    public void createFile(String path, byte[] content) throws IOException {
        BufferedOutputStream stream =
                new BufferedOutputStream(new FileOutputStream(new File(path)));
        stream.write(content);
        stream.close();
    }


    @Override
    public void removeFile(String file) throws IOException {
        Files.delete(Path.of(file));
    }

    @Override
    public void createDirectory(String pathName) throws IOException {
        Path path = Paths.get(pathName);
        Files.createDirectory(path);

    }
}
