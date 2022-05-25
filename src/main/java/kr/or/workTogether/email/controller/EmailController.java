package kr.or.workTogether.email.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.workTogether.common.util.ArticlePage;
import kr.or.workTogether.common.util.FileUpload;
import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.EmailVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.common.vo.NotificationVO;
import kr.or.workTogether.email.service.EmailService;
import kr.or.workTogether.notification.service.NotificationService;
import kr.or.workTogether.security.CustomUser;

@Controller
@RequestMapping("/email")
public class EmailController {

   private static final Logger logger = LoggerFactory.getLogger(EmailController.class);

   @Autowired
   EmailService emailService;
   @Autowired
   FileUpload fileUpload;
   @Autowired
   private NotificationService notiService;
   
   //메일 전송하기 GET
   @GetMapping("/sendMail")
   public String getSendMail( @ModelAttribute EmailVO emailVO,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      emailVO.setEmailSendId(userInfo.getUsername());
      
      return "email/sendMail";

   }
   
   //메일 전송하기 POST
   @PostMapping("/sendMail")
   public String PostSendMail( @Validated EmailVO emailVO,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      
      NotificationVO notiVO = new NotificationVO();
      
      int insertResult = 0;

      if (emailVO.getEmailTypeId().equals("메일전송")) {
         insertResult = emailService.sendMail(emailVO);
         
      }else {
         insertResult = emailService.unsentMail(emailVO);  //임시보관하기
      }
      String senduser =userInfo.getUsername();
      String receiveuser =emailVO.getEmailRcvId();
      String emailPK =emailVO.getEmailId();
      
      if (insertResult > 0) {
         // 파일 업로드
         MultipartFile[] uploadFile = emailVO.getUploadFile();
         String path = "email/" + emailVO.getEmailId();
         String atchRelId = emailVO.getEmailId();
         if (uploadFile != null && uploadFile.length>0) {
            List<String> insertFileNames = fileUpload.insert(path, uploadFile, atchRelId);
         }
         
         notiVO.setNotSender(senduser); //보내는사람ID
         notiVO.setNotReceiver(receiveuser); //받는사람ID
         notiVO.setNotTypeId("메일"); //알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미
         notiVO.setNotCntntId(emailPK); //알림해당글PK
         notiVO.setNotMsg("메일이 도착했습니다."); //알림내용

         //알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
         //예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
         String notUrl = "/email/reMailDetail?emailId="+emailPK;
         notiVO.setNotUrl(notUrl); 

         notiService.insertNoti(notiVO);
         
         
         return "redirect:/email/mainPage";
      }else {
         return "email/sendMail";
      }
      
   }

   //보낸 메일함 조회하기
   @RequestMapping("/sendMailBox")
   public String sendMailBox(Model model,
         @RequestParam(defaultValue = "1") int currentPage,
         @RequestParam(defaultValue = "7", required = false) int size,
         @RequestParam(required=false) String keyWord,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      
      int start = currentPage * size - (size - 1);
      int end = currentPage * size;
      
      // <key,value>
      Map<String, Object> map = new HashMap<String, Object>();
      
      map.put("currentPage", currentPage);
      map.put("size", size);
      map.put("start", start);
      map.put("end", end);
      map.put("keyWord", keyWord);
      map.put("emailSendId", userInfo.getUsername());
//      logger.info("Id ->"+userInfo.getUsername());
      //emailVO
      List<EmailVO> list = emailService.sendMailBox(map);
      
      // 보낸 메일함의 목록 행의 수
      int total = this.emailService.sendListCount(map);

      model.addAttribute("list", list);
      model.addAttribute("page", new ArticlePage(total, currentPage, size, 10, start, end));
      model.addAttribute("total", total);
      
      //forward
      return "email/sendMailBox";
   }
   
   //임시 보관함 조회하기
   @RequestMapping("/unsentMailBox")
   public String unsentMailBox(Model model,
         @RequestParam(defaultValue = "1") int currentPage,
         @RequestParam(defaultValue = "7", required = false) int size,
         @RequestParam(required=false) String keyWord,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      
      int start = currentPage * size - (size - 1);
      int end = currentPage * size;
      
      
      // <key,value>
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("currentPage", currentPage);
      map.put("size", size);
      map.put("start", start);
      map.put("end", end);
      map.put("keyWord", keyWord);      
      map.put("emailSendId", userInfo.getUsername());
      //emailVO
      List<EmailVO> list = emailService.unsentMailBox(map);
      
      int total = this.emailService.unsentListCount(map);
      model.addAttribute("list", list);
      model.addAttribute("page", new ArticlePage(total, currentPage, size, 10, start, end));
      model.addAttribute("total", total);
      //forward
      return "email/unsentMailBox";
   }
   
