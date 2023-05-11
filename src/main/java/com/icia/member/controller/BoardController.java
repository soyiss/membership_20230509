package com.icia.member.controller;


import com.icia.member.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/write")
    public String boardWrite(){
        return "/boards/boardWrite";
    }

    @GetMapping("/boardList")
    public String boardList(){
        return "/boards/boardList";
    }
}
