require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Fetion do
  class Fetion
    attr_accessor :mobile_no, :sid, :password, :status_code, :user_status, :user_id, :ssic, :nonce, :key, :signature, :response
  end

  before :each do
    @fetion = Fetion.new
  end

  after :each do
    FakeWeb.clean_registry
  end

  describe "login" do
    it "should login by mobile no" do
      @fetion.mobile_no = '15800681509'
      @fetion.password = 'password'
      FakeWeb.register_uri(:get, 'https://uid.fetion.com.cn/ssiportal/SSIAppSignInV4.aspx?mobileno=15800681509&domains=fetion.com.cn;m161.com.cn;www.ikuwa.cn&v4digest-type=1&v4digest=79cd56b93f21298dc8ae9d26de1258e3d6ce85a7', :body => %Q|<?xml version="1.0" encoding="utf-8" ?><results status-code="200"><user uri="sip:730020377@fetion.com.cn;p=6907" mobile-no="15800681509" user-status="101" user-id="390937727"><credentials><credential domain="fetion.com.cn" c="CBIOAAAm+FiuQgpcnFi+B4PZgtvTLcLwrzk84mf5XsP9hnneRVyMvEFuPpvTyfV2FFZfhJrCoiLYptvuSd9M95fwTUj4jRE6NuiE43EPl220u/chMyebsSbsUDxSjuJh1hXV76sAAA==" /><credential domain="m161.com.cn" c="CBAOAADowH3pYcBkGIkxcH56EXCIPEJmZ2EXyUKNoOM2xqaJ33i9d5fKaMYY9N7irpMmffobHQws5Eekiz/h+v9nuc3v6zzO8Pd0lIXzutXwzXCROw==" /><credential domain="www.ikuwa.cn" c="ChAOAABbuQDP66jvw7EVpUEjmgWcX/m+qx1KjApplisfSwro1Wp7Aj6Ngu6goEMEx4SHBj+ID4pf+shcudvrfr4C2fUJnmwovu4HZ3+Y1MvS96TtUQ==" /></credentials></user></results>|, :set_cookie => %Q|ssic=DhIOAADVEY68pV4EcRHsJ/GIIeltaYJsYJR2pj7b2+hCYLtgUd2j2mFaOqoqR98S3dm5pPH9t7W1yH5Cp/lVRP6VTwpLVvwxhhvj8qDz/p8rrW/Ljor6P4ZQKUZYz80JHjMt8R4AAA==; path=/|)
      @fetion.login

      @fetion.status_code.should == "200"
      @fetion.user_status.should == "101"
      @fetion.mobile_no.should == "15800681509"
      @fetion.user_id.should == "390937727"
      @fetion.sid.should == "730020377"
      @fetion.ssic.should == "DhIOAADVEY68pV4EcRHsJ/GIIeltaYJsYJR2pj7b2+hCYLtgUd2j2mFaOqoqR98S3dm5pPH9t7W1yH5Cp/lVRP6VTwpLVvwxhhvj8qDz/p8rrW/Ljor6P4ZQKUZYz80JHjMt8R4AAA=="
    end

    it "should login by sid" do
      @fetion.sid = "730020377"
      @fetion.password = 'password'
      FakeWeb.register_uri(:get, 'https://uid.fetion.com.cn/ssiportal/SSIAppSignInV4.aspx?sid=730020377&domains=fetion.com.cn;m161.com.cn;www.ikuwa.cn&v4digest-type=1&v4digest=79cd56b93f21298dc8ae9d26de1258e3d6ce85a7', :body => %Q|<?xml version="1.0" encoding="utf-8" ?><results status-code="200"><user uri="sip:730020377@fetion.com.cn;p=6907" mobile-no="15800681509" user-status="101" user-id="390937727"><credentials><credential domain="fetion.com.cn" c="CBIOAAAm+FiuQgpcnFi+B4PZgtvTLcLwrzk84mf5XsP9hnneRVyMvEFuPpvTyfV2FFZfhJrCoiLYptvuSd9M95fwTUj4jRE6NuiE43EPl220u/chMyebsSbsUDxSjuJh1hXV76sAAA==" /><credential domain="m161.com.cn" c="CBAOAADowH3pYcBkGIkxcH56EXCIPEJmZ2EXyUKNoOM2xqaJ33i9d5fKaMYY9N7irpMmffobHQws5Eekiz/h+v9nuc3v6zzO8Pd0lIXzutXwzXCROw==" /><credential domain="www.ikuwa.cn" c="ChAOAABbuQDP66jvw7EVpUEjmgWcX/m+qx1KjApplisfSwro1Wp7Aj6Ngu6goEMEx4SHBj+ID4pf+shcudvrfr4C2fUJnmwovu4HZ3+Y1MvS96TtUQ==" /></credentials></user></results>|, :set_cookie => %Q|ssic=DhIOAADVEY68pV4EcRHsJ/GIIeltaYJsYJR2pj7b2+hCYLtgUd2j2mFaOqoqR98S3dm5pPH9t7W1yH5Cp/lVRP6VTwpLVvwxhhvj8qDz/p8rrW/Ljor6P4ZQKUZYz80JHjMt8R4AAA==; path=/|)
      @fetion.login

      @fetion.status_code.should == "200"
      @fetion.user_status.should == "101"
      @fetion.mobile_no.should == "15800681509"
      @fetion.user_id.should == "390937727"
      @fetion.sid.should == "730020377"
      @fetion.ssic.should == "DhIOAADVEY68pV4EcRHsJ/GIIeltaYJsYJR2pj7b2+hCYLtgUd2j2mFaOqoqR98S3dm5pPH9t7W1yH5Cp/lVRP6VTwpLVvwxhhvj8qDz/p8rrW/Ljor6P4ZQKUZYz80JHjMt8R4AAA=="
    end

    it "should get login exception without ssic" do
      @fetion.mobile_no = '15800681509'
      @fetion.password = 'password'
      FakeWeb.register_uri(:get, 'https://uid.fetion.com.cn/ssiportal/SSIAppSignInV4.aspx?mobileno=15800681509&domains=fetion.com.cn;m161.com.cn;www.ikuwa.cn&v4digest-type=1&v4digest=79cd56b93f21298dc8ae9d26de1258e3d6ce85a7', :body => %Q|<?xml version="1.0" encoding="utf-8" ?><results status-code="200"><user uri="sip:730020377@fetion.com.cn;p=6907" mobile-no="15800681509" user-status="101" user-id="390937727"><credentials><credential domain="fetion.com.cn" c="CBIOAAAm+FiuQgpcnFi+B4PZgtvTLcLwrzk84mf5XsP9hnneRVyMvEFuPpvTyfV2FFZfhJrCoiLYptvuSd9M95fwTUj4jRE6NuiE43EPl220u/chMyebsSbsUDxSjuJh1hXV76sAAA==" /><credential domain="m161.com.cn" c="CBAOAADowH3pYcBkGIkxcH56EXCIPEJmZ2EXyUKNoOM2xqaJ33i9d5fKaMYY9N7irpMmffobHQws5Eekiz/h+v9nuc3v6zzO8Pd0lIXzutXwzXCROw==" /><credential domain="www.ikuwa.cn" c="ChAOAABbuQDP66jvw7EVpUEjmgWcX/m+qx1KjApplisfSwro1Wp7Aj6Ngu6goEMEx4SHBj+ID4pf+shcudvrfr4C2fUJnmwovu4HZ3+Y1MvS96TtUQ==" /></credentials></user></results>|)
      lambda { @fetion.login }.should raise_exception(Fetion::LoginException)
    end
  end

  describe "register" do
    before :each do
      @fetion.instance_variable_set(:@user_id, "390937727")
      @fetion.instance_variable_set(:@password, "password")
    end

    describe "register first" do
      it "should get nonce, key and signature" do
        FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=i&i=1", :body => "SIPP")
        FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=2", :body => "SIPP")
        response_body =<<EOF