   //보낸 메일함 상세정보 조회하기
   //보낸 메일에 파일이 첨부되어 있었다면 파일을 다운로드 받을 수 있어야 한다. 
   @GetMapping("/sendMailDetail")
   public String sendMailDetail(Model model, @RequestParam String emailId,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("emailSendId",userInfo.getUsername());
      map.put("emailId",emailId);
      AttachVO senddownfile=this.emailService.sendDownFile(map);
      List<EmailVO> emailVO = this.emailService.sendMailDetail(emailId);

      model.addAttribute("emailVO", emailVO);
      model.addAttribute("senddownfile",senddownfile);
      // forward
      return "email/sendMailDetail";
   }
   
   // 임시보관함 상세정보 조회하기
   @GetMapping("/unsentMailDetail")
   public String unsentMailDetail(Model model, @RequestParam String emailId,@ModelAttribute EmailVO emailVO,
         AttachVO attachVO) {
      emailVO = this.emailService.unsentMailDetail(emailId);
      attachVO =this.emailService.selectAttach(emailId);
      
      model.addAttribute("emailVO", emailVO);
      model.addAttribute("attachVO",attachVO);
      
      return "email/unsentMailDetail";
   }

   // 보낸 메일 삭제하기
   @RequestMapping(value="/sendMaildelete")
   public String sendMailDel(@RequestParam String emailId,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("emailSendId", userInfo.getUsername());
      map.put("emailId",emailId);
      int result = this.emailService.sendMailDel(map);
      if (result > 0)
         return "redirect:/email/sendMailBox";
      else
         return "email/errorMessage";
   }

   // 임시보관 메일 삭제하기
   @RequestMapping("/unsentMailDel")
   public String unsentMailDel(@RequestParam String emailId,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("emailSendId", userInfo.getUsername());
      map.put("emailId",emailId);
      int result = this.emailService.unsentMailDel(map);
      if (result > 0)
         return "redirect:/email/unsentMailBox";
      else
         return "email/errorMessage";
   }
   
   //임시보관 메일을 전송완료시키기
   @PostMapping("/unsentMailSend")
   public String unsentMailSend(@ModelAttribute EmailVO emailVO) {
      
      int result = emailService.unsentMailSend(emailVO);
      logger.info("unsentMailSend result = " + result);
      logger.info("unsentMailSend emailVO = " + emailVO);
      
      if(result>0) {
         // 파일 업로드
         MultipartFile[] uploadFile = emailVO.getUploadFile();
         
         String path = "email/" + emailVO.getEmailId();
         String atchRelId = emailVO.getEmailId();
         if (uploadFile != null && uploadFile.length>0) {
            List<String> insertFileNames = fileUpload.insert(path, uploadFile, atchRelId);
         }
         return "redirect:/email/unsentMailBox";
      } else {
         return "email/errorMessage";
      }
   }
   
   //휴지통 목록 출력하기
   @RequestMapping("/trashMailBox")
   public String trashMailBox(Model model,
         @RequestParam(defaultValue = "1") int currentPage,
         @RequestParam(defaultValue = "7", required = false) int size,
         @RequestParam(required=false) String keyWord,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      
      int start = currentPage * size - (size - 1);
      int end = currentPage * size;
      
      // <key,value>
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("currentPage", currentPage);
      map.put("size", size);
      map.put("start", start);
      map.put("end", end);
      map.put("keyWord", keyWord);      
      map.put("emailRcvId",userInfo.getUsername());
      map.put("emailSendId",userInfo.getUsername());
      
      //emailVO
      List<EmailVO> list = emailService.trashMailBox(map);
      
      int total = this.emailService.trashListCount(map);
      
      model.addAttribute("list", list);
      model.addAttribute("page", new ArticlePage(total, currentPage, size, 10, start, end));
      model.addAttribute("total", total);
      
      //forward
      return "email/trashMailBox";
   }
   
