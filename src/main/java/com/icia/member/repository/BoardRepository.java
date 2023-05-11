package com.icia.member.repository;

import com.icia.member.dto.BoardDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardRepository {

    @Autowired
    private SqlSessionTemplate sql;

    public void save(BoardDTO boardDTO) {
        sql.insert("Board.save",boardDTO);
    }
}
