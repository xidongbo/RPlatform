<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <title>RPlatform</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome.css">

    <script src="lib/jquery-1.11.1.min.js" type="text/javascript"></script>

    

    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium.css">

</head>
<body class=" theme-blue">

    <!-- Demo page code -->

    <script type="text/javascript">
        $(function() {
            var match = document.cookie.match(new RegExp('color=([^;]+)'));
            if(match) var color = match[1];
            if(color) {
                $('body').removeClass(function (index, css) {
                    return (css.match (/\btheme-\S+/g) || []).join(' ')
                })
                $('body').addClass('theme-' + color);
            }

            $('[data-popover="true"]').popover({html: true});
            
        });
    </script>
    <style type="text/css">
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .navbar-default .navbar-brand, .navbar-default .navbar-brand:hover { 
            color: #fff;
        }
    </style>

    <script type="text/javascript">
        $(function() {
            var uls = $('.sidebar-nav > ul > *').clone();
            uls.addClass('visible-xs');
            $('#main-menu').append(uls.clone());
        });
    </script>

  

     <div class="navbar navbar-default" role="navigation">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="" href="index.jsp"><span class="navbar-brand"><span class="fa fa-life-ring"></span> RPlato</span></a></div>

       <%
            if((String)request.getSession().getAttribute("username")!=null){                   
        %>
	        <div  navbar-collapse collapse" style="height: 1px;">
	          <ul id="main-menu" class="nav navbar-nav navbar-right">
	            <li class="dropdown hidden-xs">
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                    <span class="glyphicon glyphicon-user padding-right-small" style="position:relative;top: 3px;"></span><%=request.getSession().getAttribute("username")%>
	                    
	                    <i class="fa fa-caret-down"></i>
	                </a>
	
	              <ul class="dropdown-menu">
	
	                <li><a tabindex="-1" href="login_out.jsp">注销</a></li>
	            </ul>
	            </li>
	          </ul>
	
	        </div>
        <%} %>
      </div>
    </div>


    <div class="sidebar-nav">
        <ul>
            <li><a href="index.jsp" class="nav-header"><i class="fa fa-home"></i> 首页</a></li>

                <li ><a a href="#"  data-target=".accounts-menu" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-user"></i> 账户<span class="label label-info">+2</span></a></li>
                <li ><ul class="accounts-menu nav nav-list collapse">
                  <%
                    if((String)request.getSession().getAttribute("username")==null){                   
                   %>
                  <li ><a  id="user_login" href="sign-in.html"><span  class="fa fa-caret-right"></span> 登陆</a></li>
                <%} %>
                <li ><a href="sign-up.html"><span class="fa fa-caret-right"></span> 注册</a></li>          
                <%
                   if((String)request.getSession().getAttribute("username")!=null){                   
                %>
                <li ><a  id="user_reset"  href="reset-password.html"><span class="fa fa-caret-right"></span>重置密码 </a></li>
                 <%}%>
            </ul></li>
             <%
            if((String)request.getSession().getAttribute("username")!=null){                   
              %>
            <li><a href="analysis.jsp?first=1" class="nav-header"><i class="fa fa-bar-chart-o"></i>数据分析</a></li>

            <li><a href="result.jsp" class="nav-header"><i class="fa fa-columns"></i>分析结果</a></li>
            <%} %>
            <li><a href="#" data-target=".legal-menu" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-fw fa-legal"></i> 法律信息<i class="fa fa-collapse"></i></a></li>
            <li><ul class="legal-menu nav nav-list collapse">
                <li ><a href="privacy.jsp"><span class="fa fa-caret-right"></span> 隐私政策</a></li>
                <li ><a href="terms.jsp"><span class="fa fa-caret-right"></span> 南航1613001班一队条款</a></li>
            </ul></li>

        </ul>
    </div>

    <div class="content">
        <div class="header">
            
            <h1 class="page-title">南航1613001班一队条款</h1>
                    <ul class="breadcrumb">
            <li><a href="index.jsp">首页</a></li>
            <li class="active">南航1613001班一队条款</li>
        </ul>

        </div>
        <div class="main-content">
            
