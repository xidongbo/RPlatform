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
                 <li ><a href="team-info.jsp"><span class="fa fa-caret-right"></span> 南航1613001班一队介绍</a></li>
                <li ><a href="terms.jsp"><span class="fa fa-caret-right"></span> 南航1613001班一队条款</a></li>
            </ul></li>

        </ul>
    </div>

    <div class="content">
        <div class="header">
            
            <h1 class="page-title">隐私政策</h1>
                    <ul class="breadcrumb">
            <li><a href="index.jsp">首页</a></li>
            <li class="active">隐私政策</li>
        </ul>

        </div>
        <div class="main-content">
            
<h3>What we do with your data</h3>
Veggies sunt bona vobis, proinde vos postulo esse magis pea sprouts rutabaga komatsuna salad collard greens.

<h3>Use of Cookies</h3>
Catsear corn gumbo leek chickpea summer purslane chicory. Taro azuki bean broccoli rabe soybean endive chicory. Pumpkin salsify horseradish avocado cabbage tomatillo ricebean caulie turnip greens eggplant.

<h3>Use of Third Party Services</h3>
Sweet pepper pea sprouts mung bean cabbage radicchio silver beet coriander lentil groundnut jícama wattle seed black-eyed pea chicory broccoli rabe bamboo shoot. Kombu garlic watercress garbanzo squash plantain amaranth wattle seed tomatillo tigernut. Wakame watercress swiss chard bamboo shoot garlic wakame azuki bean lentil lettuce chicory horseradish eggplant gumbo. Swiss chard turnip jícama courgette fennel salsify brussels sprout zucchini sea lettuce desert raisin fava bean artichoke kale bell pepper watercress wakame black-eyed pea garlic. Lentil spring onion caulie welsh onion sweet pepper quandong potato wakame carrot taro artichoke prairie turnip eggplant.


<h3>Protection of Certain Personally-Identifying Information</h3>
Scallion burdock silver beet water spinach turnip watercress aubergine. Komatsuna scallion bush tomato prairie turnip amaranth cress fennel parsnip plantain rutabaga lettuce chickweed radish. Yarrow bell pepper radish tomatillo avocado brussels sprout leek garlic salad pea sprouts sorrel courgette chickweed courgette carrot fennel cress lotus root.

Brussels sprout water chestnut pea sprouts bell pepper bamboo shoot radicchio komatsuna celtuce chicory zucchini garlic groundnut epazote. Wakame kohlrabi radicchio artichoke shallot brussels sprout. Garlic garbanzo chicory welsh onion gram brussels sprout turnip endive.

Tatsoi chickweed pea zucchini endive sierra leone bologi shallot artichoke. Gumbo tomatillo peanut onion lentil broccoli aubergine asparagus maize kakadu plum sweet pepper watercress artichoke brussels sprout shallot. Mustard sweet pepper welsh onion corn summer purslane potato green bean lettuce garbanzo jícama salsify amaranth lotus root sierra leone bologi radicchio mustard. Kombu cucumber sweet pepper winter purslane courgette silver beet zucchini dandelion arugula tatsoi welsh onion gumbo pea beet greens broccoli rabe kohlrabi. Spinach endive maize water spinach burdock bell pepper jícama bush tomato asparagus chickweed celery mustard kale tatsoi.

Cress green bean potato bunya nuts water chestnut chicory rock melon jícama lotus root wattle seed eggplant coriander winter purslane spring onion. Leek coriander celery taro radicchio melon parsley tigernut water spinach maize brussels sprout cucumber arugula sweet pepper silver beet bell pepper kohlrabi. Cress gourd scallion salad jícama carrot water spinach garlic courgette black-eyed pea quandong tomatillo daikon epazote.

<h3>About This Privacy Policy</h3>
<p>This Privacy Policy is just a sample and are not legally binding. Real Privicy Policies do not (usually) contain vegetables...</p>


            <footer>
                <hr>

                <!-- Purchase a site license to remove this link from the footer: http://www.portnine.com/bootstrap-themes -->
                <p class="pull-right"> <a  target="_blank">RPlato</a> 由 <a href="team-info.jsp" target="_blank">南航1613001班一队</a>设计</p>
                <p>© 2015 <a href="team-info.jsp" target="_blank">南航1613001班一队</a></p>
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