SIP-C/4.0 401 Unauthoried
F: 730020377
I: 1
Q: 1 R
W: Digest algorithm="SHA1-sess-v4",nonce="1104E253661D71141DFE3FB020143E5A",key="A355B99E9EA38B7306331739A8EC57586FD4E8EC6C6D295C5EED3B6C3A84CB79889E6BED455ACBEDF68270C3FB23C9E54F0626118A09F06845E79248B4F3164E623F84722D5F8B2DFA75AD9454B7E169FB23D5F626C136CBABC6C2D910FDF56917FAFD73990013332CD87795C04799B5E75E2E6BC756D473FC39BD70BEC64D0D010001",signature="8039306257522D5DA4D5BCD0D6B04730A35E1225E9A5C37FD13804B8DAB40F356EA159A6FB2812C74CB5BB33D8764BF77EB10057E177CD2BD83DBBFD36FD30E652BA963B687DABC2E9FD994FADED19286D12C70065CA255528CBAE5D9B4CC087717ED32631FAFB9A2666C2A7356226A27C48E85C3E3580EB7671EA035FE320E0"

SIPP
EOF
        FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=3", :body => response_body)
        @fetion.register_first

        @fetion.nonce.should == "1104E253661D71141DFE3FB020143E5A"
        @fetion.key.should == "A355B99E9EA38B7306331739A8EC57586FD4E8EC6C6D295C5EED3B6C3A84CB79889E6BED455ACBEDF68270C3FB23C9E54F0626118A09F06845E79248B4F3164E623F84722D5F8B2DFA75AD9454B7E169FB23D5F626C136CBABC6C2D910FDF56917FAFD73990013332CD87795C04799B5E75E2E6BC756D473FC39BD70BEC64D0D010001"
        @fetion.signature.should == "8039306257522D5DA4D5BCD0D6B04730A35E1225E9A5C37FD13804B8DAB40F356EA159A6FB2812C74CB5BB33D8764BF77EB10057E177CD2BD83DBBFD36FD30E652BA963B687DABC2E9FD994FADED19286D12C70065CA255528CBAE5D9B4CC087717ED32631FAFB9A2666C2A7356226A27C48E85C3E3580EB7671EA035FE320E0"
        @fetion.response.size.should == 256
      end

      it "should raise no nonce exception" do
        FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=i&i=1", :body => "SIPP")
        FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=2", :body => "SIPP")
        response_body =<<EOF
