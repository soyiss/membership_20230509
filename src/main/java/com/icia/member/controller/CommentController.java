package com.icia.member.controller;

import com.icia.member.dto.CommentDTO;
import com.icia.member.dto.MemberDTO;
import com.icia.member.service.CommentService;
import com.icia.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    public CommentService commentService;
    @Autowired
    public MemberService memberService ;



    @PostMapping("/save")
    public ResponseEntity saveForm(@ModelAttribute CommentDTO commentDTO ,HttpSession session){
        //프론트(boardDetail.jsp)에서 컨트롤러(CommentController)로 데이터가 잘 오는지 확인하는 과정(sout찍어보기)
        //sout에는 작성자, 댓글내용,보드아이디값,멤버아이디값이 콘솔에 잘 찍힘(서버에는 아직 저장되지 않아서 id,commentCreateDate는 null이 찍힌다
        //요류 없이 잘 넘어왔으면 이제 DB로 넘어가자!
        System.out.println("난난난commentDTO = " + commentDTO);
        String loginEmail = (String) session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByMemberEmail(loginEmail);
        boardDTO.setMemberId(memberDTO.getId());

        //서버로 가자~!
        commentService.save(commentDTO);

        //댓글목록 출력할 때 필요한 부분
        //해당 게시글에 작성된 댓글만 가져와야된다 (DB에서 그 게시글에 작성된 댓글만 가져와야되니까 매개변수가 필요하다)
        List<CommentDTO> commentDTOList = commentService.findAll(commentDTO.getBoardId());
        System.out.println("아아아commentDTOList = " + commentDTOList);
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }
}
