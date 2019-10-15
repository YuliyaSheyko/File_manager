package io.epam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class JdbcFileCommentService implements FileCommentService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public static class Note {
        private String comment;
        private String path;

        public Note(String comment, String path) {
            this.comment = comment;
            this.path = path;
        }

        public String getComment() {
            return comment;
        }

        public String getPath() {
            return path;
        }
    }

    @Override
    public void createComment(String note, String path) {
        if(note.isEmpty()) {
            jdbcTemplate.execute("INSERT INTO file_comments VALUES ('"+ note + "','" + path + "')");
        }
        else {
            jdbcTemplate.execute("DELETE FROM file_comments WHERE path='"+path+"'");
            jdbcTemplate.execute("INSERT INTO file_comments VALUES ('"+ note + "','" + path + "')");
        }
    }

    @Override
    public void removeComment(String path) {
        jdbcTemplate.execute("DELETE FROM file_comments WHERE path='"+path+"'");
    }

    @Override
    public String resolve(String path) {
        List<String> comment = jdbcTemplate.query("SELECT * FROM file_comments WHERE path='" + path +"'", (resultSet, i) -> resultSet.getString("comment"));
        if(comment.isEmpty())
            return "";
        return comment.get(0);

    }
}
