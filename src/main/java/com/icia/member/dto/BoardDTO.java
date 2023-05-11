package com.icia.member.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.List;

@Getter
@Setter
@ToString
public class BoardDTO {

    private Long id;
    private Long memberId;
    private String boardTitle;
    private String boardWriter;
    private String boardContents;
    private int boardHits;
    private Timestamp boardCreatedDate;
    private int fileAttached;

    private List<MultipartFile> boardFile;


}