SIP-C/4.0 401 Unauthoried
F: 730020377
I: 1
Q: 1 R
W: Digest algorithm="SHA1-sess-v4",nonce=""

SIPP
EOF
        FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=3", :body => response_body)
        lambda { @fetion.register_first }.should raise_exception(Fetion::NoNonceException)
      end
    end

    describe "register second" do
      before :each do
        @fetion.mobile_no = "15800681509"
        @fetion.user_id = "390937727"
        @fetion.response = "458F72ED91E149D28D8467772AB7AD366527B55AC1A10CD18BA1B9BD95F2E082B1594B6C9B116E0BDECC315A2ABA0F4DD20591BF305FCDCDA4CA7B6434EA7788B893E0BB26E4E02097B6707BE0BD60E704D560DDDCB539A3E6FD49B985631FCA02C44D09A6713358BF1D323BA62B5273C7096B97D6A75C6BF9708768FF0113D0"
        @fetion.instance_variable_set(:@seq, 3)
      end

      it "should get buddies" do
        FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=4", :body => "SIPP")
        response_body =<<EOF
SIP-C/4.0 200 OK
I: 1
Q: 2 R
X: 600
L: 5748

<results><client public-ip="118.132.146.9" login-place="" last-login-ip="118.132.146.9" last-login-place="" last-login-time="5/8/2010 1:45:21 PM"/><user-info><personal version="326631997" register-email="" user-id="390937727" sid="730020377" mobile-no="15800681509" uri="sip:730020377@fetion.com.cn;p=6907" name="" nickname="flyerhzm" gender="0" impresa="http://www.fetionrobot.com" portrait-crc="0" birth-date="1983-11-07" birthday-valid="0" carrier="CMCC" carrier-status="0" carrier-region="CN.sh.21." user-region="" profile="" blood-type="0" occupation="" hobby="" job-title="" home-phone="" work-phone="" other-phone="" personal-email="flyerhzm" work-email="" other-email="" primary-email="0" company="" company-website="" global-permission="identity=0;phone=0;email=1;birthday=1;business=0;presence=1;contact=1;location=3;buddy=2;ivr=2;buddy-ex=0;show=0;" sms-online-status="0.0:0:0" save-xeno-msg="0" email-binding-status="0" email-binding-alias="flyerhzm" set-pwd-question="0"/><configs><config name="weather-city">-1</config><config name="directsms-rec">0</config><config name="weather-region">CN.sh.21.</config><config name="alv2-setwarn">0</config></configs><custom-config version="326631997">H4sIAAAAAAAEAO29B2AcSZYlJi9tynt/SvVK1+B0oQiAYBMk2JBAEOzBiM3mkuwdaUcjKasqgcplVmVdZhZAzO2dvPfee++999577733ujudTif33/8/XGZkAWz2zkrayZ4hgKrIHz9+fB8/Ih6fVMvLvG6ytqiWr/O2LZYXR49fz6ur51mbN+0XedNkF3lz9Cwrm/zx3cg33PpNsaDPssXqlKBdf9FcHL2p19q+/93j43VbvcpX5fXpMpuU+cyA733+WLt5U73+4rVpFXzmYJ0tZ/m7ox0Pinzy+G50kF9U1ezlvM6avEnvOjAFhmRB8F/Pq+UFuhKkHt81f/PIaTxn52/y8nVbrXwqBZ8/Plk3bbX4bp6187w2KBCq0c8fPy3qfNpSF6/yZl22Bmz3Y4Wa1y/rvMmXU8Y88tkXWbH8brGcVVe2h8/rar16cv1FNcuBhv8n9d6sykz+2EWv7k8e8ZfLsljmRNM2m7b0x7U/7P6XQqWqzp/mbVaUjccZ/qc0rX00nxeX+VerGTEcmOhomb9rifzhh49f58umcsQ7vsquv1yezcpce/I+8L78oliuiY+P7vsNzIfa7vW0zvPl64yYJ4Dlf/74y/NzDFl7UFKEH4Ztvl2t6+Zor9NIPn38ZN1QB8/WZSmdaL+9j4mA4bDfFKsO8WQqXlRtcX6NSQ7+fvyi8v/+7jxfog/tbuDLxy/yKxU+BaPNux8T9OCDHvj4t4/v9kfx7PTspfnjq+XbZXX1+K7/2f8DdlG53MIEAAA=</custom-config><contact-list version="326067976"><buddy-lists><buddy-list id="1" name="我的好友"/><buddy-list id="2" name="好友"/><buddy-list id="3" name="同学"/></buddy-lists><buddies><b i="222516658" u="sip:793401629@fetion.com.cn;p=1919" n="" l="3" f="0" r="1" o="1" p="identity=1;"/><b i="226911221" u="sip:572512981@fetion.com.cn;p=3544" n="" l="1" f="0" r="1" o="1" p="identity=1;"/><b i="227091544" u="sip:669700695@fetion.com.cn;p=3546" n="郭庆" l="3" f="0" r="1" o="0" p="identity=0;"/><b i="228358286" u="sip:660250260@fetion.com.cn;p=3854" n="蔡智武" l="3" f="0" r="1" o="0" p="identity=0;"/><b i="229415466" u="sip:737769829@fetion.com.cn;p=4078" n="ice" l="3" f="0" r="1" o="0" p=""/><b i="295098062" u="sip:638993408@fetion.com.cn;p=2242" n="" l="1" f="0" r="1" o="0" p="identity=1;"/><b i="296436724" u="sip:760087520@fetion.com.cn;p=2467" n="" l="3" f="0" r="1" o="1" p="identity=1;"/><b i="579113578" u="sip:838271744@fetion.com.cn;p=4805" n="" l="1" f="0" r="1" o="0" p="identity=0;"/><b i="665046562" u="sip:926157269@fetion.com.cn;p=12906" n="" l="1" f="0" r="1" o="0" p="identity=0;"/><b i="687455743" u="sip:881033150@fetion.com.cn;p=5493" n="" l="1" f="0" r="1" o="0" p="identity=0;"/><b i="714355089" u="sip:973921799@fetion.com.cn;p=12193" n="" l="1" f="0" r="1" o="0" p="identity=0;"/><b i="732743291" u="sip:480867781@fetion.com.cn;p=16105" n="" l="1" f="0" r="1" o="0" p="identity=0;"/></buddies><chat-friends></chat-friends><blacklist><k i="234374936" u="sip:590114188@fetion.com.cn;p=7222" n=""/><k i="300922541" u="sip:755180702@fetion.com.cn;p=3265" n=""/><k i="313256153" u="sip:730019733@fetion.com.cn;p=9066" n=""/><k i="320122831" u="sip:638009800@fetion.com.cn;p=5795" n=""/><k i="323662900" u="sip:733249322@fetion.com.cn;p=6482" n=""/></blacklist></contact-list><score value="3760" level="7" level-score="3718"/><services></services><quotas><quota-limit><limit name="max-buddies" value="300"/><limit name="max-groupadmin-count" value="2"/><limit name="max-joingroup-count" value="10"/></quota-limit><quota-frequency><frequency name="send-sms" day-limit="600" day-count="10" month-limit="10000" month-count="91"/></quota-frequency></quotas><capability-list basic-caps="1ffff" contact-caps="ffffff" extended-caps="201fff"><contact carrier="CMCC" contact-caps="ffffff" /><contact carrier="CMHK" contact-caps="9ffc9f" /><contact carrier="CMPAK" contact-caps="857c88" /><contact carrier="HK.OTHER" contact-caps="0" /><contact carrier="" contact-caps="a57008" /><contact carrier="SGSH" contact-caps="9ffc9f" /><contact carrier="SGST" contact-caps="9ffc8f" /></capability-list></user-info><credentials kernel="bBTFdUfekBbVDSRJtp+YybH4bb6D1ZUcUNbJqSZ3WtZlVM8kp4xMRY1TUQjJk4fExbvlncxqB1roH71hpvBM7KLrfBkK+3I6C88mjHfNfoloO7ttuQ5RaI6mlyjS0sdsMW4uO3K5yc+Mr/JiNi06FZZIT457dwMt//iei46YeNphEYfgnon9sJOUC6OeRmeo"><credential domain="fetion.com.cn" c="tzTavUsAZdgV45arZ3NoRxlRxk6I4cOcQEnCs1YdcX6oOe//dwqS7FtyluXcfY+sv3eB4CVQR4gh5IqxzTENVGz8+N4L6vqTHuUJ+/VOr8MkRQDn17nKA+bbfbsi1EwT6u8tSMpNFC+wuUZhbXf4/L826iyCFb9jAY6NagME2nSeScIquJp68de7siHz2/tT"/><credential domain="m161.com.cn" c="GZlt16RoTSmDL6e/q3nNL6uahTF1zvo8SZ/FNuiZuRMsB0Y3Rc//9QhhaxUw0vRJLvm3BbHoaKQpAp5lVRfDKdKbKvtOjVhnl/EjbXAVqiSjt6mQYAnVy6FHUKOAyLd1J5yJMo57Zh0GWqeyPHnsaoP8xOnCrarboFaDbfK/12o="/><credential domain="www.ikuwa.cn" c="cVNfOTZIVlQHA0ZLXZKMnO0ZNS3fIH38O+YiqhbX2JuVBPERbNyjFBJW0cKYGsYMiuGmnGt8h9epgLXeUerrVk0P4DGdp9RVLh3XJ5yy/yOSwiYsUqM0I1qq3k0MWzD4xrkmnhUm1uThDNrPoOHK+Zw21nnDvpS+yVof6qduWg0="/><credential domain="games.fetion.com.cn" c="jP2F8PKfgoKrybCvK8YuNbpzWtRicTtoQHrK+UojMmAiEQK4U3erRDt3EGhC2RAWw18Zsf9M/7bK3FiujH4I8Tj5PgXdchPnoI2BXg+XhMCLqzMVc62QSw8JyFJZCao1R10kuERr1gDtd+6V/iLe1oVXymWallXBrekON44/8QrBuE07saSHM8dAEUHvA0ia"/></credentials></results>BN 730020377 SIP-C/4.0
N: SyncUserInfoV4
I: 1
Q: 1 BN
L: 125

