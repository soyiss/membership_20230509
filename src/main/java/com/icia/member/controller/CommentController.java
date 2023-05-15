package com.icia.member.controller;

import com.icia.member.dto.BoardDTO;
import com.icia.member.dto.BoardFileDTO;
import com.icia.member.dto.CommentDTO;
import com.icia.member.dto.MemberDTO;
import com.icia.member.service.CommentService;
import com.icia.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

        commentDTO.setMemberId(memberDTO.getId());

        //서버로 가자~!
        commentService.save(commentDTO);

        //댓글목록 출력할 때 필요한 부분
        //해당 게시글에 작성된 댓글만 가져와야된다 (DB에서 그 게시글에 작성된 댓글만 가져와야되니까 매개변수가 필요하다)
        List<CommentDTO> commentDTOList = commentService.findAll(commentDTO.getBoardId());
        System.out.println("아아아commentDTOList = " + commentDTOList);
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }

    @GetMapping("/comment_delete")
//    /board/detal로 주소를 다시 redirect 요청을 할때 page,q,type,boardId값이 필요해서 같이 보내줘야되는데
//    model에는 detail에서 이미 파라미터를 담아서 안써도된다 보내주기만 하면된다
//    리다이렉트로 재요청할때 commentId는 보드디티오에는 없는 값이므로 주소에 같이 안보내줘도된다
    public String delete(@RequestParam("id") Long id,
                         @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                         @RequestParam(value = "q", required = false, defaultValue = "") String q,
                         @RequestParam(value = "type",required = false, defaultValue = "boardTitle") String type,
                         @RequestParam("boardId") Long boardId){
        System.out.println("id = " + id);
        System.out.println("boardId = " + boardId);
        commentService.delete(id);
        System.out.println("id = " + id);
        return "redirect:/board/detail?id=" + boardId + "&page=" + page + "&q="+ q +"&type="+type;
    }
}
