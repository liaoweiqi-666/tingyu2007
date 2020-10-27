package com.sxt.tingyu.util;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;

/**
 * 阿里云发送短信工具类
 */
public class AliyunSendSmsUtils {


    /**
     * 生成随机码
     * @return
     */
    public static int getRandomCode(){
        return (int) (Math.random() * 999999);
    }


    /**
     * 发送短信方法
     * @param phone 手机号
     * @param randomCode 随机码
     * @return
     */
    public static String sendSms(String phone,int randomCode){
        /*配置发送短信基础信心*/
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAI4G7maL9SqXRzMRqDUebr", "c2eQXoSPV6kUAKDQ5KikP9LhwdPTon");
        IAcsClient client = new DefaultAcsClient(profile);

        /*短信请求对象*/
        CommonRequest request = new CommonRequest();
        /*设置发送方式*/
        request.setSysMethod(MethodType.POST);
        /*设置短信发送服务商域名*/
        request.setSysDomain("dysmsapi.aliyuncs.com");
        /*短信发送api的版本*/
        request.setSysVersion("2017-05-25");
        /*设置操作类型：SendSms 发送短信 */
        request.setSysAction("SendSms");
        /*设置区域*/
        request.putQueryParameter("RegionId", "cn-hangzhou");
        /*设置接收验证码手机号*/
        request.putQueryParameter("PhoneNumbers", phone);
        /*设置短信签名*/
        request.putQueryParameter("SignName", "ting域主持人");
        /*设置短信模板的code*/
        request.putQueryParameter("TemplateCode", "SMS_191816424");
        /*设置发送随机码*/
        request.putQueryParameter("TemplateParam", "{\"code\":\""+randomCode+"\"}");
        try {
            /*发送请求并返回相应对象*/
            CommonResponse response = client.getCommonResponse(request);
            /*获取相应的具体数据，json字符串*/
            System.out.println(response.getData());
            String data = response.getData();
            return  data;
            //{"Message":"OK","RequestId":"F8E5543B-FEDB-4F84-8D06-B51AB6785D1B","BizId":"251605002831464025^0","Code":"OK"}
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }
        return  null;
    }


    public static void main(String[] args) {



        for (int i = 0; i < 10; i++) {
            int randomCode  =   (int) (Math.random() * 999999);
            System.out.println(randomCode);
        }

    }
}