   //휴지통 비우기 => 테이블 내 전체 삭제해버리기 
   @GetMapping("/deleteAll")
   public String deleteAll() {
      int result=this.emailService.deleteAll();
      if(result>0)
         return "redirect:/email/trashMailBox";
      else
         return "email/errorMessage";
   }
   
   //선택한 메일 복구하기 
   @ResponseBody
   @GetMapping("/restoreMail")
   public String restoreMail(@RequestParam(value = "resMailArr[]") List<String> resMailArr) {

      logger.info("list ==> " + resMailArr);

      int result = 0;
      for (String emailId : resMailArr) {
         result += this.emailService.restoreMail(emailId);
      }

      if (result == resMailArr.size()) {
         return "success";
      } else {
         return "fail";
      }
   }
   
   //체크박스 선택한 메일 삭제하기 (휴지통영구삭제)
   @ResponseBody
   @GetMapping("/deletechoice")
   public String deletechoice(@RequestParam(value="delMailArr[]")List<String> delMailArr) {
      int result=0;
      for (String emailId : delMailArr) {
         result+=this.emailService.deletechoice(emailId);
      }
      if(result == delMailArr.size()) {
         return "success";
      }else {
         return "fail";
      }
   }
   
   //체크박스로 선택한 메일만 삭제되도록 하기 (보낸메일함)
   @ResponseBody
   @GetMapping("/deletesendChoice")
   public String deletesendChoice(@RequestParam(value="delSendArr[]")List<String> delSendArr,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("emailSendId", userInfo.getUsername());
      
      int result=0;
      for (String emailId : delSendArr) {
         map.put("emailId",emailId);
         result+=this.emailService.deletesendChoice(map);
      }
      if(result==delSendArr.size()) {
         return "success";
      }else {
         return "fail";
      }
   }
   
   //체크박스로 선택한 메일만 삭제되도록 하기 (임시보관함)
   @ResponseBody
   @GetMapping("/deleteunsentChoice")
   public String deleteunsentChoice(@RequestParam(value="delUnsentArr[]")List<String> delUnsentArr,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("emailSendId", userInfo.getUsername());
      
      int result=0;
      for(String emailId :delUnsentArr ) {
         map.put("emailId",emailId);
         result+=this.emailService.deleteunsentChoice(map);
      }
      if(result==delUnsentArr.size()) {
         return "success";
      }else {
         return "fail";
      }
   }
   
   //받은 메일함 출력하기
   @RequestMapping("/reMailBox")
   public String reMailBox(Model model,
         @RequestParam(defaultValue = "1") int currentPage,
         @RequestParam(defaultValue = "7", required = false) int size,
         @RequestParam(required=false) String keyWord,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      
      int start = currentPage * size - (size - 1);
      int end = currentPage * size;
      
      
      // <key,value>
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("currentPage", currentPage);
      map.put("size", size);
      map.put("start", start);
      map.put("end", end);
      map.put("keyWord", keyWord);
      map.put("emailRcvId",userInfo.getUsername());
      
      //emailVO
      List<EmailVO> list = emailService.reMailBox(map);
      
      // 보낸 메일함의 목록 행의 수
      int total = this.emailService.reListCount(map);

      model.addAttribute("list", list);
      model.addAttribute("page", new ArticlePage(total, currentPage, size, 10, start, end));
      model.addAttribute("total", total);
      
      //forward
      return "email/reMailBox";
   }
   
   
   //체크박스로 선택한 메일만 삭제되도록 하기 (받은메일함)
   @ResponseBody
   @GetMapping("/deletereChoice")
   public String deletereChoice(@RequestParam(value="delreArr[]")List<String> delreArr,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("emailSendId",userInfo.getUsername());
      int result=0;
      for(String emailId :delreArr ) {
         map.put("emailId",emailId);
         result+=this.emailService.deletereChoice(map);
      }
      if(result==delreArr.size()) {
         return "success";
      }else {
         return "fail";
      }
   }
   
