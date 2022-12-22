<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="keywords" content="">
    <meta name="description" content="">

    <title>Restaurant</title>

    <!-- Loading Bootstrap -->
    <link href="static/css/bootstrap.css" rel="stylesheet">

    <!-- Loading Template CSS -->
    <link href="static/css/style.css" rel="stylesheet">
    <link href="static/css/animate.css" rel="stylesheet">
    <link href="static/css/style-magnific-popup.css" rel="stylesheet">

    <!-- Fonts -->
    <link href="static/css/font-awesome.min.css" rel="stylesheet">
    <link href="static/css/icons-main.css" rel="stylesheet">
    <link href="static/css/icons-helper.css" rel="stylesheet">

    <!-- RS5.0 Main Stylesheet -->
    <link rel="stylesheet" type="text/css" href="static/css/settings.css">

    <!-- RS5.0 Layers and Navigation Styles -->
    <link rel="stylesheet" type="text/css" href="static/css/layers.css">
    <link rel="stylesheet" type="text/css" href="static/css/navigation.css">

    <!-- Google Fonts -->
    <link href='static/css/css.css' rel='stylesheet' type='text/css'>
    <link href='static/css/css1.css' rel='stylesheet' type='text/css'>
    <link href='static/css/css2.css' rel='stylesheet' type='text/css'>

    <!-- Font Favicon -->


    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->

    <!--headerIncludes-->
    <style>
        .tableButton{
            margin-top: 100px;
            display: flex;
            flex-direction: row;
            justify-content: space-around;
        }
        .tableAndDelete{
            display: flex;
            flex-direction: row;
        }
        .tableData{
            flex-basis: 90%;
        }
        .tableDelete{
            flex-basis: 10%;
        }
        form{
            display: flex;
            flex-direction: column;
        }
        table{
            border: black solid 2px;
        }
        tr{
            height: 60px;
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            justify-content: space-around;
            border-bottom: black solid 2px;
        }
        td{
            padding-top: 20px;
        }
        input{
            width: inherit;
            height: inherit;
        }
    </style>

</head>
<body>

<!--begin header -->
<header class="header">

    <!--begin nav -->
    <nav class="navbar navbar-default navbar-fixed-top">

        <!--begin container -->
        <div class="container">

            <!--begin navbar -->
            <div class="navbar-header">
                <button data-target="#navbar-collapse-02" data-toggle="collapse" class="navbar-toggle" type="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

                <a href="index.html" class="navbar-brand brand scrool"><img src="static/picture/logo.png"
                                                                            alt="logo"></a>
            </div>

            <div id="navbar-collapse-02" class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="index.html">首页</a></li>
                    <li><a href="/management?name=desk">桌台管理</a></li>
                    <li><a href="/management?name=customer">顾客管理</a></li>
                    <li><a href="/management?name=dish">菜品管理</a></li>
                    <!--                        <li><a href="reservations.html">Reservations</a></li>-->
                    <li><a href="/management?name=dishType">菜系管理</a></li> <!--跳转到以点订单-->
                </ul>
            </div>
            <!--end navbar -->

        </div>
        <!--end container -->

    </nav>
    <!--end nav -->

</header>
<!--end header -->

