package com.icia.member.service;


import com.icia.member.dto.CommentDTO;
import com.icia.member.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    public void save(CommentDTO commentDTO) {
        commentRepository.save(commentDTO);
    }

    public List<CommentDTO> findAll(Long boardId) {

        return commentRepository.findAll(boardId);
    }

    public CommentDTO findById(Long id) {
        return commentRepository.findById(id);
    }

//    public void delete(CommentDTO commentDTO) {
//        commentRepository.delete(commentDTO);
//    }

    public void delete(Long id) {
        commentRepository.delete(id);
    }
}
