package com.icia.member.controller;


import com.icia.member.dto.BoardDTO;
import com.icia.member.dto.BoardFileDTO;
import com.icia.member.dto.MemberDTO;
import com.icia.member.dto.PageDTO;
import com.icia.member.service.BoardService;
import com.icia.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    @Autowired
    private MemberService memberService;

    @GetMapping("/write")
    public String boardWriteForm(HttpSession session, Model model) {
        String loginEmail = (String) session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByMemberEmail(loginEmail);
        System.out.println("nav에 있는 write 누르면 memberDTO = " + memberDTO);
        model.addAttribute("member", memberDTO);
        return "/boards/boardWrite";
    }

    @PostMapping("/write")
    public String boardWriter(HttpSession session, @ModelAttribute BoardDTO boardDTO) throws IOException {
        String loginEmail = (String) session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByMemberEmail(loginEmail);
        boardDTO.setMemberId(memberDTO.getId());
        System.out.println("boardDTO = " + boardDTO);
        boardService.save(boardDTO);
        return "redirect:/board/paging";
    }

    @GetMapping("/boardList")
    public String boardList(Model model) {
        List<BoardDTO> boardDTOList = boardService.findAll();
        model.addAttribute("boardList", boardDTOList);
        return "/boards/boardList";
    }

    // 페이징 처리를 위한 메소드
    // 사용자가 필요한 페이지가 몊인지 알아야디니까 파라미터로 page를 받아야된다
    //required = false를 써서 page는 필수 옵션이 아니여도된다고 하고 page 파라미터가 없으면 기본겂으로 1로 지정해줌
    //page에 특정값이 있으면 파라미터로 넘어오고 없으면 1로 세팅하겠다는 뜻
    @GetMapping("/paging")
    public String paging(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                         @RequestParam(value = "q", required = false, defaultValue = "") String q,
                         @RequestParam(value = "type",required = false, defaultValue = "boardTitle") String type,
                         Model model) {
        System.out.println("페이징 page = " + page + ", q = " + q+",type= "+type);
        List<BoardDTO> boardDTOList = null;
        PageDTO pageDTO = null;

        //검색어 q값이 없으면 일반 페이징 처리를해라
        if(q.equals("")){
            // 사용자가 요청한 페이지에 해당하는 글 목록 데이터
            // 사용자가 3페이지를 보고싶다 하면 3페이지에 해당하는 내용 목록들
            boardDTOList = boardService.pagingList(page);
            // 하단에 보여줄 페이지 번호 목록 데이터
            pageDTO = boardService.pagingParam(page);

        //검색어 q값이 있으면 검색어가 포함된 페이징 처리를 해라
        }else{
            // 검색어가 있으면 검색어가 포함된 페이징 처리를 해라
            boardDTOList = boardService.searchList(page,type,q);
            pageDTO = boardService.pagingSearchParam(page,type,q);
        }
        // 페이지에 들어가는 글 목록들
        model.addAttribute("boardList", boardDTOList);
        // 하단에 보여줄 페이지 목록들
        model.addAttribute("paging", pageDTO);
        model.addAttribute("q", q);
        model.addAttribute("type",type);
        return "boards/boardPaging";
    }

    @GetMapping("/detail")
    public String detailForm(@RequestParam("id") Long id,
                             @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                             Model model) {
        //조회수를 1씩 증가시키는 메소드이다
        boardService.updateHits(id);
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        model.addAttribute("page", page);
        if (boardDTO.getFileAttached() == 1) {
            // 파일이 있는 게시글을 선택하면
            List<BoardFileDTO> boardFileDTO = boardService.findFile(id);
            model.addAttribute("boardFileList", boardFileDTO);
            System.out.println("boardFileDTO = " + boardFileDTO);
        }
        return "boards/boardDetail";
    }

    @GetMapping("/update")
    public String updateForm(@RequestParam("id") Long id, Model model) {
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        return "/boards/boardUpdate";

    }

    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO, Model model) {
        System.out.println("수줭버튼 누른 후 boardDTO = " + boardDTO);
        boardService.update(boardDTO);
        //수정된 내용의 id를 findById메소드에 매개변수로 보낸후 dto변수에 담아옴
        BoardDTO dto = boardService.findById(boardDTO.getId());
        System.out.println("수정된dto = " + dto);
        model.addAttribute("board", dto);
        if (boardDTO.getFileAttached() == 1) {
            // 파일이 있는 게시글을 선택하면
            List<BoardFileDTO> boardFileDTO = boardService.findFile(dto.getId());
            model.addAttribute("boardFileList", boardFileDTO);
            System.out.println("boardFileDTO = " + boardFileDTO);
        }
        //resirect로 요청하면 수정한건데 조회수가 올라가니까 밑에 리턴처럼 해줘야됌
//        return "redirect:/board?id="+boardDTO.getId();

        //수정한 객체를 다시 모델에 담아가서 detail.jsp에 뿌려준다
        return "boards/boardDetail";
    }

    @GetMapping("/board_delete")
    public String delete(@RequestParam("id") Long id){
        BoardDTO boardDTO = boardService.findById(id);
        boardService.delete(boardDTO);
        return "redirect:/board/paging";
    }

}