<events><event type="SyncUserInfo"><user-info><score value="3760" level="7" level-score="3718"/></user-info></event></events>SIPP
EOF
        FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=5", :body => response_body)
        @fetion.register_second

        @fetion.nickname.should == "flyerhzm"
      end
    end
  end

  describe "get contacts" do
    before :each do
      @fetion.instance_variable_set(:@seq, 5)
    end

    it "should get all contacts" do
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=6", :body => "SIPP")
      response_body =<<-EOF
SIP-C/4.0 200 OK
I: 3
Q: 1 S
L: 59

<results><group-list  version ="1" ></group-list></results>SIPP
EOF
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=7", :body => "SIPP")
      response_body =<<-EOF
SIP-C/4.0 200 OK
I: 4
Q: 1 SUB

BN 730020377 SIP-C/4.0
N: PresenceV4
I: 1
L: 322
Q: 2 BN

<events><event type="PresenceChanged"><contacts><c id="222516658"><p v="0" sid="793401629" su="sip:793401629@fetion.com.cn;p=1919" m="13601804916" c="CMCC" cs="0" s="1" l="0" svc="" n="Peter" i="人生哈哈哈" p="428986348" sms="0.0:0:0" sp="0" sh="0"/><pr di="" b="0" d="" dt="" dc="0"/></c></contacts></event></events>BN 730020377 SIP-C/4.0
N: PresenceV4
I: 1
L: 329
Q: 3 BN