<!--begin section-white-->
<section class="section-white">

    <!--begin container-->
    <div class="container">
        <form action="/handle?name=${requestScope.tableName}&buttonName=${requestScope.action}" method="post" enctype="multipart/form-data">
            <div class="tableAndDelete">
                <table class="tableData">
                    <c:choose>
                        <c:when test="${requestScope.tableName == 'desk'}">
                            <tr>
                                <td>桌号</td>
                                <td>座位数</td>
                                <td>状态</td>
                            </tr>
                            <c:forEach items="${requestScope.tableData}" var="data">
                                <tr>
                                    <td><input type="text" name="desk-${data.id}-id" value="${data.id}" disabled></td>
                                    <td><input type="text" name="desk-${data.id}-seatNum" value="${data.seatNum}"></td>
                                    <td><select name="desk-${data.id}-status">
                                        <c:if test="${data.status == 0}">
                                            <option value="0" selected>空闲</option>
                                            <option value="1">有人</option>
                                        </c:if>
                                        <c:if test="${data.status == 1}">
                                            <option value="0">空闲</option>
                                            <option value="1" selected>有人</option>
                                        </c:if>
                                    </select></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${requestScope.action == 'insert'}">
                                <tr>
                                    <td><input name="desk-insert-id" type="text" disabled></td>
                                    <td><input name="desk-insert-seatNum" type="text"></td>
                                    <td><select name="desk-insert-status">
                                        <option value="0">空闲</option>
                                        <option value="1">有人</option>
                                    </select></td>
                                </tr>
                            </c:if>
                        </c:when>
                        <c:when test="${requestScope.tableName == 'customer'}">
                            <tr>
                                <td>顾客ID</td>
                                <td>姓名</td>
                                <td>密码</td>
                                <td>电话</td>
                            </tr>
                            <c:forEach items="${requestScope.tableData}" var="data">
                                <tr>
                                    <td><input type="text" name="customer-${data.id}-id" value="${data.id}" disabled></td>
                                    <td><input type="text" name="customer-${data.id}-name" value="${data.name}"></td>
                                    <td><input type="text" name="customer-${data.id}-password" value="${data.password}"></td>
                                    <td><input type="text" name="customer-${data.id}-phone" value="${data.phone}"></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${requestScope.action == 'insert'}">
                                <tr>
                                    <td><input name="customer-insert-id" type="text" disabled></td>
                                    <td><input name="customer-insert-name" type="text"></td>
                                    <td><input name="customer-insert-password"  type="text"></td>
                                    <td><input name="customer-insert-phone" type="text"></td>
                                </tr>
                            </c:if>
                        </c:when>
                        <c:when test="${requestScope.tableName == 'dish'}">
                            <tr>
                                <td>菜品ID</td>
                                <td>菜名</td>
                                <td>价格</td>
                                <td>所属菜系</td>
                                <td>图片</td>
                            </tr>
                            <c:forEach items="${requestScope.tableData}" var="data">
                                <tr>
                                    <td><input type="text" name="dish-${data.id}-id" value="${data.id}" disabled></td>
                                    <td><input type="text" name="dish-${data.id}-dishName" value="${data.dishName}"></td>
                                    <td><input type="text" name="dish-${data.id}-price" value="${data.price}"></td>
                                    <td><select name="dish-${data.id}-dishTypeId">
                                        <c:forEach begin="0" end="${requestScope.dishTypes.size() - 1}" var="i">
                                            <c:if test="${requestScope.dishTypes[i].id == data.dishTypeId}">
                                                <option value="${requestScope.dishTypes[i].id}" selected>${requestScope.dishTypes[i].name}</option>
                                            </c:if>
                                            <c:if test="${requestScope.dishTypes[i].id != data.dishTypeId}">
                                                <option value="${requestScope.dishTypes[i].id}">${requestScope.dishTypes[i].name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select></td>
                                    <td><input type="file" name="dish-${data.id}-picture" value="${data.picture}"></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${requestScope.action == 'insert'}">
                                <tr>
                                    <td><input name="dish-insert-id" type="text" disabled></td>
                                    <td><input name="dish-insert-dishName" type="text"></td>
                                    <td><input name="dish-insert-price" type="text"></td>
                                    <td><select name="dish-insert-dishTypeId">
                                        <c:forEach begin="0" end="${requestScope.dishTypes.size() - 1}" var="i">
                                            <option value="${requestScope.dishTypes[i].id}">${requestScope.dishTypes[i].name}</option>
                                        </c:forEach>
                                    </select></td>
                                    <td><input type="file" name="dish-insert-picture" value="upload"></td>
                                </tr>
                            </c:if>
                        </c:when>
                        <c:when test="${requestScope.tableName == 'dishType'}">
                            <tr>
                                <td>菜品ID</td>
                                <td>菜品名</td>
                            </tr>
                            <c:forEach items="${requestScope.tableData}" var="data">
                                <tr>
                                    <td><input type="text" name="dishType-${data.id}-id" value="${data.id}" disabled></td>
                                    <td><input type="text" name="dishType-${data.id}-name" value="${data.name}"></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${requestScope.action == 'insert'}">
                                <tr>
                                    <td><input name="dishType-insert-id" type="text" disabled></td>
                                    <td><input name="dishType-insert-name" type="text"></td>
                                </tr>
                            </c:if>
                        </c:when>
                    </c:choose>
                </table>
                <c:if test="${requestScope.action == 'delete'}">
                    <table class="tableDelete">
                        <tr><td>select</td></tr>
                        <c:forEach begin="1" end="${requestScope.tableData.size()}" step="1" var="i">
                            <tr><td><input type="checkbox" name="deleteBox" value="${requestScope.tableData[i-1].id}"></td></tr>
                        </c:forEach>
                    </table>
                </c:if>
            </div>
            <div class="tableButton">
                <c:if test="${requestScope.action == 'update'}">
                    <button type="button" onclick="insertRefresh()" name="insert">insert</button>
                    <button type="button" onclick="deleteRefresh()" name="delete">delete</button>
                    <button type="submit" name="update">update</button>
                </c:if>
                <c:if test="${requestScope.action != 'update'}">
                    <button type="button" onclick="backRefresh()" name="BACK">BACK</button>
                    <button type="submit" name="OK">OK</button>
                </c:if>
            </div>
        </form>

    </div>
    <!--end container-->

</section>
<!--end section-white-->

<!--begin footer -->
<div class="footer">

    <!--begin container -->
    <div class="container">

        <!--begin row -->
        <div class="row footer-top">

            <!--begin col-md-3 -->
            <div class="col-md-3 padding-bottom-50">

                <h4>ABOUT US</h4>

                <p>Quis autem velis et reprehender etims quiste voluptate velit esse quam nihil etsa illum sedit
                    consequatur quias.</p>

                <a href="about.html" class="btn btn-lg btn-yellow-x-small scrool">OUR STORY</a>

            </div>
            <!--end col-md-3 -->

            <!--begin col-md-3 -->
            <div class="col-md-3 padding-bottom-50">

                <h4>LATEST RECIPES</h4>

                <ul class="footer-list">

                    <li class="first"><a href="#" target="blank">Cheddar Cheese Cauliflower Tots</a></li>

                    <li><a href="#" target="blank">Garlic Chicken &amp; White Wine Sauce</a></li>

                    <li><a href="#" target="blank">Spinach Mozzarella Grilled Cheese</a></li>

                    <li><a href="#" target="blank">Mini Chicken Roasted Cups</a></li>

                </ul>

            </div>
            <!--end col-md-3 -->

            <!--begin col-md-3 -->
            <div class="col-md-3 padding-bottom-50">

                <h4>FEATURED PLATES</h4>

                <ul class="footer-gallery">

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram1-large.jpg">
                            <img src="static/picture/instagram1.jpg" alt="instagram">
                        </a>
                    </li>

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram6-large.jpg">
                            <img src="static/picture/instagram6.jpg" alt="instagram">
                        </a>
                    </li>

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram2-large.jpg">
                            <img src="static/picture/instagram2.jpg" alt="instagram">
                        </a>
                    </li>

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram4-large.jpg">
                            <img src="static/picture/instagram4.jpg" alt="instagram">
                        </a>
                    </li>

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram5-large.jpg">
                            <img src="static/picture/instagram5.jpg" alt="instagram">
                        </a>
                    </li>

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram3-large.jpg">
                            <img src="static/picture/instagram3.jpg" alt="instagram">
                        </a>
                    </li>

                </ul>

            </div>
            <!--end col-md-3 -->

            <!--begin col-md-3 -->
            <div class="col-md-3 padding-bottom-50">

                <h4>CONTACT DETAILS</h4>

                <p>Quis autem velis eti reprehender etimes quiste volupta velit esse quam nihil.</p>

                <p class="contact_info"><i class="fa fa-map-marker"></i> Oxford Street, London, UK, N1 1ED</p>

                <p class="contact_info"><i class="fa fa-phone"></i> +44 987 654 321 / +44 123 456 789</p>

                <p class="contact_info"><i class="fa fa-envelope-square"></i> <a href="mailto:contact@restaurant.com">contact@restaurant.com</a>
                </p>

            </div>
            <!--end col-md-3 -->

        </div>
        <!--end row -->

        <!--begin row -->
        <div class="row">

            <!--begin footer-bottom -->
            <div class="footer-bottom">

                <!--begin col-md-5 -->
                <div class="col-md-5">

                    <!--begin copyright -->
                    <div class="copyright ">
                        <p>Copyright &copy; 2022.Company name All rights reserved.<a target="_blank"
                                                                                     href="https://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a>
                        </p>
                    </div>
                    <!--end copyright -->

                </div>
                <!--end col-md-5 -->

                <!--begin col-md-2 -->
                <div class="col-md-2 text-center">

                    <a href="#hero-section" class="scrool top-scroll"><i class="fa fa-angle-double-up"></i></a>

                </div>
                <!--end col-md-2 -->

                <!--begin col-md-5 -->
                <div class="col-md-5">

                    <!--begin footer_social -->
                    <ul class="footer_social">
                        <li>
                            Follow Us:
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-twitter"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-pinterest"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-facebook"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-instagram"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-youtube"></i>
                            </a>
                        </li>
                    </ul>
                    <!--end footer_social -->

                </div>
                <!--end col-md-5 -->

            </div>
            <!--end footer-bottom -->

        </div>
        <!--end row -->

    </div>
    <!--end container -->

</div>
<!--end footer -->


<!-- Load JS here for greater good =============================-->
<script src="static/js/jquery-1.11.3.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/bootstrap-select.js"></script>
<script src="static/js/bootstrap-switch.js"></script>
<script src="static/js/jquery.magnific-popup.min.js"></script>
<script src="static/js/jquery.nav.js"></script>
<script src="static/js/jquery.scrollTo-min.js"></script>
<script src="static/js/SmoothScroll.js"></script>
<script src="static/js/wow.js"></script>

<!-- begin custom script-->
<script src="static/js/custom.js"></script>
<script src="static/js/plugins.js"></script>

</body>
<script>
    function insertRefresh(){
        window.location.replace("/management?name=${requestScope.tableName}&buttonName=insert");
    }
    function deleteRefresh(){
        window.location.replace("/management?name=${requestScope.tableName}&buttonName=delete");
    }
    function backRefresh(){
        window.location.replace("/management?name=${requestScope.tableName}")
    }
</script>
</html>