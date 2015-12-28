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
    
<body class=" theme-blue" > 
     
    
    <script type="text/javascript">
	    function infoshow(str){
		   document.getElementById("userinfo").style.visibility="display";
		   document.getElementById("userinfo_label").innerText=str;
		}
    </script>
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
            if(session.getAttribute("username")!=null){                   
        %>
	        <div  navbar-collapse collapse" style="height: 1px;">
	          <ul id="main-menu" class="nav navbar-nav navbar-right">
	            <li class="dropdown hidden-xs">
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                    <span class="glyphicon glyphicon-user padding-right-small" style="position:relative;top: 3px;"></span><%=session.getAttribute("username")%>
	                    
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
            
            <h1 class="page-title">R语言集成数据分析平台</h1>
                    <ul class="breadcrumb">

        </ul>

        </div>
        <div class="main-content">
            


<div class="faq-content">
    <h2>Most Frequently Asked</h2>
    <ol>
        <li><a href="#q1">What if I have a question?</a></li>
        <li><a href="#q2">Where can I get support?</a></li>
        <li><a href="#q3">How long does it take to fix a problem?</a></li>
        <li><a href="#q4">Who can help me out?</a></li>
        <li><a href="#q5">Where are you located?</a></li>
    </ol>

    <h2>About The Service</h2>
    <ol>
        <li><a href="#q11">How much does it cost?</a></li>
        <li><a href="#q12">Am I billed monthly or yearly?</a></li>
        <li><a href="#q13">What level of service do you have?</a></li>
        <li><a href="#q14">How do you secure your data?</a></li>
        <li><a href="#q15">Who can I contact for advertising?</a></li>
        <li><a href="#q16">Can I install custom fonts?</a></li>
        <li><a href="#q17">When does my service end?</a></li>
        <li><a href="#q18">Where can I find a custom design?</a></li>
    </ol>

    <hr>

    <h2>Most Frequently Asked Questions</h2>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q1">What if I have a question?</h3>
    <p>Tigernut avocado catsear beet greens silver beet coriander jícama cress. Desert raisin tomatillo turnip greens water chestnut parsnip dandelion cress gourd bell pepper garbanzo yarrow rutabaga fava bean spinach pea. Zucchini seakale bell pepper shallot silver beet tomatillo.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q2">Where can I get support?</h3>
    <p>Desert raisin sorrel grape courgette pumpkin epazote maize nori pea garlic garlic desert raisin corn lotus root. Bunya nuts bitterleaf melon wakame celtuce beetroot water chestnut corn maize leek azuki bean turnip ricebean bamboo shoot quandong taro courgette tomato. Tomato celtuce chickweed rutabaga beet greens sweet pepper aubergine carrot kakadu plum yarrow garbanzo tigernut sierra leone bologi okra pea caulie grape.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q3">How long does it take to fix a problem?</h3>
    <p>Courgette cabbage beetroot lentil garlic eggplant azuki bean potato onion cauliflower celery. Ricebean taro komatsuna fennel desert raisin sweet pepper cress bamboo shoot nori soko green bean catsear garlic black-eyed pea. Komatsuna water chestnut horseradish wakame scallion chard prairie turnip fennel quandong gram.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q4">Who can help me out?</h3>
    <p>Maize epazote fava bean cabbage winter purslane turnip greens summer purslane scallion wattle seed green bean ricebean sierra leone bologi jícama bamboo shoot. Turnip greens amaranth gourd winter purslane pea grape prairie turnip taro sea lettuce chicory. Plantain kakadu plum melon sea lettuce soko garlic chicory.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q5">Where are you located?</h3>
    <p>Sweet pepper quandong cucumber caulie eggplant water spinach. Azuki bean lentil aubergine sweet pepper komatsuna brussels sprout soybean tomato spring onion. Zucchini squash potato fennel bunya nuts broccoli rabe swiss chard. Brussels sprout gourd onion komatsuna fava bean mung bean earthnut pea seakale chard asparagus tomato scallion catsear.</p>
    
    <hr>

    <h2>About The Service</h2>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q11">How much does it cost?</h3>
    <p>Tigernut avocado catsear beet greens silver beet coriander jícama cress. Desert raisin tomatillo turnip greens water chestnut parsnip dandelion cress gourd bell pepper garbanzo yarrow rutabaga fava bean spinach pea. Zucchini seakale bell pepper shallot silver beet tomatillo.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q12">Am I billed monthly or yearly?</h3>
    <p>Desert raisin sorrel grape courgette pumpkin epazote maize nori pea garlic garlic desert raisin corn lotus root. Bunya nuts bitterleaf melon wakame celtuce beetroot water chestnut corn maize leek azuki bean turnip ricebean bamboo shoot quandong taro courgette tomato. Tomato celtuce chickweed rutabaga beet greens sweet pepper aubergine carrot kakadu plum yarrow garbanzo tigernut sierra leone bologi okra pea caulie grape.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q13">What level of service do you have?</h3>
    <p>Courgette cabbage beetroot lentil garlic eggplant azuki bean potato onion cauliflower celery. Ricebean taro komatsuna fennel desert raisin sweet pepper cress bamboo shoot nori soko green bean catsear garlic black-eyed pea. Komatsuna water chestnut horseradish wakame scallion chard prairie turnip fennel quandong gram.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q14">How do you secure your data?</h3>
    <p>Maize epazote fava bean cabbage winter purslane turnip greens summer purslane scallion wattle seed green bean ricebean sierra leone bologi jícama bamboo shoot. Turnip greens amaranth gourd winter purslane pea grape prairie turnip taro sea lettuce chicory. Plantain kakadu plum melon sea lettuce soko garlic chicory.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q15">Who can I contact for advertising?</h3>
    <p>Sweet pepper quandong cucumber caulie eggplant water spinach. Azuki bean lentil aubergine sweet pepper komatsuna brussels sprout soybean tomato spring onion. Zucchini squash potato fennel bunya nuts broccoli rabe swiss chard. Brussels sprout gourd onion komatsuna fava bean mung bean earthnut pea seakale chard asparagus tomato scallion catsear.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q16">Can I install custom fonts?</h3>
    <p>Salsify ricebean yarrow broccoli tomato mustard rock melon carrot garlic chicory spring onion prairie turnip azuki bean peanut gumbo welsh onion squash burdock. Fava bean black-eyed pea water chestnut celery soybean cress nori. Desert raisin horseradish carrot black-eyed pea spinach soybean silver beet.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q17">When does my service end?</h3>
    <p>Onion cabbage quandong seakale welsh onion mung bean pea sprouts scallion tatsoi bush tomato napa cabbage ricebean coriander parsnip beet greens chicory. Pea chard wattle seed black-eyed pea parsnip asparagus burdock chickweed jícama tomatillo radicchio plantain carrot tatsoi nori sorrel yarrow. Peanut avocado parsley celtuce salad jícama. Garbanzo winter purslane salsify bunya nuts kale onion. Squash kombu artichoke soko swiss chard water spinach.</p>
    <a href="#" style="float: right; line-height: 1.25em; display: inline-block; padding: .75em 0em;"><i class="fa fa-arrow-circle-up"></i> Top</a>
    <h3 id="q18">Where can I find a custom design?</h3>
    <p>Parsnip napa cabbage wakame sorrel lentil silver beet tatsoi bitterleaf pea sprouts zucchini bush tomato gumbo. Fennel desert raisin grape amaranth soko earthnut pea corn plantain celtuce taro komatsuna bunya nuts. Desert raisin tigernut komatsuna tomato bok choy gram plantain black-eyed pea potato chard parsnip beet greens lentil.</p>
</div>


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

