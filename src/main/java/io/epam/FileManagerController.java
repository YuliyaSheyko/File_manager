package io.epam;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;



import javax.servlet.http.HttpServletResponse;
import java.io.*;



@Configuration
@PropertySource("classpath:application.properties")
@Controller
public class FileManagerController implements WebMvcConfigurer {

    @Autowired
    private FileService fileService;

    @Autowired
    private FileCommentService commentService;

    @Autowired
    private TextEditor textEditor;

    @Value("${root.dir}")
    private String rootDir;

    @RequestMapping("/list")
    public String list(Model model, @RequestParam String directory) throws IOException {
        if (directory.startsWith(rootDir)) {
            String parent = directory.substring(0, directory.lastIndexOf('/'));
            model.addAttribute("parent", parent);
            model.addAttribute("files", fileService.listFiles(directory));
            model.addAttribute("directory", directory);
            return "listOfFiles";
        } else {
            return "redirect:/list?directory=" + rootDir;
        }
    }

    @RequestMapping("/remove")
    @ResponseStatus(HttpStatus.OK)
    public void remove(@RequestParam String file) throws IOException {
        commentService.removeComment(file);
        fileService.removeFile(file);
    }

    @RequestMapping(path = "/create", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    public void create(@RequestParam String newFile, @RequestParam boolean isRead,@RequestParam boolean isWrite, @RequestParam boolean isEx) throws IOException {
        commentService.removeComment(newFile);
        fileService.createFile(newFile,isRead, isWrite, isEx);
    }

    @RequestMapping(path = "/createDir", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    public void createDir(@RequestParam String pathD) throws IOException {
        fileService.createDirectory(pathD);
    }

    @RequestMapping(path = "/upload", method = RequestMethod.POST)
    public String upload(@RequestParam MultipartFile file, @RequestParam String directory) {
        if (!file.isEmpty()) {
            try {
                byte[] bytes = file.getBytes();
                fileService.createFile(directory + "/" + file.getOriginalFilename(), bytes);
                return "redirect:/list?directory=" + directory;
            } catch (Exception e) {
                return "You failed to upload " + file.getOriginalFilename() + " => " + e.getMessage();
            }
        } else {
            return "You failed to upload  " + file.getOriginalFilename() + " because the file is empty.";
        }
    }

     @ResponseBody
       @RequestMapping(path = "/create-comment", method = RequestMethod.POST)
       public void commentCreate(@RequestParam String comment, @RequestParam String path) {
           commentService.createComment(comment, path);
    }

    @ResponseBody
    @RequestMapping(path = "/resolve-comment", method = RequestMethod.GET)
    public String resolve(@RequestParam String path) {
        String comment = commentService.resolve(path);
        return comment;
    }

    @ResponseBody
    @RequestMapping(path="/download", method=RequestMethod.GET, produces = "application/octet-stream")
    public FileSystemResource download(@RequestParam String fileName, HttpServletResponse response) throws IOException {
        File file = new File(fileName);
        response.setHeader("Content-Disposition", "attachment; filename="+file.getName());
        return new FileSystemResource(fileName);
    }

    @ResponseBody
    @RequestMapping(path = "/edit-text", method = RequestMethod.POST)
    public String editText(@RequestParam String fileName) throws IOException {
       String everything = textEditor.openText(fileName);
       return everything;
    }

    @ResponseBody
    @RequestMapping(path = "/save-text", method = RequestMethod.POST)
    public String textSave(@RequestParam String text, @RequestParam String fileName) {
        textEditor.editText(text, fileName);
        return text;
       }

    @RequestMapping("/")
    public  String home() {
        return "redirect:/list?directory=" + rootDir;
    }

}