   // 받은메일함 상세정보 조회하기
   // 받은 메일에 파일이 첨부되어 있었다면 파일을 다운로드 받을 수 있어야 한다. 
   @GetMapping("/reMailDetail")
   public String reMailDetail(Model model, @RequestParam String emailId,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("emailRcvId",userInfo.getUsername());
      map.put("emailId",emailId);
      AttachVO redownfile=this.emailService.reDownFile(map);
      List<EmailVO> emailVO = this.emailService.reMailDetail(emailId); //받은메일의 상세정보를 보여줌 
      int result = this.emailService.readUpdate(emailId);  //메일 열람 여부를 업데이트 해줌
      int result2 = this.emailService.checkUpdate(emailId);
      model.addAttribute("emailVO", emailVO);
      model.addAttribute("redownfile",redownfile);
      
      
      //이 밑에 받은파일경로 받아짐 
      System.out.println("파일명 ----------------------------");
      System.out.println("redownfile - >"+redownfile);
      System.out.println("파일명 ----------------------------");
      
      if(result>0)
         return "email/reMailDetail";
      else
         return "email/errorMessage";
   }
   
   // 받은 메일 삭제하기
   @RequestMapping(value="/reMaildelete")
   public String reMailDel(@RequestParam String emailId,
         Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("emailSendId",userInfo.getUsername());
      map.put("emailId",emailId);
      int result = this.emailService.reMailDel(map);
      if (result > 0)
         return "redirect:/email/reMailBox";
      else
         return "email/errorMessage";
   }
   
   //받은메일 답장하기 GET
   @GetMapping("/resendNow")
   public String resendNow( Model model, @RequestParam String emailId, @ModelAttribute EmailVO emailVO) {
      List<EmailVO> emaillistVO = this.emailService.reMailDetail(emailId);
      model.addAttribute("emaillistVO", emaillistVO);
//      logger.info("emaillistVO: " + emaillistVO.toString());
      return "email/resendNow";

   }
   
   //받은메일 답장하기 POST
   @PostMapping("/resendNow")
   public String PostresendNow( @ModelAttribute EmailVO emailVO) {
//      model.addAttribute("emailVO",emailVO);
      logger.info("emailVO: " + emailVO.toString());
      int insertResult = 0;

      if (emailVO.getEmailTypeId().equals("메일전송"))
         insertResult = emailService.sendMail(emailVO);
      else
         insertResult = emailService.unsentMail(emailVO);  //임시보관하기
      if (insertResult > 0) {
         // 파일 업로드
         MultipartFile[] uploadFile = emailVO.getUploadFile();
         String path = "email/" + emailVO.getEmailId();
         String atchRelId = emailVO.getEmailId();
         if (uploadFile != null && uploadFile.length>0) {
            List<String> insertFileNames = fileUpload.insert(path, uploadFile, atchRelId);
         }
      
         return "redirect:/email/mainPage";
      }else {
         return "email/resendNow";
      }
   }
   
   //메인페이지 컨트롤러 
   @RequestMapping("/mainPage")
   public String MainPage(Model model, Authentication auth) {
      CustomUser user = (CustomUser) auth.getPrincipal();
      EmployeeVO userInfo = user.getUser();
      
      //map : {emailSendId=EMPL00001, emailRcvId=EMPL00001}
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("emailSendId", userInfo.getUsername());
      map.put("emailRcvId",userInfo.getUsername());
      
      List<EmailVO> relist = emailService.reMailMain(map); // 받은 메일함 select문
      List<EmailVO> sendlist = emailService.sendMailMain(map); // 보낸 메일함 select문
      List<EmailVO> unsentlist = emailService.unsentMailMain(map); // 임시보관함 select문
      List<EmailVO> trashlist = emailService.trashMailMain(map); // 휴지통 select문
      String Nocheck=emailService.noCheckCount(map);
      String recheck=emailService.reMailCount(map);
      String sendcheck=emailService.sendMailCount(map);
      String unsentcheck=emailService.unsentMailCount(map);
      String trashcheck=emailService.trashMailCount(map);
      
      System.out.println("==============================");
      System.out.println("relist : " + relist);
      System.out.println("sendlist : " + sendlist);
      System.out.println("unsentlist : " + unsentlist);
      System.out.println("trashlist : " + trashlist);
      System.out.println(Nocheck);
      System.out.println("==============================");
      
      model.addAttribute("relist", relist);
      model.addAttribute("sendlist", sendlist);
      model.addAttribute("unsentlist", unsentlist);
      model.addAttribute("trashlist", trashlist);
      model.addAttribute("Nocheck", Nocheck);
      model.addAttribute("recheck", recheck);
      model.addAttribute("sendcheck", sendcheck);
      model.addAttribute("unsentcheck", unsentcheck);
      model.addAttribute("trashcheck", trashcheck);
      
      return "email/mainPage";
   }
}