<events><event type="PresenceChanged"><contacts><c id="229415466"><p v="0" sid="737769829" su="sip:737769829@fetion.com.cn;p=4078" m="13817731963" c="CMCC" cs="0" s="1" l="8" svc="" n="ice" i="" p="-2000590228" sms="0.0:0:0" sp="0" sh="0"/><pr di="PCCL030516427968" b="400" d="" dt="PC" dc="137"/></c></contacts></event></events>BN 730020377 SIP-C/4.0
N: PresenceV4
I: 1
L: 303
Q: 4 BN

<events><event type="PresenceChanged"><contacts><c id="228358286"><p v="0" sid="660250260" su="sip:660250260@fetion.com.cn;p=3854" m="13795359343" c="CMCC" cs="0" s="1" l="4" svc="" n="蔡智武" i="" p="0" sms="0.0:0:0" sp="0" sh="0"/><pr di="" b="0" d="" dt="" dc="0"/></c></contacts></event></events>BN 730020377 SIP-C/4.0
N: PresenceV4
I: 1
L: 643
Q: 5 BN

<events><event type="PresenceChanged"><contacts><c id="390937727"><p v="0" cs="0" n="flyerhzm" i="http://www.fetionrobot.com" sms="0.0:0:0" sp="0"/></c><c id="665046562"><p v="0" sid="926157269" su="sip:926157269@fetion.com.cn;p=12906" m="" c="CMCC" cs="0" s="1" l="0" svc="" n="黄雅莉" i="" p="0" sms="10099.12:57:24" sp="0" sh="0"/><pr di="" b="0" d="" dt="" dc="0"/></c><c id="227091544"><p v="0" sid="669700695" su="sip:669700695@fetion.com.cn;p=3546" m="13764589545" c="CMCC" cs="0" s="1" l="10" svc="" n="郭庆" i="looloo" p="598224859" sms="0.0:0:0" sp="0" sh="0"/><pr di="" b="0" d="" dt="" dc="0"/></c></contacts></event></events>BN 730020377 SIP-C/4.0
N: PresenceV4
I: 1
L: 338
Q: 6 BN

