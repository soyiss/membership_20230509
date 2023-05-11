package com.icia.member.controller;


import com.icia.member.dto.BoardDTO;
import com.icia.member.dto.MemberDTO;
import com.icia.member.service.BoardService;
import com.icia.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    @Autowired
    private MemberService memberService;

    @GetMapping("/write")
    public String boardWriteForm(HttpSession session, Model model){
        String loginEmail = (String)session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByMemberEmail(loginEmail);
        System.out.println("nav에 있는 write 누르면 memberDTO = " + memberDTO);
        model.addAttribute("member", memberDTO);
        return "/boards/boardWrite";
    }
    @PostMapping("/write")
    public String boardWriter(HttpSession session, @ModelAttribute BoardDTO boardDTO){
        String loginEmail = (String)session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByMemberEmail(loginEmail);
        boardDTO.setMemberId(memberDTO.getId());
        System.out.println("boardDTO = " + boardDTO);
        boardService.save(boardDTO);
        return"/boards/boardWrite";
    }
    @GetMapping("/boardList")
    public String boardList(){
        return "/boards/boardList";
    }
}
