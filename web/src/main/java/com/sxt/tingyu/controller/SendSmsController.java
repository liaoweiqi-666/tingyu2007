package com.sxt.tingyu.controller;

import com.sxt.tingyu.util.AliyunSendSmsUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * 发送短信验证码控制器
 */
@Controller
public class SendSmsController {

    /**
     * 发送验证码
     *
     * @param phone
     * @return
     */
    @RequestMapping("/sendSms")
    @ResponseBody
    public Object sendSms(String phone, HttpSession session) {

        //1.生成随机码
        int randomCode = AliyunSendSmsUtils.getRandomCode();
        System.out.println(randomCode);
        //1.1将随机码存放到HttpSession
        session.setAttribute("randomCode", randomCode);
        //1.2设置一分钟有效期
        session.setMaxInactiveInterval(60);

        //2.发送验证码
        String result = AliyunSendSmsUtils.sendSms(phone, randomCode);

        return result;
    }

    /**
     * 检查验证码
     *
     * @param verifyCode
     * @return
     */
    @RequestMapping("/checkVerifyCode")
    @ResponseBody
    public boolean checkVerifyCode(String verifyCode, HttpSession session) {

        Integer randomCode = (Integer) session.getAttribute("randomCode");

        return verifyCode.equals(randomCode+"");

    }


}