<events><event type="PresenceChanged"><contacts><c id="296436724"><p v="0" sid="760087520" su="sip:760087520@fetion.com.cn;p=2467" m="13656681075" c="CMCC" cs="0" s="1" l="5" svc="" n="蒋健" i="TD只需成功，不许失败" p="2074595345" sms="0.0:0:0" sp="0" sh="0"/><pr di="" b="0" d="" dt="" dc="0"/></c></contacts></event></events>BN 730020377 SIP-C/4.0
N: PresenceV4
I: 1
L: 291
Q: 7 BN

<events><event type="PresenceChanged"><contacts><c id="732743291"><p v="0" sid="480867781" su="sip:480867781@fetion.com.cn;p=16105" m="" c="" cs="1" s="1" l="0" svc="" n="黄志敏" i="" p="0" sms="365.0:0:0" sp="0" sh="1"/><pr di="" b="0" d="" dt="" dc="0"/></c></contacts></event></events>BN 730020377 SIP-C/4.0
N: PresenceV4
I: 1
L: 369
Q: 8 BN

<events><event type="PresenceChanged"><contacts><c id="226911221"><p v="0" sid="572512981" su="sip:572512981@fetion.com.cn;p=3544" m="13764325001" c="CMCC" cs="0" s="1" l="10" svc="" n="陈勇sh" i="http://slide.news.sina.com.cn/c/slide_1_797_11165.html#p=1" p="-98773891" sms="0.0:0:0" sp="0" sh="0"/><pr di="" b="0" d="" dt="" dc="0"/></c></contacts></event></events>BN 730020377 SIP-C/4.0
N: PresenceV4
I: 1
L: 300
Q: 9 BN

