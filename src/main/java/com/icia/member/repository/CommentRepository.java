package com.icia.member.repository;

import com.icia.member.dto.CommentDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommentRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public void save(CommentDTO commentDTO) {
        sql.insert("Comment.save", commentDTO);
    }

    public List<CommentDTO> findAll(Long boardId) {
        return sql.selectList("Comment.findAll", boardId);
    }

    public CommentDTO findById(Long id) {
        return sql.selectOne("Comment.findById",id);
    }

//    public void delete(CommentDTO commentDTO) {
//        sql.delete("Comment.delete", commentDTO);
//    }

    public void delete(Long id) {
        sql.delete("Comment.delete", id);
    }
}