<h3>Terms of Use</h3>
These Terms and Conditions constitute an agreement (“Agreement”) between you (“you”, “your”, “user”, “Customer”) and the Company.Avocado gumbo artichoke ricebean groundnut tigernut. Daikon kakadu plum water spinach garbanzo eggplant fava bean chard rock melon carrot rutabaga water chestnut broccoli courgette onion. 

<h3>Eligibility and Identity.</h3>
To be eligible to use our Services, you must be at least 13 years old. Sorrel jícama tomato silver beet wattle seed black-eyed pea garlic fennel tigernut okra beetroot shallot. Soko shallot melon dandelion bamboo shoot chickpea soybean pumpkin kakadu plum parsley ricebean grape courgette courgette jícama tatsoi. Black-eyed pea gourd tomatillo arugula cucumber celery mustard black-eyed pea cauliflower soybean rutabaga turnip groundnut.

<h3>Termination</h3>
You may terminate this Agreement at any time by ceasing all use of the Services and by notifying us. The Company may terminate this Agreement, at any time, without notice to you, if it believes, in its sole judgment, that you have breached or may breach any term or condition of this Agreement. Fennel garlic melon broccoli kohlrabi dulse black-eyed pea chicory watercress shallot bamboo shoot cucumber rutabaga ricebean gourd chickweed gumbo. Burdock fennel sorrel cress collard greens tomato tigernut salad chickweed yarrow water spinach catsear earthnut pea cabbage dulse potato. Onion courgette bitterleaf rutabaga tomatillo tigernut groundnut courgette water spinach tomato. Celery ricebean cabbage salsify caulie watercress cress collard greens potato chard gourd pea sprouts cucumber dulse gram. Leek summer purslane tatsoi catsear celtuce broccoli rabe onion zucchini.

<h3>Use of Services & Account</h3>
You represent and warrant that you possess the legal right and ability to enter into this Agreement. You agree not to use the Materials, Content, Services, and your Account for any unlawful or abusive purpose or in any way which interferes with our ability to provide Services to our customers, or which damages our property. Chickpea gourd coriander daikon zucchini lettuce tomatillo sierra leone bologi maize parsnip grape melon kohlrabi welsh onion. Celery wakame corn garlic courgette silver beet cabbage gram amaranth jícama bitterleaf. Ricebean bunya nuts prairie turnip water chestnut artichoke cauliflower watercress gourd cabbage okra broccoli rabe. Burdock leek sorrel radicchio azuki bean collard greens winter purslane broccoli rabe gourd water chestnut pumpkin gumbo. Azuki bean green bean kohlrabi kombu aubergine salsify lotus root turnip lentil radicchio nori eggplant sorrel. 

<h3>Modification to Service</h3>
The Company may change, suspend, or discontinue all or any part of the Service at any time, with or without reason. You acknowledge that the operation of the Service may from time to time encounter technical or other problems and may not necessarily continue uninterrupted or without technical or other errors and The Company shall not be responsible to you or others for any such interruptions, errors or problems or an outright discontinuance of the Service. 

<h3>Intellectual Property Ownership</h3>
All Materials, Services, Accounts, and content, including, but not limited to, policy information, text, software, music, sound, photographs, video, graphics, the arrangement of text and images, commercially produced information, and other material contained on the Site or through the Services (“Content”), are provided by The Company unless indicated otherwise. Welsh onion tigernut broccoli asparagus brussels sprout jícama eggplant earthnut pea cress chickpea gourd zucchini. Radicchio lentil cucumber groundnut endive kohlrabi winter purslane. Seakale plantain quandong celtuce shallot fennel seakale epazote groundnut dandelion.

<h3>Privacy</h3>
Please see our <a href="privacy.jsp">Privacy Policy</a> as set forth on the site.

<h3>About These Terms</h3>
<p>These Terms and Conditions are just a sample and are not legally binding. Real Terms of Services do not (usually) contain vegetables...</p>


            <footer>
                <hr>

                <!-- Purchase a site license to remove this link from the footer: http://www.portnine.com/bootstrap-themes -->
                <p class="pull-right"> <a  target="_blank">RPlato</a> 由 <a href="team-info.html" target="_blank">南航1613001班一队</a>设计</p>
                <p>© 2015 <a href="team-info.html" target="_blank">南航1613001班一队</a></p>
            </footer>
        </div>
    </div>


    <script src="lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
    </script>
    
  
</body></html>