<events><event type="PresenceChanged"><contacts><c id="295098062"><p v="0" sid="638993408" su="sip:638993408@fetion.com.cn;p=2242" m="13634102006" c="CMCC" cs="0" s="1" l="0" svc="" n="梦妍" i="" p="0" sms="0.0:0:0" sp="0" sh="0"/><pr di="" b="0" d="" dt="" dc="0"/></c></contacts></event></events>BN 730020377 SIP-C/4.0
N: SystemNotifyV4
L: 84
I: 1
Q: 10 BN

<events><event type="MobileMailBoxChanged"><mail unread-count="1"/></event></events>SIPP
EOF
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=8", :body => response_body)
      response_body =<<-EOF
SIP-C/4.0 200 OK
I: 5
Q: 1 S
L: 835

<results><topic-list event="RecommendGroupTopic" version="171" max-count="5"><topic title="陌上人如玉 韩庚世无双" url="http://group.fetion.com.cn/topic/common/31333572/196313?c=[c:m161.com.cn]" create-date="2010-5-6 15:36:30" id="171" topic-type="1"  /><topic title="世博园10大最美景观" url="http://group.fetion.com.cn/topic/common/8249155/196251?c=[c:m161.com.cn]" create-date="2010-5-6 15:33:49" id="170" topic-type="1"  /><topic title="诺基亚价值百万的手机" url="http://group.fetion.com.cn/topic/common/7366464/196288?c=[c:m161.com.cn]" create-date="2010-5-6 15:31:57" id="169" topic-type="1"  /><topic title="选秀调查：伪娘的真相" url="http://group.fetion.com.cn/topic/common/30660603/196323?c=[c:m161.com.cn]" create-date="2010-5-6 15:22:51" id="168" topic-type="1"  /></topic-list></results>SIPP
EOF
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=9", :body => response_body)
      response_body =<<-EOF
SIP-C/4.0 200 OK
I: 6
Q: 1 S
L: 61

<results><contacts version="326661305" ></contacts></results>SIPP
EOF
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=10", :body => response_body)
      @fetion.get_contacts
      @fetion.contacts.collect {|contact| contact.sid}.should == ["793401629", "737769829", "660250260", "926157269", "669700695", "760087520", "480867781", "572512981", "638993408"]
    end
  end

  describe "send msg" do
    before :each do
      @fetion.instance_variable_set(:@seq, 10)
    end

    it "should send msg to receiver" do
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=11", :body => 'SIPP')
      response_body =<<-EOF
SIP-C/4.0 200 OK
I: 7
Q: 3 M
D: Sat, 08 May 2010 14:51:55 GMT
XI: 925d6e3837b7410f9187ae66853e9a25
T: sip:638993408@fetion.com.cn;p=2242

SIPP
EOF
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=12", :body => response_body)
      @fetion.send_msg('sip:638993408@fetion.com.cn;p=2242', 'test')
    end
  end

  describe "send sms" do
    before :each do
      @fetion.instance_variable_set(:@seq, 10)
    end

    it "should send sms to receiver" do
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=11", :body => 'SIPP')
      response_body =<<-EOF
