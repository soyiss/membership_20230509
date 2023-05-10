package com.icia.member.controller;

import com.icia.member.dto.MemberDTO;
import com.icia.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
//공통된 주소값을 밖으로 뺄 수있다
@RequestMapping("/member")
public class MemberController {
    @Autowired
    private MemberService memberService;

    @GetMapping("/save")
    public String saveForm(){
        return "memberSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute MemberDTO memberDTO) throws IOException {
        System.out.println("memberDTO = " + memberDTO);
        memberService.save(memberDTO);
        return "success";
    }

    @PostMapping("/email-check")
    public ResponseEntity emailCheck(@RequestParam("memberEmail") String memberEmail) {
        System.out.println("중복체크 memberEmail = " + memberEmail);
        MemberDTO memberDTO = memberService.findByMemberEmail(memberEmail);
        if(memberEmail.length() == 0){
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else if (memberDTO == null) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @GetMapping("/login")
    public String loginForm(){
        return "memberLogin";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberDTO memberDTO, HttpSession session){
        boolean loginResult = memberService.login(memberDTO);
        // loginResult가 true이면
        if(loginResult){
            session.setAttribute("loginEmail", memberDTO.getMemberEmail());
            return "memberMy";
        }else{
            return "LoginFalse";
        }
    }

    @GetMapping("/myPage")
    public String myPage(){
        return "memberMy";
    }

    @GetMapping("/updatePass")
    public String updateForm(HttpSession session, Model model){
        String loginEmail = (String)session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByMemberEmail(loginEmail);
        model.addAttribute("member", memberDTO);
        return "memberUpdatePass";
    }

    @PostMapping("/updatePass")
    public String updatePass(HttpSession session, Model model){
        String loginEmail = (String)session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByMemberEmail(loginEmail);
        model.addAttribute("member", memberDTO);
        return "memberUpdate";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute MemberDTO memberDTO){
        memberService.update(memberDTO);
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 세션에 담긴 값 전체 삭제
        session.invalidate();
        return "redirect:/";
    }

}