SIP-C/4.0 280 Send SMS OK
T: sip:730020377@fetion.com.cn;p=6907
I: 9
Q: 1 M

SIPP
EOF
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=12", :body => response_body)
      @fetion.send_sms('sip:638993408@fetion.com.cn;p=2242', 'test')
    end
  end

  describe "set schedule sms" do
    before :each do
      @fetion.instance_variable_set(:@seq, 10)
    end

    it "should set schedule sms to receiver" do
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=11", :body => 'SIPP')
      response_body =<<-EOF
SIP-C/4.0 200 OK
I: 11
Q: 1 S
L: 92

<results><schedule-sms-list version="36"/><schedule-sms id="2124923" version="1"/></results>SIPP
EOF
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=12", :body => response_body)
      @fetion.set_schedule_sms('sip:638993408@fetion.com.cn;p=2242', 'test', Time.at(Time.now + 24*60*60))
    end
  end

  describe "add buddy" do
    before :each do
      @fetion.instance_variable_set(:@seq, 11)
      @fetion.instance_variable_set(:@nickname, 'flyerhzm')
    end

    it "should add buddy" do
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=12", :body => 'SIPP')
      response_body =<<-EOF
SIP-C/4.0 200 OK
I: 16
Q: 1 S
L: 320

<results><contacts version="326679363"><buddies><buddy uri="sip:638993408@fetion.com.cn;p=2242" local-name="" buddy-lists="1" online-notify="0" desc="flyerhzm" relation-status="0" user-id="295098062" addbuddy-phrase-id="0" status-code="200" permission-values="" basic-service-status="1" /></buddies></contacts></results>BN 730020377 SIP-C/4.0
N: SyncUserInfoV4
I: 1
Q: 17 BN
L: 248

<events><event type="SyncUserInfo"><user-info><contact-list version="326679363"><buddies><buddy action="update" user-id="295098062" uri="sip:638993408@fetion.com.cn;p=2242" relation-status="1"/></buddies></contact-list></user-info></event></events>BN 730020377 SIP-C/4.0
N: PresenceV4
I: 1
L: 329
Q: 18 BN

<events><event type="PresenceChanged"><contacts><c id="295098062"><p v="326156919" sid="638993408" su="sip:638993408@fetion.com.cn;p=2242" m="13634102006" c="CMCC" cs="0" s="1" l="0" svc="" n="梦研" i="" p="0" sms="0.0:0:0" sp="0" sh="0"/><pr di="PCCL030333103486" b="400" d="" dt="PC" dc="17"/></c></contacts></event></events>SIPP
EOF
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=13", :body => response_body)
      @fetion.add_buddy(:friend_mobile => '13634102006')
    end
  end

  describe "get contact info" do
    before :each do
      @fetion.instance_variable_set(:@seq, 11)
    end

    it "should get contact info" do
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=12", :body => 'SIPP')
      response_body =<<-EOF
SIP-C/4.0 200 OK
I: 11
Q: 1 S
L: 166

<results><contact uri="tel:15800681507" version="0" user-id="625007505" mobile-no="15800681507" basic-service-status="0" carrier="CMCC" carrier-status="0"/></results>SIPP
EOF
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=13", :body => response_body)
      @fetion.get_contact_info(:friend_mobile => '15800681507')
    end

    it "should get exception when no such user" do
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=12", :body => 'SIPP')
      response_body =<<-EOF
SIP-C/4.0 404 Not Found
I: 35
Q: 1 S

SIPP
EOF
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=13", :body => response_body)
      lambda {@fetion.get_contact_info(:friend_mobile => '15800681505')}.should raise_exception(Fetion::NoUserException)
    end
  end

  describe "logout" do
    before :each do
      @fetion.instance_variable_set(:@seq, 12)
    end

    it "should logout" do
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=13", :body => '')
      FakeWeb.register_uri(:post, "http://221.176.31.39/ht/sd.aspx?t=s&i=14", :body => '')
    end
  end
end